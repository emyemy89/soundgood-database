
--group lesson --
INSERT INTO lesson (instructor_id, price_list_id)
VALUES
(2, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate'))), -- id 6
  (1, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate'))), -- id 7
      (3, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'))), --id 8
      (2, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'))); -- id 9
--add student--

INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 6),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 6),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 6),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 6),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 7),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 7),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 7),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 7),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 8),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 8),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 8),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 8),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 9),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 9),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')), 9),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 9);



INSERT INTO group_lesson (lesson_id, min_num_of_students, max_num_of_students, instrument_used, skill_level_lookup_id)
VALUES
  (6, 3, 10, 'guitar', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate')),
(7, 3, 10, 'flute', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate')),
(8, 3, 10, 'drump', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced')),
(9, 3, 10, 'flute', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'));




-- add time slot
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  ('13:00', '15:00', '2024-10-25', 6),
  ('13:00', '15:00', '2024-11-10', 7),
  ('13:00', '15:00', '2024-12-20', 8),
  ('13:00', '15:00', '2024-12-24', 9);
