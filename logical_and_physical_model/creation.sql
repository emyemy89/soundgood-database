
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

);

CREATE TABLE phone(

);

CREATE TABLE sibling(

);

CREATE TABLE student_lesson(

);

CREATE TABLE instructor_availability(

);

CREATE TABLE rental (

);


CREATE TABLE instrument(

);

CREATE TABLE lesson(

);

CREATE TABLE price_list(

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