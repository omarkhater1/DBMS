CREATE TABLE Hotel_Chain (
    Hotel_Chain_ID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone INTEGER NOT NULL,
    Number_of_hotels INTEGER CHECK (Number_of_hotels > 0)
);

CREATE TABLE Hotel (
    Hotel_ID SERIAL PRIMARY KEY,
    Hotel_Chain_ID INTEGER REFERENCES Hotel_Chain (Hotel_Chain_ID) ON DELETE CASCADE,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone INTEGER NOT NULL,
    Number_of_rooms INTEGER CHECK (Number_of_rooms > 0),
    Category INTEGER CHECK (Category BETWEEN 1 AND 5),
    Area VARCHAR(255) NOT NULL
);

CREATE TABLE Room (
    Room_ID SERIAL PRIMARY KEY,
    Hotel_ID INTEGER REFERENCES Hotel (Hotel_ID) ON DELETE CASCADE,
    Price DECIMAL(10, 2) CHECK (Price >= 0),
    Amenities VARCHAR(255),
    Capacity INTEGER CHECK (Capacity > 0),
    the_view VARCHAR(255),
    Extendable BOOLEAN,
    Damages VARCHAR(255),
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Employee (
    Employee_ID SERIAL PRIMARY KEY,
    Hotel_ID INTEGER REFERENCES Hotel (Hotel_ID) ON DELETE CASCADE,
    Name VARCHAR(255) CHECK (LENGTH(Name) >= 2),
    Address VARCHAR(255) NOT NULL,
    SIN CHAR(9) NOT NULL,
    Position VARCHAR(255) NOT NULL
);

CREATE TABLE Customer (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(255) CHECK (LENGTH(Name) >= 2),
    Address VARCHAR(255) NOT NULL,
    SIN CHAR(9) NOT NULL,
    Registration_date DATE NOT NULL
);

CREATE TABLE Booking (
    Booking_ID SERIAL PRIMARY KEY,
    Customer_ID INTEGER REFERENCES Customer (Customer_ID) ON DELETE CASCADE,
    Room_ID INTEGER REFERENCES Room (Room_ID) ON DELETE CASCADE,
    Date DATE NOT NULL CHECK (Date >= CURRENT_DATE),
    Time TIME NOT NULL
);

CREATE TABLE Renting (
    Renting_ID SERIAL PRIMARY KEY,
    Customer_ID INTEGER REFERENCES Customer (Customer_ID) ON DELETE CASCADE,
    Room_ID INTEGER REFERENCES Room (Room_ID) ON DELETE CASCADE,
    Date DATE NOT NULL,
    Time TIME NOT NULL
);
