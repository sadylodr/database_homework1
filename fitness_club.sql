CREATE TABLE if not exists Memberships (
    membership_id SERIAL PRIMARY KEY,
    membership_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    duration_days INT NOT NULL, 
    description TEXT
);

CREATE TABLE if not exists Trainers (
    trainer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE NOT NULL
);

CREATE TABLE if not exists Qualifications (
    qualification_id SERIAL PRIMARY KEY,
    trainer_id INT NOT NULL,
    qualification_name VARCHAR(100) NOT NULL,
    issuing_organization VARCHAR(100),
    expiration_date DATE,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
        ON DELETE CASCADE
);

CREATE TABLE if not exists Programs (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    program_type TEXT CHECK(program_type in ('Group', 'Individual')) NOT NULL,
    difficulty TEXT CHECK(difficulty in ('Beginner', 'Intermediate', 'Advanced')) NOT NULL,
    duration_minutes INT 
);

CREATE TABLE if not exists Members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    join_date DATE NOT NULL,
    membership_id INT,
    FOREIGN KEY (membership_id) REFERENCES Memberships(membership_id)
);

CREATE TABLE if not exists Payments (
    payment_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    membership_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (membership_id) REFERENCES Memberships(membership_id)
);

CREATE TABLE if not exists Sessions (
    session_id SERIAL PRIMARY KEY,
    program_id INT NOT NULL,
    trainer_id INT NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    room_number VARCHAR(10),
    FOREIGN KEY (program_id) REFERENCES Programs(program_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);

CREATE TABLE if not exists Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    program_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    UNIQUE (member_id, program_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
);

CREATE TABLE if not exists Attendance (
    attendance_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    session_id INT NOT NULL,
    check_in_time DATE NOT NULL,
    UNIQUE (member_id, session_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id)
);
