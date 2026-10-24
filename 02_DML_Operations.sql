USE ConcertOps;

-- 1. INSERT DATA: Χώροι Εκδηλώσεων (Venues)
INSERT INTO Venues (venue_name, city, capacity) VALUES
('OAKA Arena', 'Athens', 18000),
('Panathenaic Stadium', 'Athens', 45000),
('Palaio Faliro Tae Kwon Do', 'Athens', 8000),
('Moni Lazariston', 'Thessaloniki', 6000);

-- 2. INSERT DATA: Καλλιτέχνες (Artists)
INSERT INTO Artists (artist_name, genre, contact_email) VALUES
('Iron Maiden', 'Heavy Metal', 'management@ironmaiden.com'),
('Coldplay', 'Alternative Rock', 'info@coldplay.com'),
('Eleni Foureira', 'Pop', 'booking@foureira.gr'),
('Pyx Lax', 'Greek Rock', 'contact@pyxlax.gr');

-- 3. INSERT DATA: Εισιτήρια (Tickets)
-- Αυτές οι εγγραφές θα πυροδοτήσουν ΑΥΤΟΜΑΤΑ τον TRIGGER trg_after_ticket_insert!
INSERT INTO Tickets (venue_id, artist_id, attendee_name, purchase_date, ticket_price, seat_section) VALUES
(1, 1, 'Nikos Papadopoulos', '2026-05-10 14:30:00', 85.00, 'VIP-A'),
(1, 1, 'Maria Georgiou', '2026-05-11 10:15:00', 65.00, 'GA-Standing'),
(2, 2, 'Giannis Antoniou', '2026-06-01 18:00:00', 120.00, 'Golden Circle'),
(3, 3, 'Eleni Dimitriou', '2026-06-15 20:45:00', 35.00, 'Zone-B'),
(4, 4, 'Kostas Vassiliou', '2026-07-02 11:20:00', 25.00, 'General');

-- 4. UPDATE OPERATION: Ενημέρωση τιμής εισιτηρίου λόγω αναβάθμισης θέσης
UPDATE Tickets 
SET ticket_price = 95.00, seat_section = 'VIP-B' 
WHERE ticket_id = 2;

-- 5. DELETE OPERATION: Ακύρωση δοκιμαστικής εγγραφής καλλιτέχνη
DELETE FROM Artists 
WHERE artist_id = 4 AND artist_name = 'Pyx Lax' AND artist_id NOT IN (SELECT DISTINCT artist_id FROM Tickets WHERE artist_id IS NOT NULL);