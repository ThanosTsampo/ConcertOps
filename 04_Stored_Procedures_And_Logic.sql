USE ConcertOps;

-- Δημιουργία Stored Procedure για την ασφαλή προσθήκη νέου καλλιτέχνη
DELIMITER //

CREATE PROCEDURE sp_AddArtist(
    IN p_artist_name VARCHAR(100),
    IN p_genre VARCHAR(50),
    IN p_contact_email VARCHAR(100)
)
BEGIN
    -- Έλεγχος αν ο καλλιτέχνης υπάρχει ήδη
    IF NOT EXISTS (SELECT 1 FROM Artists WHERE artist_name = p_artist_name) THEN
        INSERT INTO Artists (artist_name, genre, contact_email)
        VALUES (p_artist_name, p_genre, p_contact_email);
        
        SELECT CONCAT('Success: Artist "', p_artist_name, '" was added successfully.') AS Result;
    ELSE
        SELECT CONCAT('Error: Artist "', p_artist_name, '" already exists in the database.') AS Result;
    END IF;
END //

DELIMITER ;

-- Δοκιμή κλήσης της Stored Procedure
CALL sp_AddArtist('The Weeknd', 'Pop/R&B', 'contact@theweeknd.com');