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
import se.kth.iv1351.bankjdbc.model.RentalRejectedException;

/**
 * This data access object (DAO) encapsulates all database calls in the music rental
 * application. No code outside this class shall have any knowledge about the database.
 */   
    
public class MusicSchoolDAO {

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
    private PreparedStatement listAvailableInstrumentsStmt;
    private PreparedStatement rentInstrumentStmt;
    private PreparedStatement terminateRentalStmt;
    private PreparedStatement findInstrumentByNameStmt;
    private PreparedStatement findRentalsByStudentStmt;

    private PreparedStatement insertRentalStmt;
    private PreparedStatement insertRentalInstrumentStmt;
    private PreparedStatement updateStatusStmt;
    private PreparedStatement deleteRentalInstrumentStmt;
    private PreparedStatement updateStatusToAvailableStmt;





    public MusicSchoolDAO() throws MusicSchoolDBException {
        try {
            connectToMusicSchoolDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception) {
            throw new MusicSchoolDBException("Could not connect to datasource.", exception);
        }
    }

    private void connectToMusicSchoolDB() throws ClassNotFoundException, SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5433/soundgood",
                "postgres", "vreaulamare123");
        connection.setAutoCommit(false);
    }

    

    private void prepareStatements() throws SQLException {
        listAvailableInstrumentsStmt = connection.prepareStatement(
            "SELECT i." + INSTRUMENT_ID_COLUMN_NAME + ", i." + SERIAL_NUMBER_COLUMN_NAME + ", it." + INSTRUMENT_NAME_COLUMN_NAME + ", it." + BRAND_COLUMN_NAME + ", it." + RENTAL_PRICE_COLUMN_NAME + ", i." + STATUS_COLUMN_NAME + " " +
            "FROM " + INSTRUMENT_TABLE_NAME + " i " +
            "JOIN instrument it ON i." + INSTRUMENT_COLUMN_ID + " = it." + INSTRUMENT_COLUMN_ID + " " +
             "WHERE i." + STATUS_COLUMN_NAME +  " = 'available' FOR NO KEY UPDATE"
        );
    
        rentInstrumentStmt = connection.prepareStatement(
            "INSERT INTO " + RENTAL_TABLE_NAME + " (" + "starting_date, " + RENTAL_END_DATE_COLUMN_NAME + ", " + STUDENT_ID_COLUMN_NAME + ") VALUES (CURRENT_DATE, CURRENT_DATE + INTERVAL '1 year', ?)",
            PreparedStatement.RETURN_GENERATED_KEYS
        );
    
        insertRentalInstrumentStmt = connection.prepareStatement(
            "INSERT INTO " + RENTAL_INSTRUMENT_TABLE_NAME + " (" + RENTAL_ID_COLUMN_NAME + ", " + INSTRUMENT_ID_COLUMN_NAME + ", " + STUDENT_ID_COLUMN_NAME + ") VALUES (?, ?, ?)"
        );
    

        updateStatusStmt = connection.prepareStatement(
            "UPDATE " + INSTRUMENT_TABLE_NAME + " SET " + STATUS_COLUMN_NAME + " = ? WHERE " + INSTRUMENT_ID_COLUMN_NAME + " = ?"
        );

    
        terminateRentalStmt = connection.prepareStatement(
            "DELETE FROM " + RENTAL_INSTRUMENT_TABLE_NAME + " WHERE " + RENTAL_ID_COLUMN_NAME + " = ? AND " + INSTRUMENT_ID_COLUMN_NAME + " = ?"
        );
    
        updateStatusToAvailableStmt = connection.prepareStatement(
            "UPDATE " + INSTRUMENT_TABLE_NAME + " SET " + STATUS_COLUMN_NAME + " = 'available' WHERE " + INSTRUMENT_ID_COLUMN_NAME + " = ?"
        );
    
        findInstrumentByNameStmt = connection.prepareStatement(
            "SELECT i." + INSTRUMENT_ID_COLUMN_NAME + ", i." + SERIAL_NUMBER_COLUMN_NAME + ", ins." + INSTRUMENT_NAME_COLUMN_NAME + ", ins." + BRAND_COLUMN_NAME + ", ins." + RENTAL_PRICE_COLUMN_NAME + ", i." + STATUS_COLUMN_NAME + " " +
            "FROM " + INSTRUMENT_TABLE_NAME + " i " +
            "JOIN instrument ins ON i." + INSTRUMENT_COLUMN_ID + " = ins." + INSTRUMENT_COLUMN_ID + " " +
            "WHERE i." + SERIAL_NUMBER_COLUMN_NAME +  " = ? FOR NO KEY UPDATE"
        );


    
        findRentalsByStudentStmt = connection.prepareStatement(
            "SELECT COUNT(*) FROM " + RENTAL_INSTRUMENT_TABLE_NAME + " WHERE " + STUDENT_ID_COLUMN_NAME + " = ?"
        );
    }
    



    public List<InstrumentDTO> listAvailableInstruments(String instrumentName) throws MusicSchoolDBException {
        String failureMsg = "Could not list instruments.";
        ResultSet result = null;
        List<InstrumentDTO> instruments = new ArrayList<>();
        try {
            result = listAvailableInstrumentsStmt.executeQuery();// no need 'for update', only read ops
            System.out.println("Executing listAvailableInstruments query...");
    
            while (result.next()) {
                System.out.println("Found instrument: " + result.getString("serial_number") + ", Status: " + result.getString("status")); // Debug statement
    
                Instrument instrument = new Instrument(
                    result.getInt("individual_instrument_id"),
                    result.getString("serial_number"),
                    result.getString("instrument_name"),
                    result.getString("brand"),
                    result.getString("rental_price"),
                    result.getString("status")
                );
                instruments.add(instrument);
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return instruments;
    }
    



    // NEXT 4 METHODS ARE USED FOR RENTING AN INSTRUMENT
    public void createRental(int studentId) throws SQLException {
        rentInstrumentStmt.setInt(1, studentId);
        rentInstrumentStmt.executeUpdate();
    }
    
    public int getGeneratedRentalId() throws SQLException {
        ResultSet generatedKeys = rentInstrumentStmt.getGeneratedKeys();
        if (generatedKeys.next()) {
            return generatedKeys.getInt(1);
        } else {
            throw new SQLException("Failed to retrieve rental ID.");
        }
    }
    
    public void insertRentalInstrument(int rentalId, int instrumentId, int studentId) throws SQLException {
        insertRentalInstrumentStmt.setInt(1, rentalId);
        insertRentalInstrumentStmt.setInt(2, instrumentId); // Use the correct individual_instrument_id
        insertRentalInstrumentStmt.setInt(3, studentId);
        insertRentalInstrumentStmt.executeUpdate();
    }
    
    public void updateInstrumentStatus(int instrumentId, String status) throws SQLException {
        updateStatusStmt.setString(1, status);
        updateStatusStmt.setInt(2, instrumentId);
        updateStatusStmt.executeUpdate();
    }
    

    




        // NEXT 2 METHODS ARE FOR TERMINATING A RENTAL
    public void deleteRentalInstrument(int rentalId, int instrumentId) throws SQLException {
        terminateRentalStmt.setInt(1, rentalId);
        terminateRentalStmt.setInt(2, instrumentId);
        terminateRentalStmt.executeUpdate();
    }
    
    public void updateInstrumentStatusToAvailable(int instrumentId) throws SQLException {
        updateStatusToAvailableStmt.setInt(1, instrumentId);
        updateStatusToAvailableStmt.executeUpdate();
    }
    

    
    
    

    public InstrumentDTO getInstrumentBySerialNumber(String serialNumber) throws MusicSchoolDBException {
        String failureMsg = "Could not find instrument with serial number: " + serialNumber;
        ResultSet result = null;
        try {
            findInstrumentByNameStmt.setString(1, serialNumber);
            System.out.println("Executing query to find instrument with serial number: " + serialNumber); // Debug statement
            result = findInstrumentByNameStmt.executeQuery();
            if (result.next()) {
                System.out.println("Debug: Found instrument - " + result.getString("serial_number") + ", Status: " + result.getString("status")); // Debug statement
                return new Instrument(
                    result.getInt("individual_instrument_id"),
                    result.getString("serial_number"),
                    result.getString("instrument_name"),
                    result.getString("brand"),
                    result.getString("rental_price"),
                    result.getString("status")
                );
            } else {
                throw new MusicSchoolDBException("Instrument not found: " + serialNumber);
            }
        } catch (SQLException sqle) {
            handleException(failureMsg, sqle);
        } finally {
            closeResultSet(failureMsg, result);
        }
        return null;
    }
    
    
    


    public int countRentalsByStudent(int studentId) throws MusicSchoolDBException {
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
     * @throws MusicSchoolDBException If unable to commit the current transaction.
     */
    public void commit() throws MusicSchoolDBException {
        try {
            connection.commit();
        } catch (SQLException e) {
            handleException("Failed to commit", e);
        }
    }

    /**
     * Rolls back the current transaction.
     * 
     * @throws MusicSchoolDBException If unable to roll back the current transaction.
     */
    public void rollback() throws MusicSchoolDBException {
        try {
            connection.rollback();
        } catch (SQLException e) {
            handleException("Failed to roll back", e);
        }
    }

    private void handleException(String failureMsg, Exception cause) throws MusicSchoolDBException {
        String completeFailureMsg = failureMsg;
        try {
            connection.rollback();
        } catch (SQLException rollbackExc) {
            completeFailureMsg = completeFailureMsg +
                    ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
        }

        if (cause != null) {
            throw new MusicSchoolDBException(failureMsg, cause);
        } else {
            throw new MusicSchoolDBException(failureMsg);
        }
    }



    private void closeResultSet(String failureMsg, ResultSet result) throws MusicSchoolDBException {
        if (result != null) {
            try {
                result.close();
            } catch (Exception e) {
                throw new MusicSchoolDBException(failureMsg + " Could not close result set.", e);
            }
        }
    }
    

}
