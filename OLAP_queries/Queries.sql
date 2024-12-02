--###################################
--
-- THE SCRIPT FOR DATABASE CREATION AND FOR INSERTION CAN BE FOUND
-- IN FOLDER logical_physical_model (in this repo):
--   emyemy89/IV1351_Data_Storage_Paradigms/logical_physical_model
--
--#####################################



-- query 1
SELECT
    TO_CHAR(ts.date_slot, 'Mon') AS Month, COUNT(*) AS lesson, COUNT(il.lesson_id) AS individual, 
	COUNT(gl.lesson_id) AS group, COUNT(e.lesson_id) AS ensemble
FROM
    lesson 
LEFT JOIN individual_lesson il ON lesson.lesson_id = il.lesson_id
LEFT JOIN group_lesson gl ON lesson.lesson_id = gl.lesson_id
LEFT JOIN ensemble e ON lesson.lesson_id = e.lesson_id
LEFT JOIN time_slot ts ON lesson.lesson_id = ts.lesson_id 
GROUP BY
    TO_CHAR(ts.date_slot, 'Mon'), EXTRACT(MONTH FROM ts.date_slot)
ORDER BY month DESC;   


--query 2

CREATE VIEW nb_of_siblings AS 
    SELECT student.student_id, COUNT(ss.student_id) AS sib_count
    FROM student 
    LEFT JOIN sibling_student ss ON ss.student_id = student.student_id
    GROUP BY student.student_id;

SELECT sib_count AS "No of Siblings", COUNT(*) AS "No of Students"
FROM nb_of_siblings
GROUP BY sib_count
ORDER BY sib_count ASC;



--query 3
CREATE VIEW lessons_per_month AS
    SELECT lesson.instructor_id, COUNT(*) AS lesson_count
    FROM lesson 
    INNER JOIN time_slot ts ON lesson.lesson_id = ts.lesson_id
	WHERE TO_CHAR(ts.date_slot, 'YYYY-MM') = TO_CHAR(CURRENT_DATE, 'YYYY-MM')
    GROUP BY lesson.instructor_id;

SELECT lmon.instructor_id, person.first_name, person.last_name, lmon.lesson_count AS "No of Lessons"
FROM lessons_per_month lmon
JOIN instructor ON lmon.instructor_id = instructor.instructor_id
JOIN person ON instructor.person_id = person.person_id
WHERE lmon.lesson_count > 0
ORDER BY lmon.lesson_count DESC;


--- query 4, ensemble queries ---
CREATE VIEW next_ensembles AS 
    SELECT ensemble.genre, ts.date_slot AS day,
	CASE 
            WHEN (ensemble.max_num_of_students - COUNT(sl.student_id)) = 0 THEN 'No Seats'
            WHEN (ensemble.max_num_of_students - COUNT(sl.student_id)) BETWEEN 1 AND 2 THEN '1 or 2 Seats'
            ELSE 'Many Seats'
            END AS free_seats
    FROM ensemble 
    INNER JOIN time_slot ts ON ensemble.lesson_id = ts.lesson_id
    LEFT JOIN student_lesson sl ON ensemble.lesson_id = sl.lesson_id
    LEFT JOIN student ON sl.student_id = student.student_id
    WHERE ts.date_slot BETWEEN CURRENT_DATE + 1 AND CURRENT_DATE + 7
    GROUP BY ensemble.genre, ts.date_slot, ensemble.max_num_of_students


SELECT 
    TO_CHAR(day, 'Day') AS "Day",
    genre AS "Genre",
    free_seats AS "No of Free Seats"
FROM next_ensembles
ORDER BY genre, day;
