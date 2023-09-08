-- Add new student (Staff)-- 
DELIMITER //
CREATE PROCEDURE addStudent (
	IN student_name VARCHAR(50), 
    IN student_mssv VARCHAR(7),
	IN student_phone VARCHAR(12),
    IN student_number_slots_absent int,
    IN student_academic_year VARCHAR(10),
    IN student_gender BOOLEAN
)
BEGIN
  INSERT INTO student (name, mssv, phone, number_slots_absent, academic_year, gender) 
  VALUES (student_name, student_mssv, student_phone, student_number_slots_absent, student_academic_year, student_gender);
END //
DELIMITER ;

-- Add new instructor 
DELIMITER //
CREATE PROCEDURE addInstrucor (
	IN instructor_name VARCHAR(50),
    IN instructor_email VARCHAR(20),
    IN instructor_phone VARCHAR(12),
    IN instructor_major_id INT
)
BEGIN
  INSERT INTO instructor (name, email, phone, major_id) VALUES (instructor_name, instructor_email, instructor_phone, instructor_major_id);
END //
DELIMITER ;

-- Add news (Staff)
DELIMITER //
CREATE PROCEDURE addNews (
	IN news_date_and_time DATETIME,
    IN news_information VARCHAR(255),
    IN news_staff_id INT
)
BEGIN
  INSERT INTO news (date_and_time, information, staff_id) VALUES (news_date_and_time, news_information, news_staff_id);
END //
DELIMITER ;

-- Add grade(instructor)
DELIMITER //
CREATE PROCEDURE addGrade (
	IN pt_1 DOUBLE,
    IN pt_2 DOUBLE,
    IN assigment DOUBLE,
    IN fe DOUBLE,
    IN pe DOUBLE,
	IN class_id INT,
	IN student_id INT
)
BEGIN
  INSERT INTO grade (pt_1, pt_2, assigment, fe, se, class_id, student_id) VALUES (pt_1, pt_2, assigment, fe, se, class_id, student_id);
END //
DELIMITER ;

-- Add attendance record (Instructor)
DELIMITER //
CREATE PROCEDURE addAttendanceRecord (
	IN number_slots_absent int,
	IN student_id INT,
	IN class_id INT
)
BEGIN
  INSERT INTO attendance_report (number_slots_absent, student_id, class_id) VALUES (number_slots_absent, student_id, class_id);
END //
DELIMITER ;