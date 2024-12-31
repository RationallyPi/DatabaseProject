show databases;
CREATE DATABASE CourseDatabase;
use CourseDatabase;
CREATE TABLE School (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    established_year INT
);

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    school_id INT,
    hire_date DATE,
    FOREIGN KEY (school_id) REFERENCES School(school_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    credits INT CHECK (credits > 0),
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES School(school_id)
);

CREATE TABLE CourseDetails (
    detail_id INT PRIMARY KEY,
    course_id INT,
    instructor_id INT,
    semester VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    room_number VARCHAR(20),
    schedule VARCHAR(50),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (instructor_id) REFERENCES Instructors(instructor_id)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE,
    major VARCHAR(50),
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES School(school_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    detail_id INT,
    enrollment_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (detail_id) REFERENCES CourseDetails(detail_id)
);

INSERT INTO School VALUES
(1, 'Tech University', 'Silicon Valley', 1985),
(2, 'Liberal Arts College', 'Boston', 1890),
(3, 'State University', 'Chicago', 1901),
(4, 'Medical Institute', 'New York', 1920),
(5, 'Business School', 'Los Angeles', 1950);

INSERT INTO Instructors VALUES
(1, 'John', 'Smith', 'john.smith@tech.edu', 'Computer Science', 1, '2015-08-15'),
(2, 'Maria', 'Garcia', 'maria.garcia@liberal.edu', 'Literature', 2, '2018-01-10'),
(3, 'David', 'Johnson', 'david.johnson@state.edu', 'Mathematics', 3, '2016-09-01'),
(4, 'Sarah', 'Williams', 'sarah.williams@med.edu', 'Biology', 4, '2019-03-20'),
(5, 'Michael', 'Brown', 'michael.brown@business.edu', 'Finance', 5, '2017-06-30');

INSERT INTO Courses VALUES
(1, 'CS101', 'Introduction to Programming', 'Computer Science', 3, 1),
(2, 'LIT201', 'World Literature', 'Literature', 3, 2),
(3, 'MATH301', 'Advanced Calculus', 'Mathematics', 4, 3),
(4, 'BIO101', 'Introduction to Biology', 'Biology', 4, 4),
(5, 'FIN401', 'Financial Management', 'Finance', 3, 5);

INSERT INTO CourseDetails VALUES
(1, 1, 1, 'Fall', 2024, 'Room 101', 'Mon/Wed 9:00-10:30', 30),
(2, 2, 2, 'Fall', 2024, 'Room 201', 'Tue/Thu 11:00-12:30', 25),
(3, 3, 3, 'Spring', 2024, 'Room 301', 'Mon/Wed 14:00-15:30', 20),
(4, 4, 4, 'Fall', 2024, 'Room 401', 'Tue/Thu 9:00-10:30', 35),
(5, 5, 5, 'Spring', 2024, 'Room 501', 'Mon/Wed 11:00-12:30', 40);

INSERT INTO Students VALUES
(1, 'Emma', 'Davis', 'emma.davis@student.edu', '2023-09-01', 'Computer Science', 1),
(2, 'James', 'Wilson', 'james.wilson@student.edu', '2023-09-01', 'Literature', 2),
(3, 'Sophia', 'Anderson', 'sophia.anderson@student.edu', '2023-09-01', 'Mathematics', 3),
(4, 'Oliver', 'Martinez', 'oliver.martinez@student.edu', '2023-09-01', 'Biology', 4),
(5, 'Isabella', 'Taylor', 'isabella.taylor@student.edu', '2023-09-01', 'Finance', 5);

INSERT INTO Enrollments VALUES
(1, 1, 1, '2024-01-15', 'A'),
(2, 2, 2, '2024-01-15', 'B+'),
(3, 3, 3, '2024-01-16', 'A-'),
(4, 4, 4, '2024-01-16', 'B'),
(5, 5, 5, '2024-01-17', 'A');

-- Basic Join Statements
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN CourseDetails cd ON e.detail_id = cd.detail_id
JOIN Courses c ON cd.course_id = c.course_id;



SELECT 
    s.school_name,
    st.student_id
FROM School s
LEFT JOIN Students st ON s.school_id = st.school_id;


CREATE TABLE studentFee (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00
);

-- Basic Transaction
INSERT INTO studentFee (student_name, balance)
VALUES ('John Doe', 1000.00);


START TRANSACTION;


UPDATE studentFee
SET balance = balance - 500
WHERE student_id = 1;


COMMIT;
SELECT * FROM studentFee WHERE student_id = 1;
 




