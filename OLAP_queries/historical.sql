DROP TABLE IF EXISTS historical; -- for debugging

CREATE TABLE historical(
  lesson_id INT GENERATED ALWAYS AS IDENTITY,
  lesson_type VARCHAR(50),
  price VARCHAR(50),
  genre VARCHAR(500),
  instrument VARCHAR(500),
  student_first_name VARCHAR(500),
  student_last_name VARCHAR(500),
  student_email VARCHAR(500)
);

INSERT INTO historical(
  lesson_type,
  price,
  genre,
  instrument,
  student_first_name,
  student_last_name,
  student_email
)

SELECT 
  lesson_type_lookup.lesson_type AS lesson_type, 
  price_list.price AS price,
  ensemble.genre AS genre, 
  CASE 
        WHEN individual_lesson.lesson_id IS NOT NULL THEN individual_lesson.instrument  -- Get instrument for individual lessons
        WHEN group_lesson.lesson_id IS NOT NULL THEN group_lesson.instrument_used  -- Get instrument for group lessons
        ELSE NULL  --no instrument for ensemble
    END AS instrument,
  person.first_name AS student_first_name,
  person.last_name AS student_last_name,
  person.email AS student_email
FROM lesson
  JOIN student_lesson ON lesson.lesson_id = student_lesson.lesson_id  -- join lesson -> person
  JOIN student ON student_lesson.student_id = student.student_id 
  JOIN person ON student.person_id = person.person_id  
  JOIN price_list ON lesson.price_list_id = price_list.price_list_id  -- join lesson -> lesson price
  LEFT JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id  -- get lesson types
  LEFT JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id  
  LEFT JOIN ensemble ON lesson.lesson_id = ensemble.lesson_id  
  LEFT JOIN lesson_type_lookup ON price_list.lesson_type_lookup_id = lesson_type_lookup.lesson_type_lookup_id;  --for lesson type
