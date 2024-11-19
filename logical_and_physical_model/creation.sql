CREATE TABLE person(
        person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name   VARCHAR(500) NOT NULL,
        last_name    VARCHAR(500) NOT NULL,
        personal_num VARCHAR(50) UNIQUE NOT NULL,
        email        VARCHAR(500),
        city         VARCHAR(500),
        street       VARCHAR(500),
        zip          VARCHAR(50)
);

CREATE TABLE student(
        student_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        level_skills      VARCHAR(50) NOT NULL,
        contact_person_id INT,
        person_id         INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id),
        FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);


CREATE TABLE contact_person(
        contact_person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name   VARCHAR(500),
        last_name    VARCHAR(500),
        personal_num VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE contact_phone(
        phone_nb          VARCHAR(50) NOT NULL,
        contact_person_id INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE CASCADE,
        PRIMARY KEY(phone_nb, contact_person_id)
);

CREATE TABLE instructor(
        instructor_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        employment_id VARCHAR(500) UNIQUE NOT NULL,
        person_id     INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE phone(
        phone_num VARCHAR(50) NOT NULL,
        person_id INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE,
        PRIMARY KEY(phone_num, person_id)
);
---- need to be changed ----
CREATE TABLE sibling(
        sibling_student_id INT GENERATED ALWAYS AS IDENTITY,
        student_id INT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
        PRIMARY KEY(sibling_student_id,student_id)
);

CREATE TABLE student_lesson(
        student_id INT NOT NULL,
        lesson_id  INT NOT NULL,
        FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE,
        FOREIGN KEY(lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
        PRIMARY KEY(student_id, lesson_id)
);

CREATE TABLE instructor_availability(
        availability_date DATE NOT NULL,
        start_time        TIME NOT NULL,
        end_time          TIME NOT NULL,
        instructor_id     INT NOT NULL,
        FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE,
        PRIMARY KEY (availability_date, start_time, end_time, instructor_id),
        CHECK(start_time < end_time)
);

-- WE NEED TO ENSURE THAT STARTING_DATE IS < THAN ENDING_DATE
CREATE TABLE rental(
        rental_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        starting_date DATE NOT NULL,
        ending_date   DATE NOT NULL,
        student_id INT NOT NULL,
        FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE,
       -- CHECK(starting_date < ending_date AND ending_date <= starting_date + INTERVALL '12 months')
);



--should rental_price be not null??
CREATE TABLE instrument(
        instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        rental_price VARCHAR(50),
        type_of_instrument  VARCHAR(500) NOT NULL,
        brand        VARCHAR(500) NOT NULL,
        quantity     INT CHECK(quantity > 0)
);


-- shouldn't here be 'on delete set null'??
CREATE TABLE rental_instrument(
        rental_id INT NOT NULL,
        instrument_id INT NOT NULL,
        FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE,
        FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE,
        PRIMARY KEY(rental_id, instrument_id)
);





CREATE TABLE lesson(
        lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        instructor_id INT NOT NULL,                                 
        price_list_id INT NOT NULL,
        FOREIGN KEY(instructor_id) REFERENCES instructor(instructor_id),
        FOREIGN KEY(price_list_id) REFERENCES price_list(price_list_id)
);



CREATE TABLE price_list(
        price_list_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        price VARCHAR(50) NOT NULL,       --NOT NULL?? Yes it should be not null,
        lesson_type_id INT NOT NULL,
        skill_level_id INT NOT NULL,  --- 
        FOREIGN KEY (lesson_type_id) REFERENCES lesson_type_lookup(lesson_type_lookup_id),
        FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(skill_level_lookup_id)
);


--THIS enum CORRECT?
CREATE TABLE lesson_type_lookup(
        lesson_type_lookup_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        lesson_type VARCHAR(50) NOT NULL
);


CREATE TABLE skill_level_lookup(
        skill_level_lookup_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        skill_level VARCHAR(50) NOT NULL
);




CREATE TABLE instrument_instructor(
    instrument_instructor VARCHAR(500) NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY(instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE,
    PRIMARY KEY(instrument_instructor, instructor_id)
);

CREATE TABLE ensemble(
    lesson_id INT NOT NULL,
    genre VARCHAR(500) NOT NULL,
    min_num_of_students INT NOT NULL, -- why we do not store them as INT ??
    max_num_of_students INT NOT NULL, -- why we do not store them as INT ??
    student_count INT NOT NULL DEFAULT 0, -- why we do not store them as INT ??
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id),
    CHECK (min_num_of_students <= max_num_of_students),
    CHECK (student_count <= max_num_of_students)
);



CREATE TABLE group_lesson(
    lesson_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    min_num_of_students INT NOT NULL, -- why we do not store them as INT ??
    max_num_of_students INT NOT NULL,   -- why we do not store them as INT ??
    student_count INT NOT NULL DEFAULT 0, -- why we do not store them as INT ??
    instrument_used VARCHAR(500),
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(skill_level_lookup_id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id),
    CHECK (min_num_of_students <= max_num_of_students),
    CHECK (student_count<= max_num_of_students)
);



CREATE TABLE individual_lesson(
    lesson_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(skill_level_lookup_id) ON DELETE CASCADE,
    PRIMARY KEY (lesson_id)
);



CREATE TABLE time_slot(
        starting_time TIME NOT NULL,
        ending_time TIME NOT NULL,
        date_slot DATE NOT NULL,
        lesson_id INT NOT NULL,
        FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
        PRIMARY KEY(starting_time, ending_time, date_slot,lesson_id)
);

