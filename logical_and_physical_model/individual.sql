
--Individual lesson --
INSERT INTO lesson (instructor_id, price_list_id)
VALUES
(2, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate'))),
  (3, 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
      (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson') 
   AND skill_level_lookup_id = 
      (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced')));

--add student--

INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), 4),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 5);

INSERT INTO individual_lesson (lesson_id, instrument, skill_level_lookup_id)
VALUES
  (4, 'guitar', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate')),
(5, 'guitar', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'));


-- add time slot
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  ('13:00', '15:00', '2024-11-10', 4),
  ('13:00', '15:00', '2024-12-24', 5);



