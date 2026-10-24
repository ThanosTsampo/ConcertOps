-- Advanced Analytics Report
-- Συνδυασμός JOINs, Subqueries, Aggregate Functions και String Functions
SELECT 
    t.ticket_id,
    UPPER(a.artist_name) AS artist,
    a.genre,
    v.venue_name,
    v.city,
    t.attendee_name,
    t.ticket_price,
    t.seat_section,
    -- Υπολογισμός μέσου όρου τιμής ανά είδος μουσικής (Subquery)
    (SELECT ROUND(AVG(ticket_price), 2) 
     FROM Tickets t2 
     JOIN Artists a2 ON t2.artist_id = a2.artist_id 
     WHERE a2.genre = a.genre) AS avg_genre_ticket_price,
    -- Formatting ημερομηνίας
    DATE_FORMAT(t.purchase_date, '%Y-%m-%d %H:%i') AS formatted_purchase_date
FROM Tickets t
INNER JOIN Artists a ON t.artist_id = a.artist_id
INNER JOIN Venues v ON t.venue_id = v.venue_id
ORDER BY t.ticket_price DESC;