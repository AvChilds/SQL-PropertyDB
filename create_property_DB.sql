
-- An essex-based short-term lettings company wants to track the properties that they currently list in a booking website.
-- 3 tables were initially created:
-- Table 1 for the towns that they cover,
-- Table 2 is for properties that they have have listed in the website
-- Table 3 for the booking details in Feb


DROP DATABASE IF EXISTS property;

CREATE DATABASE property;
USE property;

-- create table of number of available properties in each town
CREATE TABLE towns (
	townID INT NOT NULL AUTO_INCREMENT,
	townName VARCHAR (255) NOT NULL,
	PRIMARY KEY (townID)
);


INSERT INTO towns
(townID, townName)
values
	(1, 'Basildon'),
	(2, 'Thurrock'),
	(3, 'Brentwood'),
	(4, 'Chelmsford'),
	(5, 'Colchester'),
	(6, 'Braintree'),
	(7, 'Rochford'),
	(8, 'Southend-on-sea'),
    (9, 'Maldon')
;

SELECT * FROM towns;

-- create table of properties listed for rent
CREATE TABLE properties(
	propertyID INT NOT NULL AUTO_INCREMENT,
    listingNo INT NOT NULL UNIQUE, -- ensures the listingNo is unique and not duplicated
    streetName VARCHAR(255) DEFAULT 'unknown',
	townID INT,
    no_of_rooms INT CHECK (no_of_rooms > 0), -- no of rooms have to be greater than 0, not negative
	PRIMARY KEY (propertyID),
    FOREIGN KEY (townID) REFERENCES towns (townID)
);

INSERT INTO properties
(propertyID, listingNo, townID, streetName, no_of_rooms)
values
(1, 11586, 1, "Marina Bay", 3),
(2, 11684, 2, "Willingale Avenue", 2),
(3, 12598, 1, "Victoria Avenue", 3),
(4, 12667, 5, "London Road", 2),
(5, 23546, 3, "Eastwood Road",  4),
(6, 24215, 8, "Mountdale Gardens", 1),
(7, 25631, 2, "Durham Vale", 2),
(8, 32645, 4, "Juliet Drive", 3),
(9, 45134, 3, "Ferry Street", 2),
(10, 46312, 4, "Church Road", 3),
(11, 57846, 7, "Louis Drive East", 2),
(12, 59456, 8, "Dingle Gardens", 1),
(13, 59965, 6, "Blanchland Avenue", 3),
(14, 67976, 7, "Caterhouse Road", 3),
(15, 68554, 5, "High Road", 2),
(16, 69974, 3, "Cookie Street", 3),
(17, 72794, 6, "Coronation Close", 2),
(18, 75894, 5, "Hatfield Boulevard", 4),
(19, 88467, 4, "Amery Place", 3),
(20, 89797, 7, "King Charles Avenue", 4)
;

SELECT * FROM properties;

-- create table of bookings in february
CREATE TABLE bookingsFeb (
	bookingID INT NOT NULL AUTO_INCREMENT,
    propertyID INT NOT NULL,
	dateArrive DATE,
    dateDepart DATE,
    totalPaid£ DECIMAL (10, 2)  CHECK (totalPaid£ > 0),
    PRIMARY KEY (bookingID),
    FOREIGN KEY (propertyID) REFERENCES properties(propertyID)
);

INSERT INTO bookingsFeb
(propertyID, dateArrive, dateDepart, totalPaid£)
values
(1, '2025-02-01', '2025-02-05', 450),
(3, '2025-02-01', '2025-02-04', 360),
(2, '2025-02-02', '2025-02-04', 220),
(5, '2025-02-04', '2025-02-06', 540),
(8, '2025-02-05', '2025-02-10', 390),
(11, '2025-02-06', '2025-02-09', 340),
(1, '2025-02-08', '2025-02-11', 360),
(12, '2025-02-08', '2025-02-12', 320),
(15, '2025-02-13', '2025-02-16', 300),
(3, '2025-02-14', '2025-02-16', 220),
(18, '2025-02-14', '2025-02-17', 480),
(15, '2025-02-16', '2025-02-20', 420)
;

SELECT * FROM bookingsFeb;

