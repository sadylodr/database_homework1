CREATE TABLE MenuCategories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Dishes (
    dish_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    dish_name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(6, 2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (category_id) REFERENCES MenuCategories(category_id)
);

CREATE TABLE Tables (
    table_id SERIAL PRIMARY KEY,
    table_number VARCHAR(10) NOT NULL UNIQUE,
    capacity INT NOT NULL CHECK (capacity > 0),
    table_location VARCHAR(50)
);

CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    employee_role VARCHAR(50) NOT NULL,
    hire_date DATE
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Reservations (
    reservation_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    table_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    time_slot TIME NOT NULL,
    number_of_guests INT NOT NULL CHECK (number_of_guests > 0),
    reservation_status VARCHAR(20) DEFAULT 'Confirmed',
    
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (table_id) REFERENCES Tables(table_id),
    
	UNIQUE (table_id, reservation_date, time_slot)
);

CREATE TABLE OrderItems (
    order_item_id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL,
    dish_id INT NOT NULL,
    employee_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    item_price NUMERIC(6, 2) NOT NULL,
    order_time TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id),
    FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    
    UNIQUE (reservation_id, dish_id) 
);