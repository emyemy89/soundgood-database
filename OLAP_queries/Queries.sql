
-- query 1
SELECT
    TO_CHAR(ts.date_slot, 'Mon') AS Month, -- Extract the month from the date
	COUNT(*) AS lesson, -- Total number of lessons
    COUNT(il.lesson_id) AS Individual, -- Count individual lessons
    COUNT(gl.lesson_id) AS Group, -- Count group lessons
    COUNT(e.lesson_id) AS Ensemble -- Count ensemble lessons
FROM
    lesson l
LEFT JOIN individual_lesson il ON l.lesson_id = il.lesson_id
LEFT JOIN group_lesson gl ON l.lesson_id = gl.lesson_id
LEFT JOIN ensemble e ON l.lesson_id = e.lesson_id
LEFT JOIN time_slot ts ON l.lesson_id = ts.lesson_id -- Include date info for grouping
GROUP BY
    TO_CHAR(ts.date_slot, 'Mon'), EXTRACT(MONTH FROM ts.date_slot) -- Group by month
ORDER BY Month DESC;


--query 2

CREATE VIEW nb_of_siblings AS 
    SELECT 
        student.student_id, 
        COUNT(ss.student_id) AS sib_count --count siblings directly using a JOIN
    FROM student 
    LEFT JOIN sibling_student ss ON ss.student_id = student.student_id
    GROUP BY student.student_id;

SELECT 
    sib_count AS "No of Siblings",   
    COUNT(*) AS "No of Students"
FROM nb_of_siblings
GROUP BY sib_count
ORDER BY sib_count ASC;



--query 3
CREATE VIEW lessons_per_month AS
    SELECT
        lesson.instructor_id,
        COUNT(*) AS lesson_count
    FROM lesson 
    INNER JOIN time_slot ts ON lesson.lesson_id = ts.lesson_id
	WHERE TO_CHAR(ts.date_slot, 'YYYY-MM') = TO_CHAR(CURRENT_DATE, 'YYYY-MM')
    GROUP BY lesson.instructor_id;

SELECT
    lmon.instructor_id,
    person.first_name,
    person.last_name,
    lmon.lesson_count AS "No of Lessons"
FROM lessons_per_month lmon
JOIN instructor i ON lmon.instructor_id = i.instructor_id
JOIN person ON i.person_id = person.person_id
WHERE lmon.lesson_count > 0
ORDER BY lmon.lesson_count DESC;

--- ensemble queries ---
WITH next_week_ensembles AS (
    SELECT 
        e.genre,
        ts.date_slot AS day,
        (e.max_num_of_students - COUNT(DISTINCT s.student_id)) AS free_seats
    FROM ensemble e
    INNER JOIN time_slot ts 
        ON e.lesson_id = ts.lesson_id
    LEFT JOIN student_lesson sl 
        ON e.lesson_id = sl.lesson_id
    LEFT JOIN student s 
        ON sl.student_id = s.student_id
    WHERE ts.date_slot BETWEEN CURRENT_DATE + 1 AND CURRENT_DATE + 7
    GROUP BY e.genre, ts.date_slot, e.max_num_of_students
),
availability_status AS (
    SELECT 
        genre,
        day,
        CASE 
            WHEN free_seats = 0 THEN 'No Seats'
            WHEN free_seats BETWEEN 1 AND 2 THEN '1 or 2 Seats'
            ELSE 'Many Seats'
        END AS "No of Free Seats"
    FROM next_week_ensembles
)
SELECT 
    TO_CHAR(day, 'Dy') AS "Day",
    genre AS "Genre",
    "No of Free Seats"
FROM availability_status
ORDER BY genre, day;
