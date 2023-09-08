CREATE database fap;
USE fap;

CREATE TABLE student (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL, 
    mssv VARCHAR(8) NOT NULL,
	phone VARCHAR(12),
    academic_year VARCHAR(10),
    gender BOOLEAN DEFAULT FALSE,
    major_id INT
);


CREATE TABLE staff(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL, 
    email VARCHAR(20) NOT NULL,
    phone VARCHAR(12)
);

CREATE TABLE major (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    total_credit INT NOT NULL,
    duration int NOT NULL
);

CREATE TABLE instructor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(20) NOT NULL,
    phone VARCHAR(12),
    major_id INT
);
CREATE TABLE transaction (
    id INT PRIMARY KEY AUTO_INCREMENT,
    receipt_date DATE,
    money_amount DOUBLE,
    fee_type VARCHAR(20),
    description VARCHAR(255),
    input_by VARCHAR(255),
    student_id INT,
	staff_id INT
);
CREATE TABLE status_transactor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status BOOLEAN DEFAULT FALSE NOT NULL,
    student_id INT,
	staff_id INT
);

CREATE TABLE news (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date_and_time DATETIME NOT NULL,
    information VARCHAR(255) NOT NULL,
    staff_id INT
);

CREATE TABLE course_instructor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    instructor_id INT,
	course_id INT
);
CREATE TABLE class (
    id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(50) NOT NULL,
    semester VARCHAR(20) NOT NULL, 
    room VARCHAR(10) NOT NULL,
    number_slots INT NOT NULL,
    class_time INT,
    course_id INT,
	instructor_id INT
);
CREATE TABLE class_student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    time INT,
    quantity_student INT,
    number_class INT,
	student_id INT,
	class_id INT
);

CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(15) NOT NULL,
    tuition_fee DOUBLE,
    credit INT,
	major_id INT
);

CREATE TABLE attendance_report (
    id INT PRIMARY KEY AUTO_INCREMENT,
	number_slots_absent int DEFAULT 0,
	student_id INT,
	class_id INT
);

CREATE TABLE exam (
    id INT PRIMARY KEY AUTO_INCREMENT,
    start_time DATETIME,
    end_time DATETIME,
	course_id INT
);

CREATE TABLE exam_student(
    id INT PRIMARY KEY AUTO_INCREMENT,
    exam_day DATE,
    exam_start_time TIME,
    exam_end_time TIME,
    room VARCHAR(10),
	exam_id INT,
	student_id INT
);

CREATE TABLE grade (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pt_1 DOUBLE,
    pt_2 DOUBLE,
    assignment DOUBLE,
    fe DOUBLE,
    pe DOUBLE,
	class_id INT,
	student_id INT
);


CREATE TABLE salary (
    id INT PRIMARY KEY AUTO_INCREMENT,
    wage DOUBLE NOT NULL,
    type ENUM('staff', 'instructor') NOT NULL,
    person_id INT,
    FOREIGN KEY (person_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES instructor(id) ON DELETE CASCADE
);

ALTER TABLE instructor
ADD FOREIGN KEY (major_id) REFERENCES major(id);

ALTER TABLE status_transactor
ADD FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE status_transactor
ADD FOREIGN KEY (staff_id) REFERENCES staff(id);

ALTER TABLE transaction
ADD FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE transaction
ADD FOREIGN KEY (staff_id) REFERENCES staff(id);

ALTER TABLE news 
ADD FOREIGN KEY (staff_id) REFERENCES staff(id);

ALTER TABLE course_instructor
ADD FOREIGN KEY (instructor_id) REFERENCES instructor(id);
ALTER TABLE course_instructor
ADD FOREIGN KEY (course_id) REFERENCES course(id);

ALTER TABLE class
ADD FOREIGN KEY (course_id) REFERENCES course(id);
ALTER TABLE class
ADD FOREIGN KEY (instructor_id) REFERENCES instructor(id);

ALTER TABLE class_student
ADD FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE class_student
ADD FOREIGN KEY (class_id) REFERENCES class(id);

ALTER TABLE course 
ADD FOREIGN KEY (major_id) REFERENCES major(id);

ALTER TABLE attendance_report 
ADD FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE attendance_report 
ADD FOREIGN KEY (class_id) REFERENCES class(id);

ALTER TABLE exam
ADD FOREIGN KEY (course_id) REFERENCES course(id);

ALTER TABLE exam_student
ADD FOREIGN KEY (exam_id) REFERENCES exam(id);
ALTER TABLE exam_student
ADD FOREIGN KEY (student_id) REFERENCES student(id);

ALTER TABLE grade
ADD FOREIGN KEY (class_id) REFERENCES class(id);
ALTER TABLE grade
ADD FOREIGN KEY (student_id) REFERENCES student(id);

ALTER TABLE student 
ADD FOREIGN KEY (major_id) references major(id);

ALTER TABLE major
MODIFY name varchar(50);

INSERT INTO major (id, name, total_credit, duration)
VALUES
(1, 'Information Technology', 150, 4),
(2, 'Business', 150, 4),
(3, 'Multimedia', 150, 4),
(4, 'Linguistic', 150, 4);

INSERT INTO student (id, name, mssv, phone, academic_year, gender, major_id)
VALUES
(1, 'Nguyen Ngoc Thien Phu', 'SE182426', '123-456-7890', '2022-2026', FALSE, 1),
(2, 'Vo Thi Mai Hoa', 'SE183659', '987-654-3210', '2022-2026', TRUE, 1),
(3, 'Lee Min Ho', 'SS190000', '555-555-5555', '2023-2027', FALSE, 3),
(4, 'Bob Wilson', 'SS178987', '777-888-9999', '2021-2025', TRUE, 2),
(5, 'Eve Davis', 'SA163456', '111-222-3333', '2020-2024', FALSE, 4);


SELECT * FROM student;

INSERT INTO staff (id, name, email, phone)
VALUES
(1, 'Sarah Brown', 'sarah@example.com', '555-555-5555'),
(2, 'Michael Johnson', 'michael@example.com', '123-456-7890'),
(3, 'Emily Wilson', 'emily@example.com', '987-654-3210'),
(4, 'David Smith', 'david@example.com', '777-888-9999'),
(5, 'Olivia Davis', 'olivia@example.com', '111-222-3333');

INSERT INTO instructor (id, name, email, phone, major_id)
VALUES
(1, 'John Instructor', 'john@gmail.com', '555-555-5555', 1),
(2, 'Jane Teacher', 'jane@gmail.com', '123-456-7890', 2),
(3, 'Alice Prof', 'alice@gmail.com', '987-654-3210', 3),
(4, 'Bob Lecturer', 'bob@gmail.com', '777-888-9999', 4),
(5, 'Eve Tutor', 'eve@gmail.com', '111-222-3333', 1);

INSERT INTO transaction (id, receipt_date, money_amount, fee_type, description, input_by, student_id, staff_id)
VALUES
(1, '2023-08-15', 500.00, 'Tuition', 'Payment for Fall Semester', 'DNG', 1, 1),
(2, '2023-07-20', 300.00, 'Late Fee', 'Late payment fee', 'DNG', 2, 2),
(3, '2023-08-01', 450.00, 'Tuition', 'Payment for Fall Semester', 'DNG', 3, 3),
(4, '2023-08-10', 600.00, 'Tuition', 'Payment for Fall Semester', 'DNG', 4, 4),
(5, '2023-09-01', 750.00, 'Tuition', 'Payment for Fall Semester', 'DNG', 1, 3);

INSERT INTO status_transactor (id, status, student_id, staff_id)
VALUES
(1, TRUE, 1, 1),
(2, FALSE, 2, 2),
(3, TRUE, 3, 3),
(4, FALSE, 4, 4),
(5, TRUE, 1, 3);

INSERT INTO news (id, date_and_time, information, staff_id)
VALUES
(1, '2023-08-15 10:00:00', 'Important Announcement', 1),
(2, '2023-07-20 14:30:00', 'Class Schedule Update', 2),
(3, '2023-08-01 09:15:00', 'New Campus Guidelines', 3),
(4, '2023-08-10 16:45:00', 'Career Fair Reminder', 4),
(5, '2023-09-01 11:30:00', 'Upcoming Exams', 5);

INSERT INTO course (id, name, code, tuition_fee, credit, major_id)
VALUES
(1, 'Introduction to Computer Science', 'CSI104', 1000.00, 3, 1),
(2, 'Principles of Business', 'POB111', 1200.00, 4, 2),
(3, 'Engineering Basics','ENB123', 1100.00, 3, 1),
(4, 'Introduction to Psychology', 'IPS202', 900.00, 3, 4);

INSERT INTO course_instructor (id, instructor_id, course_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4);

INSERT INTO class (id, name, semester, room, number_slots, class_time, course_id, instructor_id)
VALUES
(1, 'SE1838', 'Spring 2023', '132', 20, 2, 1, 1),
(2, 'SE1801', 'Summer 2023', '105', 20, 2, 3, 3),
(3, 'SS1707', 'Fall 2022', '412', 20, 2, 4, 4),
(4, 'SS1816', 'Fall 2023', '210', 20, 2, 2, 2);

INSERT INTO class_student (id, time, quantity_student, number_class, student_id, class_id)
VALUES
(1, 1, 25, 1, 2, 1),
(2, 2, 20, 2, 1, 2),
(3, 3, 30, 3, 3, 3),
(4, 4, 35, 4, 4, 4);

INSERT INTO attendance_report (id, number_slots_absent, student_id, class_id)
VALUES
(1, 0, 1, 2),
(2, 0, 2, 1),
(3, 2, 3, 3),
(4, 3, 4, 4);

INSERT INTO exam (id, start_time, end_time, course_id)
VALUES
(1, '2023-12-10 09:00:00', '2023-12-10 11:00:00', 1),
(2, '2023-12-12 10:00:00', '2023-12-12 12:00:00', 2),
(3, '2023-12-14 09:30:00', '2023-12-14 11:30:00', 3),
(4, '2023-12-16 11:00:00', '2023-12-16 13:00:00', 4);

INSERT INTO exam_student (id, exam_day, exam_start_time, exam_end_time, room, exam_id, student_id)
VALUES
(1, '2023-12-10', '09:00:00', '10:00:00', '111', 1, 1),
(2, '2023-12-12', '10:00:00','11:00:00', '222', 2, 2),
(3, '2023-12-14', '09:30:00','11:00:00', '121', 3, 3),
(4, '2023-12-16', '11:00:00', '11:45:00', '212', 4, 4);

INSERT INTO grade (id, pt_1, pt_2, assignment, fe, pe, class_id, student_id)
VALUES
(1, 9.5, 9.0, 9.25, 8.8, 8.9, 1, 2),
(2, 8.8, 9.2, 8.7, 9.3, 9.5 , 2, 1),
(3, 9.2, 8.5, 9.1, 8.5, 8.0, 3, 3),
(4, 7.5, 8.0, 8.5, 7.0, 8.5, 4, 4);

INSERT INTO salary (id, wage, type, person_id)
VALUES
(1, 50000.0, 'staff', 1),
(2, 55000.0, 'staff', 2),
(3, 60000.0, 'staff', 3),
(4, 52000.0, 'staff', 4),
(5, 48000.0, 'staff', 5);

INSERT INTO salary (id, wage, type, person_id)
VALUES
(6, 60000.0, 'instructor', 1),
(7, 65000.0, 'instructor', 2),
(8, 70000.0, 'instructor', 3),
(9, 62000.0, 'instructor', 4),
(10, 58000.0, 'instructor', 5);