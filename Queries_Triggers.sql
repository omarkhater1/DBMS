--Query 1: INSERT new hotel chain
INSERT INTO Hotel_Chain (Name, Address, Email, Phone, Number_of_hotels)
VALUES ('Hotel Chain F', '123 Chain F St', 'contact@chain-f.com', 1224567890, 10);

--Query 2: DELETE a hotel
DELETE FROM Hotel
WHERE Hotel_ID = 3 AND
    NOT EXISTS (SELECT 1 FROM Booking WHERE Booking.Room_ID IN (SELECT Room_ID FROM Room WHERE Room.Hotel_ID = 3)) AND
    NOT EXISTS (SELECT 1 FROM Renting WHERE Renting.Room_ID IN (SELECT Room_ID FROM Room WHERE Room.Hotel_ID = 3));

--Query 3: UPDATE rooms price
UPDATE Room
SET Price = 200.00
WHERE Room_ID = 2;

--Query 4: INSERT a new customer
INSERT INTO Customer (Name, Address, SIN, Registration_date)
VALUES ('John Doe', '456 Main Street, New York, NY', '123456789', '2023-04-15');

--Trigger 1: Update room availability after new booking
CREATE OR REPLACE FUNCTION update_room_availability_on_booking() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Room SET available = false WHERE Room_ID = NEW.Room_ID;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Room SET available = true WHERE Room_ID = OLD.Room_ID;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_availability_on_booking
AFTER INSERT OR DELETE ON Booking
FOR EACH ROW
EXECUTE FUNCTION update_room_availability_on_booking();

--Test for trigger one
/*
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
INSERT INTO Booking (Customer_ID, Room_ID, Date, Time)
VALUES (1, 1, '2023-05-01', '14:00:00');
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
DELETE FROM Booking WHERE Booking_ID = 1;
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
*/

--Trigger 2: Update room availabiloity after new renting
CREATE OR REPLACE FUNCTION update_room_availability_on_renting() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE Room SET available = false WHERE Room_ID = NEW.Room_ID;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE Room SET available = true WHERE Room_ID = OLD.Room_ID;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_room_availability_on_renting
AFTER INSERT OR DELETE ON Renting
FOR EACH ROW
EXECUTE FUNCTION update_room_availability_on_renting();

--Test for trigger 2:
/*
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
INSERT INTO Renting (Customer_ID, Room_ID, Date, Time)
VALUES (1, 1, '2023-05-01', '14:00:00');
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
DELETE FROM Renting WHERE Renting_ID = 1;
SELECT Room_ID, available FROM Room WHERE Room_ID = 1;
*/



