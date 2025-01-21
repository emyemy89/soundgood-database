# A JDBC application with an appropriately layered architecture

This is an example of how an integration layer can be used to organize an application containing database calls.

## How to execute

1. Clone this git repository
1. Change to the newly created directory `cd jdbc-soundgood`
1. Make sure there is a database which can be reached with the url on line 235-236 or 237-238 in `InstrumentDAO.java`. There are two ways to do this.
   1. Create a database that can be reached with one of the existing urls. If
      postgres is used, that is a database called soundgooddb, wich can be
      reached on port 5433 at localhost, by the user 'postgres' with the
      password 'postgres'. If MySQL is used, that is a database called
      soundgooddb, which can be reached on port 3306 at localhost, by the user
      'root' with the password 'javajava'.
   1. Change the url to match your database.
1. Create the tables described by `src/main/resources/mysql-soundgooddb.sql` (if you use mysql) or `src/main/resources/postgres-soundgooddb.sql` (if you use postgres).
1. Build the project with the command `mvn install`
1. Run the program with the command `mvn exec:java`

## Commands for the soundgood program

* `help` displays all commands.
* `list` lists all available instruments.
* `list <intrument_type>` lists all instruments of a certain kind.
* `rent <student_id><instrument_id>` rents a specific instrument for a specific student.
* `terminate rental<rental_id><instrument_id>` terminates a specific renttal without deleting it from the system.
* `quit` quits the application.
