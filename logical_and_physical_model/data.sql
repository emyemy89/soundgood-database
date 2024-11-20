
---Person---
INSERT INTO person (person_id, first_name, last_name, personal_num, email, city, address, postalZip)
VALUES
  (2737, 'Chancellor', 'Sims', '25636315', 'felis.purus@hotmail.net', 'Galway', '928-9035 Nulla Ave', '528084'),
  (3027, 'Wang', 'Pickett', '15920741', 'vulputate.lacus@google.com', 'Hérouville-Saint-Clair', '619-949 Et Av.', '62152'),
  (9087, 'Allistair', 'Carroll', '1386278', 'arcu.et.pede@icloud.net', 'Almelo', 'Ap #431-2125 Sed Road', '263295'),
  (3838, 'Hayes', 'Wyatt', '4698685', 'nisl.quisque@aol.com', 'Feldkirchen in Kärnten', '455-6929 Eros St.', '537692'),
  (4354, 'Nyssa', 'Adkins', '12102796', 'massa.rutrum@yahoo.edu', 'Laoag', 'Ap #939-4783 Massa. St.', '226563'),
  (1303, 'Lionel', 'Ferrell', '23269748', 'in@google.com', 'Suwon', '683-3654 Vel Rd.', '36271'),
  (3616, 'Benedict', 'Mcgee', '32684794', 'vehicula@protonmail.ca', 'Owerri', 'Ap #425-778 In, Road', '715562'),
  (7255, 'Kathleen', 'Branch', '46439154', 'non.magna@google.org', 'San Marcos', '968-8094 Nulla Av.', '39743'),
  (6851, 'Reece', 'Diaz', '415298', 'vitae.sodales@yahoo.com', 'Pontarlier', 'Ap #780-7485 Semper. St.', '8324'),
  (6067, 'Cameron', 'Moss', '4417915', 'mi.pede@protonmail.org', 'Okpoko', 'Ap #900-3155 Nisl Rd.', '61010'),
  (1345, 'Shana', 'Clark', '11451382', 'tempus.risus@protonmail.ca', 'Pangkalpinang', 'P.O. Box 246, 3518 Integer Road', '917643'),
  (6560, 'Stone', 'Baker', '32149578', 'habitant.morbi@outlook.net', 'Ełk', '9842 Hymenaeos. Rd.', '307884'),
  (5031, 'Zorita', 'Lynch', '8436186', 'rhoncus@hotmail.edu', 'Macon', 'P.O. Box 239, 6456 Enim. Road', '2814'),
  (6065, 'Lane', 'Collins', '3368933', 'risus.quisque@yahoo.org', 'Stockerau', 'Ap #775-2450 At Rd.', '3154'),
  (8898, 'Cleo', 'Carpenter', '46520509', 'eleifend.vitae@icloud.edu', 'Ogbomosho', 'Ap #884-8605 Penatibus Rd.', '13027'),
  (5226, 'Wesley', 'Compton', '14237611', 'elementum.at@aol.couk', 'Palangka Raya', 'Ap #839-1747 Laoreet Rd.', '87155'),
  (3964, 'Xander', 'Sellers', '22386551', 'laoreet.ipsum.curabitur@hotmail.ca', 'Krasnaya Yaruga', 'Ap #583-7729 Vivamus Rd.', '65348'),
  (3870, 'Charity', 'Ayala', '3758542', 'aliquet.libero@google.couk', 'Kremenchuk', '7837 Suspendisse Ave', '2362'),
  (8836, 'Hayes', 'Nicholson', '27153143', 'phasellus.libero.mauris@yahoo.ca', 'Seoul', 'Ap #268-7342 Nullam St.', '27331'),
  (3622, 'Jermaine', 'Gould', '39600999', 'quisque.libero.lacus@google.edu', 'Simon''s Town', 'Ap #693-1232 Nunc Street', '415537');
---Student---
INSERT INTO student (student_id, level_skills, contact_person_id, person_id)
VALUES
  (1234, 'beginner', 6111, 2737),
  (2345, 'intermediate', 1339, 3027),
  (3456, 'advanced', 4705, 9087),
  (4567, 'beginner', 3257, 3838),
  (5678, 'intermediate', 9679, 4354),
  (6789, 'advanced', 9103, 1303),
  (7890, 'beginner', 4113, 3616),
  (8901, 'intermediate', 5250, 7255),
  (9012, 'advanced', 9194, 6851),
  (1123, 'beginner', 2730, 6067),
  (2234, 'intermediate', 7460, 1345),
  (3345, 'advanced', 4537, 6560),
  (4456, 'beginner', 1419, 5031),
  (5567, 'intermediate', 2338, 6065),
  (6678, 'advanced', 6006, 8898),
  (7789, 'beginner', 9270, 5226),
  (8890, 'intermediate', 5861, 3964),
  (9901, 'advanced', 3390, 3870),
  (1012, 'beginner', 1669, 8836),
  (1213, 'intermediate', 4020, 3622);
---Contact Person---
INSERT INTO contact_person (contact_person_id, first_name, last_name, personal_num)
VALUES
  (6111, 'Walker', 'Wright', '366664815'),
  (1339, 'Jakeem', 'Ashley', '313977692'),
  (4705, 'Kirestin', 'Baxter', '491662182'),
  (3257, 'Britanni', 'Wolf', '216042409'),
  (9679, 'Chantale', 'Berger', '294456554'),
  (9103, 'Inez', 'Holloway', '254361569'),
  (4113, 'Brock', 'Merritt', '462334974'),
  (5250, 'Neve', 'Coffey', '199861808'),
  (9194, 'Wylie', 'Rojas', '402259957'),
  (2730, 'Barbara', 'Spears', '431657465'),
  (7460, 'Amanda', 'Strong', '476554411'),
  (4537, 'Evan', 'Evans', '462794746'),
  (1419, 'Kessie', 'Gibbs', '492895687'),
  (2338, 'Savannah', 'O''Neill', '243454360'),
  (6006, 'Louis', 'Burt', '459383344'),
  (9270, 'Merrill', 'Hudson', '253853514'),
  (5861, 'Jack', 'Golden', '228966827'),
  (3390, 'Whitney', 'Stokes', '64683306'),
  (1669, 'Gil', 'Holloway', '25147227'),
  (4020, 'Joel', 'Acevedo', '441063458');
--Contact person phone---
INSERT INTO contact_phone (phone_num, contact_person_id)
VALUES
  ('+46 47 837 24 69', 6111),
  ('+46 57 461 90 25', 1339),
  ('+46 40 638 38 25', 4705),
  ('+46 63 822 57 12', 3257),
  ('+46 42 217 13 18', 9679),
  ('+46 65 555 65 27', 9103),
  ('+46 66 714 52 81', 4113),
  ('+46 24 371 34 66', 5250),
  ('+46 13 571 57 82', 9194),
  ('+46 52 273 67 59', 2730),
  ('+46 72 526 55 32', 7460),
  ('+46 78 229 74 42', 4537),
  ('+46 44 341 88 53', 1419),
  ('+46 33 112 62 45', 2338),
  ('+46 27 154 43 53', 6006),
  ('+46 53 761 82 54', 9270),
  ('+46 85 755 44 48', 5861),
  ('+46 47 151 20 41', 3390),
  ('+46 50 988 63 77', 1669),
  ('+46 89 325 65 39', 4020);
---Sibling---
INSERT INTO sibling_student (sibling_student_id, student_id)
VALUES
  (4321, 1234),
  (5432, 2345),
  (6543, 3456),
  (7654, 4567),
  (8765, 5678),
  (9876, 6789),
  (1098, 7890),
  (2109, 8901),
  (3210, 9012),
  (4320, 1123),
  (5431, 2234),
  (6542, 3345),
  (7653, 4456),
  (8764, 5567),
  (9875, 6678),
  (1097, 7789),
  (2108, 8890),
  (3219, 9901),
  (4329, 1012),
  (5438, 1213);
---Rental---
INSERT INTO rental (rental_id, starting_date, ending_date, student_id)
VALUES
  (1001, 'Apr 30, 2024', 'Apr 30, 2025', 1234),
  (1002, 'Jul 07, 2024', 'Jul 07, 2025', 2345),
  (1003, 'Aug 05, 2024', 'Aug 05, 2025', 3456),
  (1004, 'Jun 02, 2024', 'Jun 02, 2025', 4567),
  (1005, 'Oct 17, 2024', 'Oct 17, 2025', 5678),
  (1006, 'Feb 20, 2024', 'Feb 19, 2025', 6789),
  (1007, 'Jul 25, 2024', 'Jul 25, 2025', 7890),
  (1008, 'Sep 24, 2024', 'Sep 24, 2025', 8901),
  (1009, 'Jun 19, 2024', 'Jun 19, 2025', 9012),
  (1010, 'Oct 08, 2024', 'Oct 08, 2025', 1123),
  (1011, 'Dec 10, 2024', 'Dec 10, 2025', 2234),
  (1012, 'Mar 01, 2024', 'Mar 01, 2025', 3345),
  (1013, 'Nov 07, 2024', 'Nov 07, 2025', 4456),
  (1014, 'Nov 09, 2024', 'Nov 09, 2025', 5567),
  (1015, 'Apr 20, 2024', 'Apr 20, 2025', 6678),
  (1016, 'Jan 01, 2024', 'Dec 31, 2024', 7789),
  (1017, 'Jul 16, 2024', 'Jul 16, 2025', 8890),
  (1018, 'Jan 27, 2024', 'Jan 26, 2025', 9901),
  (1019, 'May 10, 2024', 'May 10, 2025', 1012),
  (1020, 'Nov 01, 2024', 'Nov 01, 2025', 1213);
---Student Lesson---
INSERT INTO student_lesson (student_id, lesson_id)
VALUES
  (1234, 1879),
  (2345, 2001),
  (3456, 7195),
  (4567, 7565),
  (5678, 4865),
  (6789, 3079),
  (7890, 8638),
  (8901, 9371),
  (9012, 4262),
  (1123, 3054),
  (2234, 9662),
  (3345, 9956),
  (4456, 1849),
  (5567, 1552),
  (6678, 2501),
  (7789, 5623),
  (8890, 7687),
  (9901, 2811),
  (1012, 1667),
  (1213, 3626);

---Rental Instrument---
INSERT INTO rental_instrument (rental_id, instrument_id)
VALUES
  (1001, 2001),
  (1002, 2002),
  (1003, 2003),
  (1004, 2004),
  (1005, 2005),
  (1006, 2006),
  (1007, 2007),
  (1008, 2008),
  (1009, 2009),
  (1010, 2010),
  (1011, 2011),
  (1012, 2012),
  (1013, 2013),
  (1014, 2014),
  (1015, 2015),
  (1016, 2016),
  (1017, 2017),
  (1018, 2018),
  (1019, 2019),
  (1020, 2020);
---Instrument---
INSERT INTO instrument (instrument_id, rental_price, type_of_instrument, brand, quantity)
VALUES
  (2001, '$60.78', 'Harp', 'Buffet', 1),
  (2002, '$5.57', 'Oboe', 'Ludwig', 1),
  (2003, '$60.06', 'Violin', 'Rico', 1),
  (2004, '$78.05', 'Accordion', 'Roland', 8),
  (2005, '$73.02', 'Clarinet', 'Casio', 2),
  (2006, '$83.83', 'Flute', 'Selmer', 6),
  (2007, '$81.70', 'Banjo', 'Ibanez', 2),
  (2008, '$42.26', 'Guitar', 'Buffet', 7),
  (2009, '$77.12', 'Cello', 'Casio', 6),
  (2010, '$25.86', 'Trumpet', 'Crampon', 9),
  (2011, '$78.61', 'Mandolin', 'Ludwig', 7),
  (2012, '$97.62', 'Timpani', 'Gibson', 4),
  (2013, '$54.64', 'Saxophone', 'Selmer', 5),
  (2014, '$97.62', 'Trombone', 'Gibson', 4),
  (2015, '$74.57', 'Bagpipes', 'Kawai', 7),
  (2016, '$58.91', 'Double Bass', 'Kawai', 4),
  (2017, '$63.05', 'Synthesizer', 'Conn', 4),
  (2018, '$89.50', 'Marimba', 'Adams', 2),
  (2019, '$82.90', 'French Horn', 'Conn', 3),
  (2020, '$60.50', 'Bassoon', 'Fox', 2);
---Lesson---
INSERT INTO lesson (lesson_id, instructor_id, price_list_id)
VALUES
  (1879, 6489, 1101),
  (2001, 6713, 1102),
  (7195, 2418, 1103),
  (7565, 2117, 1104),
  (4865, 5254, 1105),
  (3079, 7393, 1106),
  (8638, 3334, 1107),
  (9371, 5881, 1108),
  (4262, 7623, 1109),
  (3054, 7674, 1110),
  (9662, 8742, 1111),
  (9956, 3483, 1112),
  (1849, 6970, 1113),
  (1552, 5804, 1114),
  (2501, 3573, 1115),
  (5623, 4832, 1116),
  (7687, 1827, 1117),
  (2811, 9976, 1118),
  (1667, 9683, 1119),
  (3626, 9861, 1120);
---Ensemble---
INSERT INTO ensemble (lesson_id, genre, min_num_of_students, max_num_of_students, student_count)
VALUES
  (1879, 'Punk', 10, 50, 32),
  (2001, 'Blues', 10, 50, 19),
  (7195, 'Funk', 10, 50, 20),
  (7565, 'Funk', 10, 50, 25),
  (4865, 'Reggae', 10, 50, 13),
  (3079, 'R&B', 10, 50, 40),
  (8638, 'Blues', 10, 50, 31),
  (9371, 'Opera', 10, 50, 20),
  (4262, 'Pop', 10, 50, 15),
  (3054, 'Metal', 10, 50, 18),
  (9662, 'Classical', 10, 50, 16),
  (9956, 'Jazz', 10, 50, 50),
  (1849, 'Soul', 10, 50, 22),
  (1552, 'Blues', 10, 50, 20),
  (2501, 'Hip-Hop', 10, 50, 15),
  (5623, 'Jazz', 10, 50, 25),
  (7687, 'Reggae', 10, 50, 29),
  (2811, 'R&B', 10, 50, 17),
  (1667, 'Disco', 10, 50, 45),
  (3626, 'Opera', 10, 50, 37);
---Group Lesson---
INSERT INTO group_lesson (lesson_id, min_num_of_students, constant, student_count, instrument_used, skill_level_id)
VALUES
  (1879, 10, 50, 11, 'Harp', 2),
  (2001, 10, 50, 43, 'Oboe', 1),
  (7195, 10, 50, 33, 'Violin', 3),
  (7565, 10, 50, 25, 'Accordion', 2),
  (4865, 10, 50, 12, 'Clarinet', 1),
  (3079, 10, 50, 26, 'Flute', 3),
  (8638, 10, 50, 36, 'Banjo', 2),
  (9371, 10, 50, 49, 'Guitar', 1),
  (4262, 10, 50, 28, 'Cello', 3),
  (3054, 10, 50, 26, 'Trumpet', 2),
  (9662, 10, 50, 18, 'Mandolin', 1),
  (9956, 10, 50, 15, 'Timpani', 3),
  (1849, 10, 50, 10, 'Saxophone', 2),
  (1552, 10, 50, 43, 'Trombone', 3),
  (2501, 10, 50, 14, 'Bagpipes', 1),
  (5623, 10, 50, 13, 'Double Bass', 2),
  (7687, 10, 50, 44, 'Synthesizer', 1),
  (2811, 10, 50, 27, 'Marimba', 3),
  (1667, 10, 50, 42, 'French Horn', 2),
  (3626, 10, 50, 43, 'Bassoon', 3);
---Time Slot---
INSERT INTO time_slot (start_time, end_time, date_slot, lesson_id)
VALUES
  (8, 12, 9, 1879),
  (9, 11, 10, 2001),
  (10, 13, 26, 7195),
  (12, 14, 21, 7565),
  (11, 10, 22, 4865),
  (14, 12, 4, 3079),
  (14, 15, 13, 8638),
  (12, 14, 26, 9371),
  (16, 14, 9, 4262),
  (8, 10, 28, 3054),
  (12, 9, 25, 9662),
  (10, 15, 2, 9956),
  (13, 13, 28, 1849),
  (11, 9, 28, 1552),
  (15, 15, 25, 2501),
  (13, 16, 26, 5623),
  (9, 10, 15, 7687),
  (15, 15, 5, 2811),
  (14, 8, 12, 1667),
  (9, 11, 16, 3626);
---Phone---
INSERT INTO phone (phone, person_id)
VALUES
  ('+46 28 458 71 24', 2737),
  ('+46 26 281 84 93', 3027),
  ('+46 27 881 26 47', 9087),
  ('+46 21 569 30 81', 3838),
  ('+46 17 288 72 67', 4354),
  ('+46 58 675 30 28', 1303),
  ('+46 41 378 88 17', 3616),
  ('+46 81 413 95 12', 7255),
  ('+46 21 888 47 40', 6851),
  ('+46 29 164 66 87', 6067),
  ('+46 74 176 68 48', 1345),
  ('+46 35 962 19 58', 6560),
  ('+46 83 347 43 51', 5031),
  ('+46 22 612 52 18', 6065),
  ('+46 58 244 17 76', 8898),
  ('+46 41 362 57 64', 5226),
  ('+46 46 698 82 42', 3964),
  ('+46 98 913 83 72', 3870),
  ('+46 73 264 92 40', 8836),
  ('+46 64 430 98 82', 3622);
---Instructor---
INSERT INTO instructor (instructor_id, employment_id, person_id)
VALUES
  (6489, 1774, 2737),  
  (6713, 7155, 3027),
  (2418, 3819, 9087),
  (2117, 2741, 3838),
  (5254, 2278, 4354),
  (7393, 7292, 1303),
  (3334, 2566, 3616),
  (5473, 4044, 7255),
  (5881, 5004, 6851),
  (7623, 9535, 6067),
  (8742, 6447, 1345),
  (3483, 9079, 6560),
  (6970, 6246, 5031),
  (5804, 5048, 6065),
  (3573, 8844, 8898),
  (4832, 7234, 5226),
  (1827, 6122, 3964),
  (9976, 2057, 3870),
  (9683, 2012, 8836);
---Instructor Availbility---
INSERT INTO instructor_availability (date_slot, start_time, end_time, instructor_id)
VALUES
  (9, 8, 16, 6489), 
  (10, 8, 16, 6713),
  (26, 8, 16, 2418),
  (21, 8, 16, 2117),
  (22, 8, 16, 5254),
  (4, 8, 16, 7393),
  (13, 8, 16, 3334),
  (26, 8, 16, 5473),
  (9, 8, 16, 5881),
  (25, 8, 16, 7623),
  (28, 8, 16, 8742),
  (2, 8, 16, 3483),
  (28, 8, 16, 6970),
  (28, 8, 16, 5804),
  (25, 8, 16, 3573),
  (26, 8, 16, 4832),
  (5, 8, 16, 1827),
  (12, 8, 16, 9976),
  (16, 8, 16, 9683);
---Individual Lesson---
INSERT INTO individual_lesson (lesson_id, instrument, skill_level_id)
VALUES
  (1879, 'Harp', 2),
  (2001, 'Oboe', 1),
  (7195, 'Violin', 3),
  (7565, 'Accordion', 2),
  (4865, 'Clarinet', 1),
  (3079, 'Flute', 3),
  (8638, 'Banjo', 2),
  (9371, 'Guitar', 1),
  (4262, 'Cello', 3),
  (3054, 'Trumpet', 2),
  (9662, 'Mandolin', 1),
  (9956, 'Timpani', 3),
  (1849, 'Saxophone', 2),
  (1552, 'Trombone', 3),
  (2501, 'Bagpipes', 1),
  (5623, 'Double Bass', 2),
  (7687, 'Synthesizer', 1),
  (2811, 'Marimba', 3),
  (1667, 'French Horn', 2),
  (3626, 'Bassoon', 3);
---Instrument Instructor---
INSERT INTO instrument_instructor (instrument_instructor, instructor_id)
VALUES
  ('Harp', 6489),
  ('Oboe', 6713),
  ('Violin', 2418),
  ('Accordion', 2117),
  ('Clarinet', 5254),
  ('Flute', 7393),
  ('Banjo', 3334),
  ('Guitar', 5473),
  ('Cello', 5881),
  ('Trumpet', 7623),
  ('Mandolin', 8742),
  ('Timpani', 3483),
  ('Saxophone', 6970),
  ('Trombone', 5804),
  ('Bagpipes', 3573),
  ('Double Bass', 4832),
  ('Synthesizer', 1827),
  ('Marimba', 9976),
  ('French Horn', 9683),
  ('Bassoon', 2012);
---Price List---
INSERT INTO price_list (price_list_id, price, lesson_type_id, skill_level_id)
VALUES
  (1101, '$3.25', 2, 2),
  (1102, '$89.19', 1, 2),
  (1103, '$81.79', 3, 2),
  (1104, '$68.47', 3, 2),
  (1105, '$49.93', 2, 2),
  (1106, '$96.52', 3, 1),
  (1107, '$51.23', 1, 2),
  (1108, '$53.31', 2, 1),
  (1109, '$56.27', 1, 2),
  (1110, '$9.76', 3, 2),
  (1111, '$83.25', 2, 3),
  (1112, '$72.64', 2, 1),
  (1113, '$67.54', 2, 2),
  (1114, '$76.17', 2, 1),
  (1115, '$82.50', 3, 2),
  (1116, '$41.75', 3, 2),
  (1117, '$93.20', 2, 3),
  (1118, '$76.65', 3, 1),
  (1119, '$75.43', 2, 2),
  (1120, '$7.31', 3, 1);
---Lesson Type Lookup---
INSERT INTO lesson_type_lookup (lesson_type_id,lesson_type)
VALUES
  (1,individual_lesson),
  (2,group_lesson),
  (3,ensemble),

---Skill Level Lookup---
INSERT INTO lesson_type_lookup (lesson_type_id,lesson_type)
VALUES
  (1,beginner),
  (2,intermediate),
  (3,advanced),


















