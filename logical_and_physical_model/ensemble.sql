--ensemble lesson ---

INSERT INTO lesson (instructor_id, price_list_id)
VALUES
(2, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))), -- id 10
(1, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))), -- id 11
(3, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))), --id 12
(1, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))); -- id 13


INSERT INTO ensemble (lesson_id, genre, min_num_of_students, max_num_of_students)
VALUES
  (10, 'Opera', 3, 10),
  (11, 'Rock', 3, 10),
  (12, 'Metal', 3, 10),
  (13, 'Punk', 3, 10);

-- add time slot
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  ('13:00', '15:00', '2024-11-30', 10),
  ('13:00', '15:00', '2024-12-05', 11),
  ('13:00', '15:00', '2024-12-07', 12),
  ('13:00', '15:00', '2024-12-20', 13);


INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 10),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 10),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 10),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 10),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 11),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 11),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')),11),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 11),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 12),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 12),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 12),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 12),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 13),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 13),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 13),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 13); 
  



