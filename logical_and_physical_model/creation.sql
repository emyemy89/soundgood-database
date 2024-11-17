CREATE TABLE person(
        id SERIAL PRIMARY KEY,
        first_name   VARCHAR(500) NOT NULL,
        last_name    VARCHAR(500) NOT NULL,
        personal_num VARCHAR(50) UNIQUE NOT NULL,
        email        VARCHAR(500),
        city         VARCHAR(500),
        street       VARCHAR(500),
        zip          VARCHAR(50)
);

CREATE TABLE student(
        id SERIAL PRIMARY KEY,
        level_skills      VARCHAR(50) NOT NULL,
        contact_person_id INT, --not null???
        person_id         INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id),
        FOREIGN KEY (person_id) REFERENCES person(id) --delete cascade??
);


CREATE TABLE contact_person(
        contact_person_id SERIAL PRIMARY KEY,
        first_name   VARCHAR(500),
        last_name    VARCHAR(500),
        personal_num VARCHAR(50)
);

CREATE TABLE contact_phone(
        phone_nb          VARCHAR(50) NOT NULL,
        contact_person_id INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id) ON DELETE CASCADE,
        PRIMARY KEY(phone_nb, contact_person_id)
);

CREATE TABLE instructor(
        id SERIAL PRIMARY KEY,
        employment ID varchar(500) NOT NULL,
        person_id     INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(id) --delete cascade?
);

CREATE TABLE phone(
        phone     VARCHAR(50) NOT NULL,
        person_id INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(id) --delete cascade?
);

CREATE TABLE sibling(
        sibling_id VARCHAR(50) NOT NULL,
        student_id INT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(id),
        PRIMARY KEY(sibling_id,student_id)
);

CREATE TABLE student_lesson(
            student_id INT NOT NULL,
            lesson_id  INT NOT NULL,
            FOREIGN KEY(student_id) REFERENCES student(id),
            FOREIGN KEY(lesson_id) REFERENCES lesson(id),
            PRIMARY KEY(student_id, lesson_id)
);

CREATE TABLE instructor_availability(
            availability_date DATE NOT NULL,
            start_time        TIME NOT NULL,
            end_time          TIME NOT NULL,
            instructor_id     INT NOT NULL,
            FOREIGN KEY (instructor_id) REFERENCES instructor(id),
            PRIMARY KEY (availability_date, start_time, end_time, instructor_id)
);


CREATE TABLE rental(
            id SERIAL PRIMARY KEY,
            start_date DATE NOT NULL,
            end_date   DATE NOT NULL,
            student_id INT NOT NULL,
            FOREIGN KEY(student_id) REFERENCES student(id)
);


CREATE TABLE instrument(
            id SERIAL PRIMARY KEY,
            rental_price VARCHAR(50),
            type         VARCHAR(500) NOT NULL,
            brand        VARCHAR(500) NOT NULL,
            quantity     VARCHAR(50),
            rental_id    INT NOT NULL,
            FOREIGN KEY (rental_id) REFERENCES rental(id) ON DELETE SET NULL
);


CREATE TABLE lesson(
            id SERIAL PRIMARY KEY,
            instructor_id INT, -- not null??
            FOREIGN KEY(instructor_id) REFERENCES instructor(id)
);

CREATE TABLE price_list(
            price_id
);

CREATE TABLE instrument_instructor(
    
);

CREATE TABLE ensemble(
    
);

CREATE TABLE group_lesson(
    
);

CREATE TABLE individual_lesson(
    
);

CREATE TABLE time_slot(
    
);
