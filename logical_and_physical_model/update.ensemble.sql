---Update max for ensemble lesson---
UPDATE ensemble
SET min_num_of_students = 2, max_num_of_students = 5;


--- add new  ensemble lesson---
INSERT INTO lesson (instructor_id, price_list_id)
VALUES
(2, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))); -- id 14


INSERT INTO ensemble (lesson_id, genre, min_num_of_students, max_num_of_students)
VALUES
  (14, 'Opera', 3, 5);


  -- add time slot
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  ('13:00', '15:00', '2024-12-03', 14);



INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 14),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 14),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 14),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Nyssa' AND last_name = 'Adkins')), 11);

