
--create tables
CREATE TABLE person(
    id serial primary key,
    first_name varchar(500) not null,
    last_name varchar(500) not null,
    personal_num varchar(50) unique not null,
    email varchar(500),
    city varchar(500),
    street varchar(500),
    zip varchar(50)
);
    
CREATE TABLE student(
    id serial primary key,
    level_skills varchar(50) not null,
    contact_person_id int,               --not null???
    person_id int not null,
    foreign key (contact_person_id) references contact_person(contact_person_id),
    foreign key (person_id) references person(id) --delete cascade??
);

CREATE TABLE contact_person(
    contact_person_id serial primary key,
    first_name varchar(500),
    last_name varchar(500),
    personal_num varchar(50)
);

CREATE TABLE contact_phone(
    phone_nb varchar(50) not null,
    contact_person_id int not null,
    foreign key (contact_person_id) references contact_person(contact_person_id) on delete cascade,
    primary key(phone_nb, contact_person_id)
);

CREATE TABLE instructor(
    id serial primary key,
    employment id varchar(500) not null,
    person_id int not null,
    foreign key(person_id) references person(id) --delete cascade?
);

CREATE TABLE phone(
    phone varchar(50) not null,
    person_id int not null,
    foreign key(person_id) references person(id)  --delete cascade?
);

CREATE TABLE sibling(
    sibling_id varchar(50) not null,
    student_id int not null,
    foreign key (student_id) references student(id),
    primary key(sibling_id,student_id)
);

CREATE TABLE student_lesson(
    student_id int not null,
    lesson_id int not null,
    foreign key(student_id) references student(id),
    foreign key(lesson_id) references lesson(id),
    primary key(student_id, lesson_id)
);

CREATE TABLE instructor_availability(
    availability_date date not null,
    start_time time not null,
    end_time time not null,
    instructor_id int not null,
    foreign key (instructor_id) references instructor(id),
    primary key (availability_date, start_time, end_time, instructor_id)
);

CREATE TABLE rental (
    id serial primary key,
    start_date date not null,
    end_date date not null,
    student_id int not null,
    foreign key(student_id) references student(id)
);


CREATE TABLE instrument(
    id serial primary key,
    rental_price varchar(50),
    type varchar(500) not null,
    brand varchar(500) not null,
    quantity varchar(50),
    rental_id int not null,
    foreign key (rental_id) references rental(id) on delete set null
);

CREATE TABLE lesson(
    id serial primary key,
    instructor_id int, -- not null??
    foreign key(instructor_id) references instructor(id)
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
