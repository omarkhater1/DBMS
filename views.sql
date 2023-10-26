--View 1: Number of available rooms per area:
CREATE VIEW available_rooms_per_area AS
SELECT h.AREA, COUNT(r.Room_ID) AS available_rooms
FROM Hotel h
JOIN Room r ON h.Hotel_ID = r.Hotel_ID
GROUP BY h.AREA;

--TEST: SELECT * FROM available_rooms_per_area;


--View 2: The capacity of all the rooms of a specific hotel:
CREATE VIEW room_capacity_per_hotel AS
SELECT h.Hotel_ID, h.Name AS hotel_name, SUM(r.Capacity) AS total_capacity
FROM Hotel h
JOIN Room r ON h.Hotel_ID = r.Hotel_ID
GROUP BY h.Hotel_ID, h.Name;

--TEST: SELECT * FROM room_capacity_per_hotel WHERE Hotel_ID = 11
