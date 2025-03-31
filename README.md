# SoundGood Database  

This repository contains the SQL scripts for setting up and managing the **SoundGood Music Rental** database. The database is designed to store and manage information about musical instrument rentals, customers, and payments.  

This database project is part of our university work during the course **IK1451 'Data Storage Paradigms'** at **KTH Royal Institute of Technology**. It develops a database starting from Conceptual Modeling, all the way to implementing a Java application that ensures ACID transactions.

The business overview of **SoundGood Music School** is the following:

> "Soundgood sells music lessons to students who want to learn to play an instrument. When someone wants to attend the school,  
> they submit contact details, which instrument they want to learn, and their present skill. If there is room, the student is offered a place.  
> There is no concept like 'course' or sets of lessons. Instead, students continue to take lessons as long as they wish. Students pay per lesson  
> and instructors are paid per given lesson."

## Repository Structure  

- `conceptual_model` – Defines the database schema, including tables, constraints, and relationships.  
- `logical_and_physical_model` – Contains sample data for testing.  
- `OLAP_queries` – Includes example queries for retrieving and managing rental data.
- 'programmatic_access' - Application implementation using JDBC for OLTP queries

## Getting Started  

### Prerequisites  

Ensure you have **PostgreSQL** or any compatible SQL database installed.  

### Installation  

1. Clone the repository:

   
   git clone https://github.com/emyemy89/soundgood-database.git

   cd soundgood-database

3. Set up the database:

   
   psql -U your_user -d your_database -f logical_and_physical_model/creation.sql

4. Insert sample data

   
   psql -U your_user -d your_database -f logical_and_physical_model/data.sql

   
6. Run predefined OLAP queries using:

   
   psql -U your_user -d your_database -f OLAP_queries/Queries.sql
