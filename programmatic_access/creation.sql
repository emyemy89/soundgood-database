CREATE TABLE lesson_type_lookup(
    lesson_type_lookup_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_type VARCHAR(50) NOT NULL
);

CREATE TABLE skill_level_lookup(
    skill_level_lookup_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    skill_level VARCHAR(50) NOT NULL
);

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

CREATE TABLE contact_person(
    contact_person_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name   VARCHAR(500),
    last_name    VARCHAR(500),
    personal_num VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE price_list(
    price_list_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    price VARCHAR(50) NOT NULL,    
    lesson_type_lookup_id INT NOT NULL,
    skill_level_lookup_id INT,  
    date_price DATE NOT NULL,
    FOREIGN KEY (lesson_type_lookup_id) REFERENCES lesson_type_lookup(lesson_type_lookup_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_lookup_id) REFERENCES skill_level_lookup(skill_level_lookup_id) ON DELETE CASCADE
);

CREATE TABLE instructor(
    instructor_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employment_id VARCHAR(500) UNIQUE NOT NULL,
    person_id     INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE lesson(
    lesson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instructor_id INT NOT NULL,                                 
    price_list_id INT NOT NULL,
    FOREIGN KEY(instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE,
    FOREIGN KEY(price_list_id) REFERENCES price_list(price_list_id) ON DELETE CASCADE
);

CREATE TABLE phone(
    phone_num VARCHAR(50) NOT NULL,
    person_id INT NOT NULL,
    FOREIGN KEY(person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    PRIMARY KEY(phone_num, person_id)
);

CREATE TABLE contact_phone(
    phone_num          VARCHAR(50) NOT NULL,
    contact_person_id INT NOT NULL,
    FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE CASCADE,
    PRIMARY KEY(phone_num, contact_person_id)
);

CREATE TABLE student(
    student_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    level_skills      VARCHAR(50) NOT NULL,
    contact_person_id INT,
    person_id         INT NOT NULL,
    FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE SET NULL,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
);

CREATE TABLE sibling_student(
    sibling_student_id INT NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (sibling_student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    PRIMARY KEY(sibling_student_id, student_id)
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

CREATE TABLE rental(
    rental_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    starting_date DATE NOT NULL,
    ending_date   DATE NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY(student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    CONSTRAINT lease_max_duration CHECK (
        (ending_date - starting_date)/30 <= 12
    )
);




CREATE TABLE instrument(
    instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rental_price VARCHAR(50),
    instrument_name VARCHAR(50) NOT NULL,
    type_of_instrument  VARCHAR(500) NOT NULL,
    brand        VARCHAR(500) NOT NULL,
    quantity     INT NOT NULL CHECK(quantity > 0)
);

CREATE TABLE individual_instrument(
    individual_instrument_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instrument_id INT NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'available', -- available, rented
    FOREIGN KEY (instrument_id) REFERENCES instrument(instrument_id) ON DELETE CASCADE
);


CREATE TABLE rental_instrument(
    rental_id INT NOT NULL,
    individual_instrument_id INT NOT NULL,
    student_id INT NOT NULL, 
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id) ON DELETE CASCADE,
    FOREIGN KEY (individual_instrument_id) REFERENCES individual_instrument(individual_instrument_id) ON DELETE SET NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    PRIMARY KEY(rental_id, individual_instrument_id)
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
    min_num_of_students INT NOT NULL,
    max_num_of_students INT NOT NULL, 
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id),
    CHECK (min_num_of_students <= max_num_of_students)
);

CREATE TABLE group_lesson(
    lesson_id INT NOT NULL,
    min_num_of_students INT NOT NULL,
    max_num_of_students INT NOT NULL,   
    instrument_used VARCHAR(500),
    skill_level_lookup_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_lookup_id) REFERENCES skill_level_lookup(skill_level_lookup_id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id),
    CHECK (min_num_of_students <= max_num_of_students)
);

CREATE TABLE individual_lesson(
    lesson_id INT NOT NULL,
    instrument VARCHAR(50) NOT NULL,
    skill_level_lookup_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_lookup_id) REFERENCES skill_level_lookup(skill_level_lookup_id) ON DELETE CASCADE,
    PRIMARY KEY (lesson_id)
);

CREATE TABLE time_slot(
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    date_slot DATE NOT NULL,
    lesson_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    PRIMARY KEY(start_time, end_time, date_slot, lesson_id),
    CHECK(start_time < end_time)
);
