USE property;


-- What is the length of stays for each booking? Add a new column to show this.
-- Use ALTER and UPDATE tables
-- stayDuration is calculated using in-built date function DATEDIFF

ALTER TABLE bookingsFeb
ADD stayDuration INT;

UPDATE bookingsFeb
SET bookingsFeb.stayDuration = DATEDIFF(dateDepart, dateArrive);

SELECT * FROM bookingsFeb;  -- display table with new column

-- Query: What is the maximum duration of stay and minimum duration of stays?
SELECT  MAX(stayDuration) AS maxStayDays, MIN(stayDuration) AS minStayDays
FROM bookingsFeb;

-- How many properties does each town have listed?
-- Add new column to towns table to display total number of properties for each town.

ALTER TABLE towns
ADD COLUMN totalProperties INT DEFAULT 0;

UPDATE towns t
SET totalProperties = (
	SELECT COUNT(*) FROM properties p
	WHERE p.townID = t.townID
	);

SELECT * FROM towns;


-- From the previous query, Maldon has no listing.
-- The agents want to delete this town from the towns table as it is no longer active.

DELETE FROM towns t
WHERE t.townID = 9;

SELECT * FROM towns;  -- shows Maldon removed

-- There is a call to change the most recent booking as the dateDepart was incorrect.
-- Using REPLACE

UPDATE bookingsFeb
SET dateDepart = REPLACE(dateDepart, '2025-02-20', '2025-02-21')
WHERE bookingID = 12;

SELECT DISTINCT bookingID, propertyID, dateDepart -- check change specifically if field has been changed
FROM bookingsFeb
WHERE bookingID = 12;

-- Agent would now like to easily view the details of the bookings within each town and then just details from Colchester
-- Right Join used to only form a view table of properties with bookings and leave out the data that have no bookings.

CREATE VIEW propertyBookings AS
SELECT t.townName, p.propertyID, p. listingNo, p.streetName, b.dateArrive, b.dateDepart
FROM towns t
RIGHT JOIN properties p ON t.townID = p.townID
RIGHT JOIN bookingsFeb b ON p.propertyID = b.propertyID-- right join to show all properties with listings, and leave out towns without listings
ORDER BY t.townID ASC;

SELECT * FROM propertyBookings;

SELECT * FROM propertyBookings
WHERE townName = "Colchester";  -- to find specifically  colchester properties


-- What is the price per room per day for each property and list only the top 3 most expensive property and the towns they are in
SELECT p.propertyID, p.listingNo,  p.no_of_rooms, t.townNAME, ROUND(SUM(b.totalPaid£/b.stayDuration/p.no_of_rooms), 2) AS daily_price_per_room
FROM properties p
JOIN bookingsFeb b ON p.propertyID = b.propertyID
JOIN towns t ON t.townID = p.townID
GROUP BY b.propertyID
ORDER BY daily_price_per_room DESC
LIMIT 3;

-- What is the average price paid per property in Basildon?
SELECT  t.townName, ROUND(AVG(b.totalpaid£),2) AS average_price
FROM bookingsFeb b
JOIN properties p ON b.propertyID = p.propertyID
JOIN towns t ON p.townID = t.townID
WHERE t.townName =  'Basildon';


-- The Agents now need to promote the listings which had no booking.
-- Which properties did not have bookings?
-- use LEFT JOIN to find properties where booking ID is NULL - i.e no bookings

SELECT p.propertyID, p.listingNo, b.bookingID
FROM properties p
LEFT JOIN bookingsFeb b ON p.propertyID = b.propertyID
WHERE b.bookingID IS NULL
ORDER BY p.listingNo ASC;

-- What is the revenue of each town?
-- Create a stored function to calculate revenue from each town,
-- Stored procedure using the stored function that agents can run the view of total revenue of each town each time there is an update


DELIMITER //

CREATE FUNCTION calculate_town_revenue(townName VARCHAR(255))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN
	DECLARE total_revenue DECIMAL (10,2) DEFAULT 0;
    SELECT SUM(b.totalPaid£) INTO total_revenue
    FROM bookingsFeb b
    JOIN properties p ON b.propertyID = p.propertyID
    JOIN towns t ON t.townID = p.townID
    WHERE t.townName = townName;
    RETURN (total_revenue);
END
//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE viewTownRevenues()
BEGIN
	SELECT townID, townName,
	       calculate_town_revenue(townName) AS townRevenue,
	       CURRENT_TIMESTAMP() AS lastUpdate
	FROM towns
	ORDER BY townRevenue DESC;
END
//

DELIMITER ;

CALL viewTownRevenues();
