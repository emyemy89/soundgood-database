
---Person---
INSERT INTO person (first_name,last_name,personal_num,email,city,address,postalZip)
VALUES
  ('Chancellor','Sims','25636315','felis.purus@hotmail.net','Galway','928-9035 Nulla Ave','528084'),
  ('Wang','Pickett','15920741','vulputate.lacus@google.com','Hérouville-Saint-Clair','619-949 Et Av.','62152'),
  ('Allistair','Carroll','1386278','arcu.et.pede@icloud.net','Almelo','Ap #431-2125 Sed Road','263295'),
  ('Hayes','Wyatt','4698685','nisl.quisque@aol.com','Feldkirchen in Kärnten','455-6929 Eros St.','537692'),
  ('Nyssa','Adkins','12102796','massa.rutrum@yahoo.edu','Laoag','Ap #939-4783 Massa. St.','226563'),
  ('Lionel','Ferrell','23269748','in@google.com','Suwon','683-3654 Vel Rd.','36271'),
  ('Benedict','Mcgee','32684794','vehicula@protonmail.ca','Owerri','Ap #425-778 In, Road','715562'),
  ('Kathleen','Branch','46439154','non.magna@google.org','San Marcos','968-8094 Nulla Av.','39743'),
  ('Reece','Diaz','415298','vitae.sodales@yahoo.com','Pontarlier','Ap #780-7485 Semper. St.','8324'),
  ('Cameron','Moss','4417915','mi.pede@protonmail.org','Okpoko','Ap #900-3155 Nisl Rd.','61010'),
  ('Shana','Clark','11451382','tempus.risus@protonmail.ca','Pangkalpinang','P.O. Box 246, 3518 Integer Road','917643'),
  ('Stone','Baker','32149578','habitant.morbi@outlook.net','Ełk','9842 Hymenaeos. Rd.','307884'),
  ('Zorita','Lynch','8436186','rhoncus@hotmail.edu','Macon','P.O. Box 239, 6456 Enim. Road','2814'),
  ('Lane','Collins','3368933','risus.quisque@yahoo.org','Stockerau','Ap #775-2450 At Rd.','3154'),
  ('Cleo','Carpenter','46520509','eleifend.vitae@icloud.edu','Ogbomosho','Ap #884-8605 Penatibus Rd.','13027'),
  ('Wesley','Compton','14237611','elementum.at@aol.couk','Palangka Raya','Ap #839-1747 Laoreet Rd.','87155'),
  ('Xander','Sellers','22386551','laoreet.ipsum.curabitur@hotmail.ca','Krasnaya Yaruga','Ap #583-7729 Vivamus Rd.','65348'),
  ('Charity','Ayala','3758542','aliquet.libero@google.couk','Kremenchuk','7837 Suspendisse Ave','2362'),
  ('Hayes','Nicholson','27153143','phasellus.libero.mauris@yahoo.ca','Seoul','Ap #268-7342 Nullam St.','27331'),
  ('Jermaine','Gould','39600999','quisque.libero.lacus@google.edu','Simon''s Town','Ap #693-1232 Nunc Street','415537');

---Student---
INSERT INTO student (level_skills,contact_person_id,person_id)
VALUES
  ('beginner',6111,2737),
  ('intermediate',1339,3027),
  ('advanced',4705,9087),
  ('beginner',3257,3838),
  ('intermediate',9679,4354),
  ('advanced',9103,1303),
  ('beginner',4113,3616),
  ('intermediate',5250,7255),
  ('advanced',9194,6851),
  ('beginner',2730,6067),
  ('intermediate',7460,1345),
  ('advanced',4537,6560),
  ('beginner',1419,5031),
  ('intermediate',2338,6065),
  ('advanced',6006,8898),
  ('beginner',9270,5226),
  ('intermediate',5861,3964),
  ('advanced',3390,3870),
  ('beginner',1669,8836),
  ('intermediate',4020,3622);
---Sibling---
INSERT INTO sibling (id,student_id)
VALUES
  (6111,2737),
  (1339,3027),
  (4705,9087),
  (3257,3838),
  (9679,4354),
  (9103,1303),
  (4113,3616),
  (5250,7255),
  (9194,6851),
  (2730,6067),
  (7460,1345),
  (4537,6560),
  (1419,5031),
  (2338,6065),
  (6006,8898),
  (9270,5226),
  (5861,3964),
  (3390,3870),
  (1669,8836),
  (4020,3622);
---Student Lesson---
INSERT INTO student_lesson (student_id,lesson_id)
VALUES
  (2142,5971),
  (8000,4881),
  (1625,2586),
  (3453,6605),
  (9227,5493),
  (1201,4524),
  (5445,7139),
  (5954,8220),
  (5554,5801),
  (9950,8228),
  (7667,9810),
  (7459,4290),
  (4468,8733),
  (6070,8856),
  (2350,9244),
  (2523,5635),
  (3167,1317),
  (8280,7699),
  (6312,1479),
  (2727,3915);
---Contact Person---
INSERT INTO contact_person (first_name,last_name,personal_num)
VALUES
  ('Walker Wright','Erica Dillon','366664815'),
  ('Jakeem Ashley','Germane Morales','313977692'),
  ('Kirestin Baxter','Leah Santos','491662182'),
  ('Britanni Wolf','Farrah Gould','216042409'),
  ('Chantale Berger','Dennis Stephens','294456554'),
  ('Inez Holloway','Clayton Mendez','254361569'),
  ('Brock Merritt','Nolan Wynn','462334974'),
  ('Neve Coffey','Indira Crane','199861808'),
  ('Wylie Rojas','Yuri Tucker','402259957'),
  ('Barbara Spears','Zachary Mcpherson','431657465'),
  ('Amanda Strong','Octavia Rice','476554411'),
  ('Evan Evans','Vernon Griffin','462794746'),
  ('Kessie Gibbs','Stuart Workman','492895687'),
  ('Savannah O''Neill','Camilla Mcdaniel','243454360'),
  ('Louis Burt','Rahim Stewart','459383344'),
  ('Merrill Hudson','Claire Holman','253853514'),
  ('Jack Golden','Violet Ray','228966827'),
  ('Whitney Stokes','Yuli Harper','64683306'),
  ('Gil Holloway','August Harvey','25147227'),
  ('Joel Acevedo','Dominic Ratliff','441063458');
---Contact Phone---
INSERT INTO contact_phone (phone_num,contact_person_id)
VALUES
  ('+46 47 837 24 69','28737129-2'),
  ('+46 57 461 90 25','47157692-1'),
  ('+46 40 638 38 25','19169823-1'),
  ('+46 63 822 57 12','45660593-1'),
  ('+46 42 217 13 18','38476574-2'),
  ('+46 65 555 65 27','1066861-1'),
  ('+46 66 714 52 81','31304840-3'),
  ('+46 24 371 34 66','15791193-7'),
  ('+46 13 571 57 82','4591591-3'),
  ('+46 52 273 67 59','18835804-7'),
  ('+46 72 526 55 32','10492658-4'),
  ('+46 78 229 74 42','25852681-3'),
  ('+46 44 341 88 53','3884497-0'),
  ('+46 33 112 62 45','395532-K'),
  ('+46 27 154 43 53','25321389-2'),
  ('+46 53 761 82 54','29113474-2'),
  ('+46 85 755 44 48','40191545-1'),
  ('+46 47 151 20 41','46789672-5'),
  ('+46 50 988 63 77','39132125-6'),
  ('+46 89 325 65 39','37653719-6');
---Rental---
INSERT INTO rental (starting_date,ending_date)
VALUES
('Apr 30, 2024', 'Apr 30, 2025')  
('Jul 07, 2024', 'Jul 07, 2025')  
('Aug 05, 2024', 'Aug 05, 2025')  
('Jun 02, 2024', 'Jun 02, 2025')  
('Oct 17, 2024', 'Oct 17, 2025')  
('Feb 20, 2024', 'Feb 19, 2025')  
('Jul 25, 2024', 'Jul 25, 2025')  
('Sep 24, 2024', 'Sep 24, 2025')  
('Jun 19, 2024', 'Jun 19, 2025')  
('Oct 08, 2024', 'Oct 08, 2025')  
('Dec 10, 2024', 'Dec 10, 2025')  
('Mar 01, 2024', 'Mar 01, 2025')  
('Nov 07, 2024', 'Nov 07, 2025')  
('Nov 09, 2024', 'Nov 09, 2025')  
('Apr 20, 2024', 'Apr 20, 2025')  
('Jan 01, 2024', 'Dec 31, 2024')  
('Jul 16, 2024', 'Jul 16, 2025')  
('Jan 27, 2024', 'Jan 26, 2025')  
('May 10, 2024', 'May 10, 2025')  
('Nov 01, 2024', 'Nov 01, 2025')  
---Rental Instrument---
INSERT INTO rental_instrument (rental_id,instrument_id)
VALUES
  (4816,2147),
  (3226,6523),
  (8209,2796),
  (2115,4446),
  (8991,7073),
  (3289,1204),
  (5249,7286),
  (9099,6039),
  (2312,4856),
  (9106,9127),
  (3068,7372),
  (2083,1653),
  (1181,5808),
  (6706,3190),
  (3970,1789),
  (7220,2370),
  (3500,5382),
  (2407,8479),
  (9986,1895),
  (4694,3716);
---Instrument---
INSERT INTO instrument (rental_price,type_of_instrument,brand,quantity)
VALUES
  ('$60.78','Harp','Buffet',1),
  ('$5.57','Oboe','Ludwig',1),
  ('$60.06','Harp','Rico',1),
  ('$78.05','Violin','Taylor',4),
  ('$73.02','Accordion','Roland',8),
  ('$4.29','Clarinet','Casio',2),
  ('$83.83','Flute','Selmer',6),
  ('$81.70','Banjo','Ibanez',2),
  ('$42.26','Harp','Buffet',2),
  ('$84.73','Guitar','Buffet',7),
  ('$77.12','Cello','Casio',6),
  ('$25.86','Trumpet','Crampon',9),
  ('$78.61','Mandolin','Ludwig',7),
  ('$80.45','Flute','Taylor',2),
  ('$54.64','Clarinet','Ibanez',5),
  ('$97.62','Trombone','Gibson',4),
  ('$74.57','Bagpipes','Kawai',7),
  ('$58.91','Violin','Bach',5),
  ('$63.05','Synthesizer','Conn',4),
  ('$89.50','Cello','Taylor',4);
---Lesson---
INSERT INTO lesson (instructor_id,price_list_id)
VALUES
  (1879,6489),
  (2001,6713),
  (7195,2418),
  (7565,2117),
  (4865,5254),
  (3079,7393),
  (8638,3334),
  (9371,5881),
  (4262,7623),
  (3054,7674),
  (9662,8742),
  (9956,3483),
  (1849,6970),
  (1552,5804),
  (2501,3573),
  (5623,4832),
  (7687,1827),
  (2811,9976),
  (1667,9683),
  (3626,9861);
---Ensemble---
INSERT INTO ensemble (genre,min_num_of_students,max_num_of_students,student_count)
VALUES
  ('Punk',10,50,32),
  ('Blues',10,50,19),
  ('Funk',10,50,20),
  ('Funk',10,50,25),
  ('Reggae',10,50,13),
  ('R&B',10,50,40),
  ('Blues',10,50,31),
  ('Opera',10,50,20),
  ('Pop',10,50,15),
  ('Metal',10,50,18),
  ('Classical',10,50,16),
  ('Jazz',10,50,50),
  ('Soul',10,50,22),
  ('Blues',10,50,20),
  ('Hip-Hop',10,50,15),
  ('Jazz',10,50,25),
  ('Reggae',10,50,29),
  ('R&B',10,50,17),
  ('Disco',10,50,45),
  ('Opera',10,50,37);






