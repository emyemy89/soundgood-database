CREATE TABLE person(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name   VARCHAR(500) NOT NULL,
        last_name    VARCHAR(500) NOT NULL,
        personal_num VARCHAR(50) UNIQUE NOT NULL,
        email        VARCHAR(500),
        city         VARCHAR(500),
        street       VARCHAR(500),
        zip          VARCHAR(50)
);

CREATE TABLE student(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        level_skills      VARCHAR(50) NOT NULL,
        contact_person_id INT NOT NULL,
        person_id         INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(contact_person_id),
        FOREIGN KEY (person_id) REFERENCES person(id) ON DELETE CASCADE
);


CREATE TABLE contact_person(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        first_name   VARCHAR(500),
        last_name    VARCHAR(500),
        personal_num VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE contact_phone(
        phone_nb          VARCHAR(50) NOT NULL,
        contact_person_id INT NOT NULL,
        FOREIGN KEY (contact_person_id) REFERENCES contact_person(id) ON DELETE CASCADE,
        PRIMARY KEY(phone_nb, contact_person_id)
);

CREATE TABLE instructor(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        employment_id VARCHAR(500) UNIQUE NOT NULL,
        person_id     INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE
);

CREATE TABLE phone(
        phone_num VARCHAR(50) NOT NULL,
        person_id INT NOT NULL,
        FOREIGN KEY(person_id) REFERENCES person(id) ON DELETE CASCADE,
        PRIMARY KEY(phone_num, person_id)
);

CREATE TABLE sibling(
        id INT GENERATED ALWAYS AS IDENTITY,
        student_id INT NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
        PRIMARY KEY(id,student_id)
);

CREATE TABLE student_lesson(
        student_id INT NOT NULL,
        lesson_id  INT NOT NULL,
        FOREIGN KEY(student_id) REFERENCES student(id) ON DELETE CASCADE,
        FOREIGN KEY(lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
        PRIMARY KEY(student_id, lesson_id)
);

CREATE TABLE instructor_availability(
        availability_date DATE NOT NULL,
        start_time        TIME NOT NULL,
        end_time          TIME NOT NULL,
        instructor_id     INT NOT NULL,
        FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE,
        PRIMARY KEY (availability_date, start_time, end_time, instructor_id)
);

-- WE NEED TO ENSURE THAT STARTING_DATE < ENDING_DATE
CREATE TABLE rental(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        starting_date DATE NOT NULL,
        ending_date   DATE NOT NULL,
        student_id INT NOT NULL,
        FOREIGN KEY(student_id) REFERENCES student(id) ON DELETE CASCADE,
        CONSTRAINT lease_max_duration CHECK (
                (ending_date- starting_date)/30<=12
        )
);



--should rental_price be not null??
CREATE TABLE instrument(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        rental_price VARCHAR(50),
        type_of_instrument  VARCHAR(500) NOT NULL,
        brand        VARCHAR(500) NOT NULL,
        quantity     VARCHAR(50)
);


-- shouldn't here be 'on delete set null'??
CREATE TABLE rental_instrument(
        rental_id INT NOT NULL,
        instrument_id INT NOT NULL,
        FOREIGN KEY (rental_id) REFERENCES rental(id) ON DELETE CASCADE,
        FOREIGN KEY (instrument_id) REFERENCES instrument(id) ON DELETE CASCADE,
        PRIMARY KEY(rental_id, instrument_id)
);





CREATE TABLE lesson(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        instructor_id INT NOT NULL,                                 
        price_list_id INT NOT NULL,
        FOREIGN KEY(instructor_id) REFERENCES instructor(id),
        FOREIGN KEY(price_list_id) REFERENCES price_list(id)
);



CREATE TABLE price_list(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        price VARCHAR(50),       --NOT NULL??
        lesson_type_id INT NOT NULL,
        skill_level_id INT NOT NULL,
        FOREIGN KEY (lesson_type_id) REFERENCES lesson_type_lookup(id),
        FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(id)
);


--THIS enum CORRECT?
CREATE TABLE lesson_type_lookup(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        lesson_type VARCHAR(50) NOT NULL
);


CREATE TABLE skill_level_lookup(
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        skill_level VARCHAR(50) NOT NULL
);




CREATE TABLE instrument_instructor(
    instrument_instructor VARCHAR(500) NOT NULL,
    instructor_id INT NOT NULL,
    FOREIGN KEY(instructor_id) REFERENCES instructor(id) ON DELETE CASCADE,
    PRIMARY KEY(instrument_instructor, instructor_id)
);

CREATE TABLE ensemble(
    lesson_id INT NOT NULL,
    genre VARCHAR(500) NOT NULL,
    min_num_of_students VARCHAR(50) NOT NULL,
    max_num_of_students VARCHAR(50) NOT NULL,
    student_count VARCHAR(50),
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id)
);



CREATE TABLE group_lesson(
    lesson_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    min_num_of_students VARCHAR(50) NOT NULL,
    max_num_of_students VARCHAR(50) NOT NULL,
    student_count VARCHAR(50),
    instrument_used VARCHAR(500),
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(id) ON DELETE CASCADE,
    PRIMARY KEY(lesson_id)
);



CREATE TABLE individual_lesson(
    lesson_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
    FOREIGN KEY (skill_level_id) REFERENCES skill_level_lookup(id) ON DELETE CASCADE,
    PRIMARY KEY (lesson_id)
);



CREATE TABLE time_slot(
        starting_time TIME NOT NULL,
        ending_time TIME NOT NULL,
        date_slot DATE NOT NULL,
        lesson_id INT NOT NULL,
        FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
        PRIMARY KEY(starting_time, ending_time, date_slot,lesson_id)
);

-- shoul price be of DECIAMAL type??
CREATE TABLE student_courses_transactions(
        date_transaction TIMESTAMP NOT NULL,
        student_id INT NOT NULL,
        lesson_id INT NOT NULL,
        price VARCHAR(50) NOT NULL,
        FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
        FOREIGN KEY (lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
        PRIMARY KEY (date_transaction, student_id, lesson_id)
);

CREATE TABLE lesson_cost_updates(
        lesson_id INT NOT NULL,
        update_date TIMESTAMP NOT NULL,
        price VARCHAR(50),
        current_price BOOLEAN,
        FOREIGN KEY(lesson_id) REFERENCES lesson(id) ON DELETE CASCADE,
        PRIMARY KEY (lesson_id, update_date)
);




--keep only 2 instruments for each student
CREATE OR REPLACE FUNCTION rental_instruments_limit()
RETURNS TRIGGER AS $$
DECLARE instrument_count INT;
BEGIN

        SELECT COUNT(rental_instrument.instrument_id)
        INTO instrument_count
        FROM rental_instrument
        JOIN rental ON rental_instrument.rental_id=rental.id
        WHERE rental.student_id=(
                        SELECT student_id FROM rental WHERE id=NEW.rental_id
                ) AND rental.starting_date<=(
                        SELECT ending_date FROM rental WHERE id= NEW.rental_id
                ) AND rental.ending_date>=(
                        SELECT starting_date FROM rental WHERE id=NEW.rental_id
                );
        -- if the student tries to rent more than 2:
        IF (instrument_count>=2) THEN RAISE EXCEPTION 'MAXIMUM NUMBER OF RENTED INSTURMENTS IS 2 PER STUDENT!' 
        END IF;
        RETURN NEW;
        END;

        $$ LANGUAGE plpgsql;

        CREATE TRIGGER rental_instruments_limit_trigger
        BEFORE INSERT ON rental_instrument
        FOR EACH ROW
        EXECUTE FUNCTION rental_instrument_limit();
