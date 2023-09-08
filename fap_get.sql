
-- GET and SHOW
DELIMITER $$
-- GEt student by course code
CREATE PROCEDURE GetStudentsByCourse(IN courseCode VARCHAR(15))
BEGIN
    SELECT s.id, s.name, s.mssv, 
    CASE 
		WHEN s.gender = 0 THEN 'male'
		ELSE 'female'
    END
    AS gender
    FROM student s 
	INNER JOIN course c 
	ON s.major_id = c.id WHERE c.code = courseCode;
END$$
DELIMITER ;
CALL GetStudentsByCourse('CSI104');

-- get all attendance reports of a student in all class he/she joined
DELIMITER $$
CREATE PROCEDURE GetAttendanceReportsForStudent(
    IN studentMssv VARCHAR(255)
)
BEGIN
    SELECT
		crs.code AS course_code,
        c.name AS class_name, c.semester AS semester, c.room AS classroom, c.number_slots AS class_number_slot,
        ar.number_slots_absent,
        s.name AS student_name, s.mssv
    FROM attendance_report AS ar
    JOIN course AS crs ON crs.id = ar.class_id
    JOIN student AS s ON ar.student_id = s.id
    JOIN class AS c ON ar.class_id = c.id
    WHERE s.mssv = studentMssv;
END$$
DELIMITER ;
CALL GetAttendanceReportsForStudent('SE183659');

-- get time table student
DELIMITER $$
CREATE PROCEDURE GetTimeTableStudent(IN studentId INT)
BEGIN
    SELECT s.name AS student_name, s.mssv,
    c.name AS class_name, c.class_time AS class_time, c.semester AS Semester, c.room AS ROOM
    FROM class_student cs
	JOIN class c on cs.class_id = c.id
    JOIN student s on cs.student_id = s.id
    WHERE s.id = studentId;
END$$
DELIMITER ;
CALL GetTimeTableStudent(1);

-- get exam Schedule for student
DELIMITER $$
CREATE PROCEDURE GetExamScheduleForStudent(IN studentId INT)
BEGIN
    SELECT s.name AS student_name, s.mssv,
    c.name AS name_course, c.code AS course_code,
    es.exam_day AS Exam_Date, e.start_time AS Start_time, e.end_time AS End_time, es.room AS Room
    FROM exam_student es
    JOIN student s ON s.id = es.student_id
    JOIN exam e ON e.id = es.exam_id
    JOIN course c ON e.course_id = c.id
    WHERE s.id = studentId;
END$$
DELIMITER ;
CALL GetExamScheduleForStudent(2);

-- get grade reports for a student
DELIMITER $$
CREATE PROCEDURE GetGradeReportsForStudent(IN studentId INT)
BEGIN
    SELECT s.name AS student_name, s.mssv AS student_id,
    c.name AS Class_name, cs.name AS Course_name, 
    g.pt_1, g.pt_2, g.assignment, g.fe, g.pe,
    ROUND((g.pt_1 + g.pt_2) * 0.1 + g.assignment * 0.2 + (g.pe + g.fe) * 0.3, 2) as average_grade
    FROM grade g
    JOIN class c ON g.class_id = c.id
    JOIN course cs ON cs.id = c.course_id
    JOIN student s ON s.id = g.student_id
    WHERE g.student_id = studentId
    ORDER BY average_grade DESC;
END$$
DELIMITER ;
CALL GetGradeReportsForStudent(3);

-- Show All grade reports of students
DELIMITER $$
CREATE PROCEDURE GetAllGradeReportsForStudents()
BEGIN
    SELECT s.name AS student_name, g.pt_1, g.pt_2, g.assignment, g.fe, g.pe, 
    ROUND((g.pt_1 + g.pt_2) * 0.1 + g.assignment * 0.2 + (g.pe + g.fe) * 0.3, 2) as average_grade
    FROM grade g
    JOIN student s ON g.student_id = s.id;
END$$
DELIMITER ;
CALL GetAllGradeReportsForStudents();

-- Show transaction history for a student (Student) from recent to the past (descending by date)
DELIMITER $$
CREATE PROCEDURE GetTransactionHistoryForStudent(IN studentId INT)
BEGIN
    SELECT tr.receipt_date, tr.money_amount, tr.fee_type, tr.description, tr.input_by, str.status, s.name, s.mssv
    FROM status_transactor str
    INNER JOIN transaction tr ON tr.student_id = str.student_id
    INNER JOIN student s ON str.student_id = s.id
    WHERE str.student_id = studentId
    ORDER BY tr.receipt_date DESC;
END$$
DELIMITER ;
CALL GetTransactionHistoryForStudent(1);

-- Show News (Student, Instructor) descending by date
DELIMITER $$
CREATE PROCEDURE GetNews()
BEGIN
    SELECT n.date_and_time, n.information
    FROM news n
    ORDER BY n.date_and_time DESC;
END$$
DELIMITER ;
CALL GetNews();

-- Show instructor of each major (Student) 
DELIMITER $$
CREATE PROCEDURE GetInstructorsOfEachMajor()
BEGIN
    SELECT m.name AS major_name, i.name AS instructor_name
    FROM major m
    JOIN instructor i ON m.id = i.major_id;
END$$
DELIMITER ;
CALL GetInstructorsOfEachMajor();

INSERT INTO attendance_report (number_slots_absent, student_id, class_id)
VALUES(10, 4, 3), (9, 3, 2);
DELIMITER $$

CREATE PROCEDURE ShowAbsentStudentsInClass()
BEGIN
    SELECT 
        class.name AS class_name, student.name, student.mssv, student.phone, number_slots_absent,
        class.number_slots AS total_slots,
        CONCAT(ROUND((number_slots_absent / class.number_slots) * 100, 2), '%') AS absent_percentage
    FROM attendance_report
    JOIN class ON class.id = attendance_report.class_id
    JOIN student ON student.id = attendance_report.student_id
    WHERE attendance_report.number_slots_absent / class.number_slots > 0.2;
END$$

DELIMITER ;
CALL ShowAbsentStudentsInClass();
