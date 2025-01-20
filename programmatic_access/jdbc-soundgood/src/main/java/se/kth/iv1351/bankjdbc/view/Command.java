package se.kth.iv1351.bankjdbc.view;


/**
 * Defines all commands that can be performed by a user 
 */
public enum Command {
    /**
     * Lists all available instruments
     */
    LIST_INSTRUMENTS,
    /**
     * Rents an instrument to a student (student_id, serial_number)
     */
    RENT_INSTRUMENT,
    /**
     * Terminates an ongoing rental (rental_id, serial_number)
     */
    TERMINATE_RENTAL,
    /**
     * Lists all commands.
     */
    HELP,
    /**
     * Leave the application.
     */
    QUIT,
    /**
     * None of the valid commands above was specified.
     */
    ILLEGAL_COMMAND
}
