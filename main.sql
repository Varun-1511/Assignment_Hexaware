-- Create database
CREATE DATABASE IF NOT EXISTS TicketBookingSystem;

-- Use the database
USE TicketBookingSystem;

-- Create Venue table
CREATE TABLE IF NOT EXISTS Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(255),
    address VARCHAR(255)
);

-- Create Event table
CREATE TABLE IF NOT EXISTS Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(255),
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10, 2),
    event_type ENUM('Movie', 'Sports', 'Concert'),
    booking_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

-- Create Customer table
CREATE TABLE IF NOT EXISTS Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    booking_id INT,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Create Booking table
CREATE TABLE IF NOT EXISTS Booking (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10, 2),
    booking_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);

-- Sample data for Venue table
INSERT INTO Venue (venue_name, address) VALUES
('Stadium A', '123 Main Street'),
('Theater B', '456 Broadway'),
('Arena C', '789 Park Avenue'),
('Auditorium D', '101 Oak Lane'),
('Convention Center E', '202 Elm Street'),
('Gymnasium F', '303 Maple Avenue'),
('Pavilion G', '404 Pine Street'),
('Ballroom H', '505 Cedar Avenue'),
('Clubhouse I', '606 Birch Lane'),
('Stadium J', '707 Spruce Street');

-- Sample data for Event table
INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('Movie Night', '2024-05-01', '18:00:00', 1, 200, 150, 15.00, 'Movie'),
('Football Game', '2024-05-02', '15:30:00', 3, 50000, 20000, 25.00, 'Sports'),
('Concert Night', '2024-05-03', '20:00:00', 2, 1000, 800, 50.00, 'Concert'),
('Basketball Game', '2024-05-04', '19:00:00', 6, 15000, 10000, 30.00, 'Sports'),
('Theater Play', '2024-05-05', '19:30:00', 4, 300, 200, 35.00, 'Concert'),
('Rock Concert', '2024-05-06', '21:00:00', 5, 1500, 1200, 40.00, 'Concert'),
('Cricket Match', '2024-05-07', '14:00:00', 7, 30000, 25000, 20.00, 'Sports'),
('Stand-up Comedy', '2024-05-08', '20:30:00', 8, 500, 300, 25.00, 'Concert'),
('Tennis Tournament', '2024-05-09', '11:00:00', 9, 1000, 600, 30.00, 'Sports'),
('Broadway Show', '2024-05-10', '19:00:00', 10, 400, 300, 45.00, 'Concert');

-- Sample data for Customer table
INSERT INTO Customer (customer_name, email, phone_number) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '987-654-3210'),
('Michael Johnson', 'michael.johnson@example.com', '111-222-3333'),
('Emily Davis', 'emily.davis@example.com', '444-555-6666'),
('Christopher Wilson', 'christopher.wilson@example.com', '777-888-9999'),
('Jessica Martinez', 'jessica.martinez@example.com', '101-202-3030'),
('David Anderson', 'david.anderson@example.com', '404-505-6060'),
('Sarah Taylor', 'sarah.taylor@example.com', '707-808-9090'),
('Matthew Brown', 'matthew.brown@example.com', '121-212-1212'),
('Jennifer Lee', 'jennifer.lee@example.com', '131-415-1617');

-- Sample data for Booking table
INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(1, 1, 4, 60.00, '2024-04-28'),
(2, 2, 5, 125.00, '2024-04-28'),
(3, 3, 2, 100.00, '2024-04-29'),
(4, 4, 3, 90.00, '2024-04-29'),
(5, 5, 2, 70.00, '2024-04-30'),
(6, 6, 4, 160.00, '2024-04-30'),
(7, 7, 6, 120.00, '2024-05-01'),
(8, 8, 3, 75.00, '2024-05-01'),
(9, 9, 2, 60.00, '2024-05-02'),
(10, 10, 5, 225.00, '2024-05-02');

/* Task-2 */
--List all Events
SELECT * FROM Event;
-- Select events with available tickets
SELECT * FROM Event WHERE available_seats > 0;
-- Select events name partial match with ‘cup’
SELECT * FROM Event WHERE event_name LIKE '%cup%';
-- Select events with ticket price range between 1000 to 2500
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;
-- Retrieve events with dates falling within a specific range
SELECT * FROM Event WHERE event_date BETWEEN 'start_date' AND 'end_date';
-- Retrieve events with available tickets that also have "Concert" in their name
SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%';
-- Retrieve users in batches of 5, starting from the 6th user
SELECT * FROM Customer LIMIT 5, 5;
-- Retrieve booking details containing booked no of tickets more than 4
SELECT * FROM Booking WHERE num_tickets > 4;
-- Retrieve customer information whose phone number ends with ‘000’
SELECT * FROM Customer WHERE phone_number LIKE '%000';
-- Retrieve the events in order whose seat capacity is more than 15000
SELECT * FROM Event WHERE total_seats > 15000;
-- Select events name not starting with ‘x’, ‘y’, ‘z’
SELECT * FROM Event WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';

/* Task-3 */

-- List Events and Their Average Ticket Prices
SELECT event_name, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY event_name;
-- Calculate the Total Revenue Generated by Events
SELECT event_id, SUM(total_cost) AS total_revenue FROM Booking GROUP BY event_id;
-- Find the event with the highest ticket sales
SELECT event_id, SUM(num_tickets) AS total_tickets_sold FROM Booking GROUP BY event_id ORDER BY total_tickets_sold DESC LIMIT 1;
-- Calculate the Total Number of Tickets Sold for Each Event
SELECT event_id, SUM(num_tickets) AS total_tickets_sold FROM Booking GROUP BY event_id;
-- Find Events with No Ticket Sales
SELECT * FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);
-- Find the User Who Has Booked the Most Tickets
SELECT customer_id, SUM(num_tickets) AS total_tickets_booked FROM Booking GROUP BY customer_id ORDER BY total_tickets_booked DESC LIMIT 1;
-- List Events and the total number of tickets sold for each month
SELECT event_id, MONTH(booking_date) AS month, SUM(num_tickets) AS total_tickets_sold FROM Booking GROUP BY event_id, month;
-- Calculate the average Ticket Price for Events in Each Venue
SELECT venue_id, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY venue_id;
-- Calculate the total Number of Tickets Sold for Each Event Type
SELECT event_type, SUM(num_tickets) AS total_tickets_sold FROM Event GROUP BY event_type;
-- Calculate the total Revenue Generated by Events in Each Year
SELECT YEAR(booking_date) AS year, SUM(total_cost) AS total_revenue FROM Booking GROUP BY year;
-- List users who have booked tickets for multiple events
SELECT customer_id, COUNT(DISTINCT event_id) AS num_events_booked FROM Booking GROUP BY customer_id HAVING num_events_booked > 1;
-- Calculate the Total Revenue Generated by Events for Each User
SELECT customer_id, SUM(total_cost) AS total_revenue FROM Booking GROUP BY customer_id;
-- Calculate the Average Ticket Price for Events in Each Category and Venue
SELECT venue_id, event_type, AVG(ticket_price) AS avg_ticket_price FROM Event GROUP BY venue_id, event_type;
-- List Users and the Total Number of Tickets They've Purchased in the Last 30 Days
SELECT customer_id, SUM(num_tickets) AS total_tickets_purchased FROM Booking WHERE booking_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) GROUP BY customer_id;

/* Task-4 */
-- Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event WHERE venue_id = v.venue_id) AS avg_ticket_price FROM Venue v;
-- Find Events with More Than 50% of Tickets Sold using subquery
SELECT event_id, event_name FROM Event WHERE (total_seats - available_seats) > 0.5 * total_seats;
-- Calculate the Total Number of Tickets Sold for Each Event
SELECT event_id, SUM(num_tickets) AS total_tickets_sold FROM Booking GROUP BY event_id;
-- Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery
SELECT customer_id, customer_name FROM Customer c WHERE NOT EXISTS (SELECT 1 FROM Booking WHERE customer_id = c.customer_id);
-- List Events with No Ticket Sales Using a NOT IN Subquery
SELECT event_id, event_name FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);
-- Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause
SELECT event_type, SUM(tickets_sold) AS total_tickets_sold FROM (SELECT event_id, SUM(num_tickets) AS tickets_sold FROM Booking GROUP BY event_id) AS subquery JOIN Event ON subquery.event_id = Event.event_id GROUP BY event_type;
-- Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause
SELECT event_id, event_name FROM Event WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);
-- Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery
SELECT customer_id, customer_name, (SELECT SUM(total_cost) FROM Booking WHERE customer_id = c.customer_id) AS total_revenue FROM Customer c;
-- List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause
SELECT customer_id, customer_name FROM Customer WHERE EXISTS (SELECT 1 FROM Booking WHERE Customer.customer_id = Booking.customer_id AND event_id IN (SELECT event_id FROM Event WHERE venue_id = 'given_venue_id'));
-- Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY
SELECT event_type, SUM(tickets_sold) AS total_tickets_sold FROM (SELECT event_id, SUM(num_tickets) AS tickets_sold FROM Booking GROUP BY event_id) AS subquery JOIN Event ON subquery.event_id = Event.event_id GROUP BY event_type;
-- Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT customer_id, customer_name, MONTH(booking_date) AS booking_month FROM Booking WHERE customer_id IN (SELECT DISTINCT customer_id FROM Booking WHERE DATE_FORMAT(booking_date, '%Y-%m') = 'given_month');
-- Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event WHERE venue_id = v.venue_id) AS avg_ticket_price FROM Venue v;
