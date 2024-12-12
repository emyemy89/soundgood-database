/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */



package se.kth.iv1351.bankjdbc.integration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import se.kth.iv1351.bankjdbc.model.Instrument;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;

/**
 * This data access object (DAO) encapsulates all database calls in the music rental
 * application. No code outside this class shall have any knowledge about the database !!
 */   
    
public class SoundgoodDAO {

    private static final String INSTRUMENT_TABLE_NAME = "individual_instrument";
    private static final String INSTRUMENT_ID_COLUMN_NAME = "individual_instrument_id";
    private static final String INSTRUMENT_NAME_COLUMN_NAME = "instrument_name";
    private static final String STATUS_COLUMN_NAME = "status";
    private static final String RENTAL_TABLE_NAME = "rental";
    private static final String RENTAL_ID_COLUMN_NAME = "rental_id";
    private static final String RENTAL_END_DATE_COLUMN_NAME = "ending_date";
    private static final String STUDENT_ID_COLUMN_NAME = "student_id";
    private static final String SERIAL_NUMBER_COLUMN_NAME = "serial_number";
    private static final String BRAND_COLUMN_NAME = "brand";
    private static final String RENTAL_PRICE_COLUMN_NAME = "rental_price";
    private static final String INSTRUMENT_COLUMN_ID = "instrument_id";
    private static final String RENTAL_INSTRUMENT_TABLE_NAME = "rental_instrument";
    

    private Connection connection;
    private PreparedStatement rentInstrumentStmt;
    private PreparedStatement findInstrumentByNameStmt;
    private PreparedStatement findRentalsByStudentStmt;


    private PreparedStatement insertRentalInstrumentStmt;
    private PreparedStatement updateStatusStmt;
    private PreparedStatement updateStatusToAvailableStmt;

    private PreparedStatement updateRentalStatusStmt;
    private PreparedStatement listAvailableInstrumentsByTypeStmt;





    public SoundgoodDAO() throws SoundgoodDBException {
        try {
            connectToMusicSchoolDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new SoundgoodDBException("Could not connect to datasource.", exception);
        }
    }

    private void connectToMusicSchoolDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/<name_of_databse>",
                "<user_name>", "<password>");
        connection.setAutoCommit(false);
    }

    

    private void prepareStatements() throws SQLException {
        listAvailableInstrumentsByTypeStmt = connection.prepareStatement(
            "SELECT i." + INSTRUMENT_ID_COLUMN_NAME + ", i." + SERIAL_NUMBER_COLUMN_NAME + ", it." + INSTRUMENT_NAME_COLUMN_NAME + ", it." + BRAND_COLUMN_NAME + ", it." + RENTAL_PRICE_COLUMN_NAME + ", i." + STATUS_COLUMN_NAME + " " +
            "FROM " + INSTRUMENT_TABLE_NAME + " i " +
            "JOIN instrument it ON i." + INSTRUMENT_COLUMN_ID + " = it." + INSTRUMENT_COLUMN_ID + " " +
            "WHERE i." + STATUS_COLUMN_NAME + " = 'available' AND it." + INSTRUMENT_NAME_COLUMN_NAME + " = ? FOR NO KEY UPDATE"
        );
    
        rentInstrumentStmt = connection.prepareStatement(
            "INSERT INTO " + RENTAL_TABLE_NAME + " (" + "starting_date, " + RENTAL_END_DATE_COLUMN_NAME + ", " + STUDENT_ID_COLUMN_NAME + ") VALUES (CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', ?)",
            PreparedStatement.RETURN_GENERATED_KEYS // generated PK
        );
    
        insertRentalInstrumentStmt = connection.prepareStatement(
            "INSERT INTO " + RENTAL_INSTRUMENT_TABLE_NAME + " (" + RENTAL_ID_COLUMN_NAME + ", " + INSTRUMENT_ID_COLUMN_NAME + ", " + STUDENT_ID_COLUMN_NAME + ") VALUES (?, ?, ?)"
        );
    

        updateStatusStmt = connection.prepareStatement(
            "UPDATE " + INSTRUMENT_TABLE_NAME + " 
            SET " + STATUS_COLUMN_NAME + " = ? 
            WHERE " + INSTRUMENT_ID_COLUMN_NAME + " = ?"
        );

        updateRentalStatusStmt = connection.prepareStatement( 
            "UPDATE " + RENTAL_TABLE_NAME + " SET status = ? WHERE " + RENTAL_ID_COLUMN_NAME + " = ?" 
        ); 
        
        

    
        updateStatusToAvailableStmt = connection.prepareStatement(
            "UPDATE " + INSTRUMENT_TABLE_NAME + " SET " + STATUS_COLUMN_NAME + " = 'available' WHERE " + INSTRUMENT_ID_COLUMN_NAME + " = ?"
        );
    
        findInstrumentByNameStmt = connection.prepareStatement(
            "SELECT i." + INSTRUMENT_ID_COLUMN_NAME + ", i." + SERIAL_NUMBER_COLUMN_NAME + ", ins." + INSTRUMENT_NAME_COLUMN_NAME + ", ins." + BRAND_COLUMN_NAME + ", ins." + RENTAL_PRICE_COLUMN_NAME + ", i." + STATUS_COLUMN_NAME + " " +
            "FROM " + INSTRUMENT_TABLE_NAME + " i " +
            "JOIN instrument ins ON i." + INSTRUMENT_COLUMN_ID + " = ins." + INSTRUMENT_COLUMN_ID + " " +
            "WHERE i." + SERIAL_NUMBER_COLUMN_NAME + " = ? FOR NO KEY UPDATE"
        );
    

        findRentalsByStudentStmt = connection.prepareStatement(
            "SELECT COUNT(*) FROM " + RENTAL_INSTRUMENT_TABLE_NAME + " ri " +
            "JOIN " + RENTAL_TABLE_NAME + " r ON ri." + RENTAL_ID_COLUMN_NAME + " = r." + RENTAL_ID_COLUMN_NAME + " " +
            "WHERE ri." + STUDENT_ID_COLUMN_NAME + " = ? AND r.status = 'active'"
        );

        }




    /* *
    * Finds the instruments of a certain type that are aavilable at the present moment.
    *
    *@param instrumentype            Type of the instrument.
    *@throws SoundgoodDBException    If the instrument is not found.
    */
    public List<InstrumentDTO> readAvailableInstrumentsByType(String instrumentType) throws SoundgoodDBException {
        String failureMsg = "Could not list instruments.";
        List<InstrumentDTO> instruments = new ArrayList<>();
        ResultSet result = null;
    
        try {
            listAvailableInstrumentsByTypeStmt.setString(1, instrumentType);
            result = listAvailableInstrumentsByTypeStmt.executeQuery();
            while (result.next()) {
                instruments.add(new Instrument(
                    result.getInt(INSTRUMENT_ID_COLUMN_NAME),
                    result.getString(SERIAL_NUMBER_COLUMN_NAME),
                    result.getString(INSTRUMENT_NAME_COLUMN_NAME),
                    result.getString(BRAND_COLUMN_NAME),
                    result.getString(RENTAL_PRICE_COLUMN_NAME),
                    result.getString(STATUS_COLUMN_NAME)
                ));
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instruments;
    }



    // NEXT 4 METHODS ARE USED FOR RENTING AN INSTRUMENT:
    
    /* *
    * Creates a rental
    *
    *@param studentId the id of the student making the rental
    *@throws SQLException
    */
    public void createRental(int studentId) throws SQLException {
        rentInstrumentStmt.setInt(1, studentId);
        rentInstrumentStmt.executeUpdate();
    }

    /* *
    * Creates a rental id
    *
    *@throws SQLException
    */
    public int getGeneratedRentalId() throws SQLException {
        ResultSet generatedKeys = rentInstrumentStmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to retrieve rental ID.");
        }
    }

    /* 
    * Inserts the new data to the table rental_instrument
    *
    *@param rentalId             The id of the rental 
    *@param instrumentId         The id of the instrument being rented.
    *@param studentId            The id of the student making the rental. 
    *@throws SQLException
    */
    public void insertRentalInstrument(int rentalId, int instrumentId, int studentId) throws SQLException {
        insertRentalInstrumentStmt.setInt(1, rentalId);
        insertRentalInstrumentStmt.setInt(2, instrumentId);
        insertRentalInstrumentStmt.setInt(3, studentId);
        insertRentalInstrumentStmt.executeUpdate();
    }

    /* *
    *Updates the status of the rented instrument to 'rented'
    *
    *@param instrumentId         The id of the instrument being rented.
    *@param status               The status column of the specific instrument. 
    *@throws SQLException
    */
    public void updateInstrumentStatus(int instrumentId, String status) throws SQLException {
        updateStatusStmt.setString(1, status);
        updateStatusStmt.setInt(2, instrumentId);
        updateStatusStmt.executeUpdate();
    }





        // NEXT 2 METHODS ARE FOR TERMINATING A RENTAL
    /* *
    *Updates the status of the previously rented instrument to 'available'
    *
    *@param instrumentId         The id of the instrument that was rented.
    *@throws SQLException
    */
    public void updateInstrumentStatusToAvailable(int instrumentId) throws SQLException {
        updateStatusToAvailableStmt.setInt(1, instrumentId);
        updateStatusToAvailableStmt.executeUpdate();
    }


    /* *
    *Updates the status of the rental as 'termianted'
    *
    *@param rentalId             The id of the rental. 
    *@param status              The status of the specific rental.
    *@throws SQLException
    */
    public void updateRentalStatus(int rentalId, String status) throws SQLException {
        updateRentalStatusStmt.setString(1, status);
        updateRentalStatusStmt.setInt(2, rentalId);
        updateRentalStatusStmt.executeUpdate();
    }
    
    

     

    /* *
    * Finds an instrument given its serial number
    *
    *@param serialNumber            The serial number of the instrumetn that needs to be found.
    *@throws SoundgoodDBException    If the instrument is not found.
    */
    public InstrumentDTO readInstrumentBySerialNumber(String serialNumber) throws SoundgoodDBException {
        String failureMsg = "Could not find instrument with serial number: " + serialNumber;
        ResultSet result = null;
        try {
            findInstrumentByNameStmt.setString(1, serialNumber);
            result = findInstrumentByNameStmt.executeQuery();
            if (result.next()) {
                return new Instrument(
                        result.getInt(INSTRUMENT_ID_COLUMN_NAME),
                        result.getString(SERIAL_NUMBER_COLUMN_NAME),
                        result.getString(INSTRUMENT_NAME_COLUMN_NAME),
                        result.getString(BRAND_COLUMN_NAME),
                        result.getString(RENTAL_PRICE_COLUMN_NAME),
                        result.getString(STATUS_COLUMN_NAME)
                );
            } else {
                throw new SoundgoodDBException("Instrument not found: " + serialNumber);
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return null;
    }
    
    
    


    

    /* *
    * Finds the number of active rentals a student has
    *
    *@param studentId            The id of the student.
    *@throws SoundgoodDBException    If the the number of rentals can not be counted.
    */
    public int readRentalCountByStudent(int studentId) throws SoundgoodDBException {
        String failureMsg = "Could not count rentals.";
        ResultSet result = null;
        try {
            findRentalsByStudentStmt.setInt(1, studentId);
            result = findRentalsByStudentStmt.executeQuery();
            if (result.next()) {
                return result.getInt(1);
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return 0;
    }
    
    
    
    
    
    
    
    

    /**
     * Commits the current transaction.
     * 
     * @throws SoundgoodDBException If unable to commit the current transaction.
     */
    public void commit() throws SoundgoodDBException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    /**
     * Rolls back the current transaction.
     * 
     * @throws SoundgoodDBException If unable to roll back the current transaction.
     */
    public void rollback() throws SoundgoodDBException {
        try {
            connection.rollback();
        } catch (SQLException e) {
            handleException("Failed to roll back", e);
        }
    }

    private void handleException(String failureMsg, Exception cause) throws SoundgoodDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new SoundgoodDBException(failureMsg, cause);
        } else {
            throw new SoundgoodDBException(failureMsg);
        }
    }



    private void closeResultSet(String failureMsg, ResultSet result) throws SoundgoodDBException {
        if (result != null) {
            try {
                result.close();
            } catch (Exception e) {
                throw new SoundgoodDBException(failureMsg + " Could not close result set.", e);
            }
        }
    }
    

}
