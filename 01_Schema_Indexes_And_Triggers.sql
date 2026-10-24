CREATE DATABASE IF NOT EXISTS ConcertOps;
USE ConcertOps;

CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    contact_email VARCHAR(100) NOT NULL
);

CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_id INT,
    artist_id INT,
    attendee_name VARCHAR(100) NOT NULL,
    purchase_date DATETIME NOT NULL,
    ticket_price DECIMAL(8,2) NOT NULL,
    seat_section VARCHAR(20),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

CREATE TABLE AuditLogs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    action_message VARCHAR(255),
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes για Performance Optimization
CREATE INDEX idx_artist_genre ON Artists(genre);
CREATE INDEX idx_ticket_purchase ON Tickets(purchase_date);
CREATE INDEX idx_attendee_name ON Tickets(attendee_name);

-- TRIGGER: Αυτόματη καταγραφή κάθε νέας πώλησης εισιτηρίου (AFTER INSERT)
DELIMITER //
CREATE TRIGGER trg_after_ticket_insert
AFTER INSERT ON Tickets
FOR EACH ROW
BEGIN
    INSERT INTO AuditLogs (action_message)
    VALUES (CONCAT('New ticket sold for attendee: ', NEW.attendee_name, ' with price: ', NEW.ticket_price));
END //
DELIMITER ;