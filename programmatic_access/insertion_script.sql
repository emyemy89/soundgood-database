---Lesson Type Lookup---
INSERT INTO lesson_type_lookup (lesson_type)
VALUES
  ('individual_lesson'),
  ('group_lesson'),
  ('ensemble');

---Skill Level Lookup---
INSERT INTO skill_level_lookup (skill_level)
VALUES
  ('beginner'),
  ('intermediate'),
  ('advanced');

---Price List---
INSERT INTO price_list (price, lesson_type_lookup_id, skill_level_lookup_id, date_price)
VALUES
  ('$3.25', 
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'), 
   'Apr 23, 2024'),

  ('$89.19', 
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate'), 
   'Apr 23, 2024'),

  ('$81.79', 
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'), 
   'Apr 23, 2024'),

  ('$68.47', 
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'), 
   'Apr 23, 2024'),

  ('$49.93',  
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'intermediate'), 
   'Apr 23, 2024'),

  ('$96.52', 
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson'), 
   (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'advanced'), 
   'Apr 23, 2024'),

  ('$7.31',  
   (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'), 
   NULL, 
   'Apr 23, 2024');

---Person---
INSERT INTO person (first_name, last_name, personal_num, email, city, street, zip)
VALUES
  ('Chancellor', 'Sims', '25636315', 'felis.purus@hotmail.net', 'Galway', '928-9035 Nulla Ave', '528084'),
  ('Wang', 'Pickett', '15920741', 'vulputate.lacus@google.com', 'Hérouville-Saint-Clair', '619-949 Et Av.', '62152'),
  ('Allistair', 'Carroll', '1386278', 'arcu.et.pede@icloud.net', 'Almelo', 'Ap #431-2125 Sed Road', '263295'),
  ('Hayes', 'Wyatt', '4698685', 'nisl.quisque@aol.com', 'Feldkirchen in Kärnten', '455-6929 Eros St.', '537692'),
  ('Nyssa', 'Adkins', '12102796', 'massa.rutrum@yahoo.edu', 'Laoag', 'Ap #939-4783 Massa. St.', '226563'),
  ('Lionel', 'Ferrell', '23269748', 'in@google.com', 'Suwon', '683-3654 Vel Rd.', '36271'),
  ('Xander', 'Sellers', '22386551', 'laoreet.ipsum.curabitur@hotmail.ca', 'Krasnaya Yaruga', 'Ap #583-7729 Vivamus Rd.', '65348'),
  ('Jermaine', 'Gould', '39600999', 'quisque.libero.lacus@google.edu', 'Simon''s Town', 'Ap #693-1232 Nunc Street', '415537');

---Phone---
INSERT INTO phone (phone_num, person_id)
VALUES
  ('+46 28 458 71 24', (SELECT person_id FROM person WHERE first_name = 'Lionel' AND last_name = 'Ferrell')),
  ('+46 26 281 84 93', (SELECT person_id FROM person WHERE first_name = 'Xander' AND last_name = 'Sellers')),
  ('+46 27 881 26 47', (SELECT person_id FROM person WHERE first_name = 'Jermaine' AND last_name = 'Gould')),
  ('070 9489 5554',  (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')),
  ('070 3428 9140', (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')),
  ('07082 271496', (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')),
  ('0500 155536', (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')),
  ('07208 839252',( SELECT person_id FROM person WHERE first_name = 'Nyssa' AND last_name = 'Adkins'));
 
  ---Instructor---
INSERT INTO instructor (employment_id, person_id)
VALUES
  ('1774', (SELECT person_id FROM person WHERE first_name = 'Lionel' AND last_name = 'Ferrell')),  
  ('7155', (SELECT person_id FROM person WHERE first_name = 'Xander' AND last_name = 'Sellers')),
  ('2012', (SELECT person_id FROM person WHERE first_name = 'Jermaine' AND last_name = 'Gould'));
  
  
  ---Instrument Instructor---
INSERT INTO instrument_instructor (instrument_instructor, instructor_id)
VALUES
  ('guitar', ( SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('flute',  (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('trumpet',(  SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('guitar', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('flute', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('trumpet', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('guitar', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('flute', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('trumpet', (SELECT instructor_id FROM instructor WHERE employment_id = '2012'));


INSERT INTO instructor_availability (availability_date, start_time, end_time, instructor_id)
VALUES
  ('2024-04-23', '15:57', '18:40', (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('2024-12-22', '04:57', '07:48', (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('2024-10-22', '16:22', '23:39', (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('2025-06-03', '06:38', '10:37', (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('2025-03-04', '15:04', '20:27', (SELECT instructor_id FROM instructor WHERE employment_id = '1774')),
  ('2025-01-26', '10:34', '15:16', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('2024-03-27', '13:56', '17:43', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('2025-06-01', '10:02', '18:25', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('2025-10-25', '13:45', '18:29', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('2024-05-30', '18:58', '21:22', (SELECT instructor_id FROM instructor WHERE employment_id = '7155')),
  ('2024-11-05', '10:08', '13:42', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('2024-02-20', '10:06', '14:52', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('2024-03-29', '18:34', '20:58', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('2024-06-23', '20:35', '22:18', (SELECT instructor_id FROM instructor WHERE employment_id = '2012')),
  ('2025-03-30', '19:11', '21:37', (SELECT instructor_id FROM instructor WHERE employment_id = '2012'));



---Contact Person---
INSERT INTO contact_person (first_name, last_name, personal_num)
VALUES
  ('Walker', 'Wright', '366664815'),
  ('Jakeem', 'Ashley', '313977692'),
  ('Kirestin', 'Baxter', '491662182'),
  ('Britanni', 'Wolf', '216042409');


---Student---
INSERT INTO student (level_skills, contact_person_id, person_id)
VALUES
  ('beginner', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Walker' AND last_name = 'Wright'), (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')),
  ('intermediate',  (SELECT contact_person_id FROM contact_person WHERE first_name = 'Walker' AND last_name = 'Wright'), (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')),
  ('advanced', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Jakeem' AND last_name = 'Ashley'), (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')),
  ('beginner',( SELECT contact_person_id FROM contact_person WHERE first_name = 'Kirestin' AND last_name = 'Baxter'),( SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')),
  ('intermediate', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Britanni' AND last_name = 'Wolf'), (SELECT person_id FROM person WHERE first_name = 'Nyssa' AND last_name = 'Adkins'));


--Contact person phone---
INSERT INTO contact_phone (phone_num, contact_person_id)
VALUES
  ('+46 47 837 24 69', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Walker' AND last_name = 'Wright')),
  ('+46 57 461 90 25', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Britanni' AND last_name = 'Wolf')),
  ('+46 40 638 38 25', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Kirestin' AND last_name = 'Baxter')),
  ('+46 89 325 65 39', (SELECT contact_person_id FROM contact_person WHERE first_name = 'Jakeem' AND last_name = 'Ashley'));

---Sibling--- -- need to be checked-- 
INSERT INTO sibling_student (sibling_student_id, student_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')),( SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett'))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')));


-- INSERT INTO rental (starting_date, ending_date, student_id) VALUES 
-- ('2024-04-30', '2025-04-30', (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims'))),
-- ('2024-11-01', '2025-11-01', (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')));

INSERT INTO rental (starting_date, ending_date, student_id, status) VALUES 
('2024-04-30', '2025-04-30', (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 'active'),
('2024-11-01', '2025-11-01', (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 'active');


---Lesson---
INSERT INTO lesson (instructor_id, price_list_id)
VALUES
  ((SELECT instructor_id FROM instructor WHERE employment_id = '1774'), 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
       (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson') 
    AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'))), -- individual lesson
  ((SELECT instructor_id FROM instructor WHERE employment_id = '7155'), 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
       (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
    AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'))), -- group lesson
  ((SELECT instructor_id FROM instructor WHERE employment_id = '2012'), 
   (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
       (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble') 
    AND skill_level_lookup_id IS NULL)); -- ensemble lesson



---Student Lesson--- NOT DONE YET
INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))), 
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')), -- Hayes Wyatt
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')),        --Wang Pickett
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))), 
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Nyssa' AND last_name = 'Adkins')),        --Nyssa Adkins
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Wang' AND last_name = 'Pickett')),        --Wang Pickett
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Hayes' AND last_name = 'Wyatt')),  -- Hayes Wyatt
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble')))), 
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')), 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble')))),
  ((SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims')), 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble')))); 


---Ensemble---
INSERT INTO ensemble (lesson_id, genre, min_num_of_students, max_num_of_students)
VALUES
  ((SELECT lesson_id FROM lesson WHERE price_list_id = (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))), 'Opera', 3, 10);


---Group Lesson---
INSERT INTO group_lesson (lesson_id, min_num_of_students, max_num_of_students, instrument_used, skill_level_lookup_id)
VALUES
  ((SELECT lesson_id FROM lesson WHERE price_list_id = (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
            (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') AND skill_level_lookup_id = 
                                                                          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'))), 3, 10, 'Bassoon', (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'));
---Time Slot---
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  ('13:00', '15:00', '2025-01-26', 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'group_lesson') 
       AND skill_level_lookup_id = 
           (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner')))), 
  ('14:00', '16:00', '2025-01-26', 
   (SELECT lesson_id FROM lesson WHERE price_list_id = 
       (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
           (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'ensemble'))));

---Individual Lesson---
INSERT INTO individual_lesson (lesson_id, instrument, skill_level_lookup_id)
VALUES
  ((SELECT lesson_id FROM lesson WHERE price_list_id = 
      (SELECT price_list_id FROM price_list WHERE lesson_type_lookup_id = 
          (SELECT lesson_type_lookup_id FROM lesson_type_lookup WHERE lesson_type = 'individual_lesson') 
      AND skill_level_lookup_id = 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'))), 'guitar', 
          (SELECT skill_level_lookup_id FROM skill_level_lookup WHERE skill_level = 'beginner'));

---Instrument---
INSERT INTO instrument (rental_price, instrument_name,  type_of_instrument, brand, quantity)
VALUES
  ('$6.78', 'flute' , 'woodWind', 'Buffet', 10),
  ('$5.57', 'guitar','string', 'Ludwig', 10),
  ('$6.50', 'trumpet' ,'brass', 'Fox', 10);


INSERT INTO individual_instrument (instrument_id, serial_number, status)
VALUES
  ((SELECT instrument_id FROM instrument WHERE instrument_name = 'flute'), 'FL123456', 'available'),
  ((SELECT instrument_id FROM instrument WHERE instrument_name = 'guitar'), 'GT123456', 'available'),
  ((SELECT instrument_id FROM instrument WHERE instrument_name = 'trumpet'), 'TP123456', 'available');



INSERT INTO rental_instrument (rental_id, individual_instrument_id, student_id)
VALUES
  ((SELECT rental_id FROM rental WHERE student_id = (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims'))),
   (SELECT individual_instrument_id FROM individual_instrument WHERE serial_number = 'GT123456'), 
   (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Chancellor' AND last_name = 'Sims'))),
  
  ((SELECT rental_id FROM rental WHERE student_id = (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll'))),
   (SELECT individual_instrument_id FROM individual_instrument WHERE serial_number = 'FL123456'),
   (SELECT student_id FROM student WHERE person_id = (SELECT person_id FROM person WHERE first_name = 'Allistair' AND last_name = 'Carroll')));



