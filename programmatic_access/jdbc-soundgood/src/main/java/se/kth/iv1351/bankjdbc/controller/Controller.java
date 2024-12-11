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



package se.kth.iv1351.bankjdbc.controller;

import java.sql.SQLException;
import java.util.List;
import se.kth.iv1351.bankjdbc.integration.MusicSchoolDAO;
import se.kth.iv1351.bankjdbc.integration.MusicSchoolDBException;
import se.kth.iv1351.bankjdbc.model.Instrument;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;
import se.kth.iv1351.bankjdbc.model.RentalRejectedException;

/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final MusicSchoolDAO soundgood;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws MusicSchoolDBException If unable to connect to the database.
     */
    public Controller() throws MusicSchoolDBException {
        soundgood = new MusicSchoolDAO();
    }

    /**
     * Lists all available instruments of a certain kind
     * 
     * @param instrumentName The type of instrument to list.
     * @return A list containing all available instruments of the specified type.
     * @throws MusicRentException If unable to list instruments.
     */
    public List<InstrumentDTO> getAvailableInstruments(String instrumentName) throws RentalRejectedException {
        try {
            List<InstrumentDTO> instruments = soundgood.listAvailableInstruments(instrumentName);
            soundgood.commit();
            return instruments;
        } catch (MusicSchoolDBException e) {
            try {
                soundgood.rollback();
            } catch (MusicSchoolDBException rollbackEx) {
                throw new RentalRejectedException("Failed to rollback transaction after error: " + e.getMessage(), rollbackEx);
            }
            throw new RentalRejectedException("Could not list available instruments: " + instrumentName, e);
        }
    }
    

    // /**
    //  * Rents an instrument to a student.
    //  * 
    //  * @param studentId              The ID of the student renting the instrument.
    //  * @param instrumentSerialNumber The serial number of the instrument to rent.
    //  * @throws RentalRejectedException If unable to rent the instrument.
    //  */
    public void rentInstrument(int studentId, InstrumentDTO instrument) throws RentalRejectedException {
        String failureMsg = "Could not rent instrument: " + instrument.getSerialNumber() + " to student: " + studentId;
        try {
            int instrumentId = instrument.getInstrumentId();
            if (instrumentId == 0) {
                throw new RentalRejectedException("Instrument not found.");
            }
    
            soundgood.createRental(studentId);
            int rentalId = soundgood.getGeneratedRentalId();
            soundgood.insertRentalInstrument(rentalId, instrumentId, studentId);
            soundgood.updateInstrumentStatus(instrumentId, "rented");
    
            soundgood.commit();
        } catch (SQLException e) {
            try {
                soundgood.rollback();
            } catch (MusicSchoolDBException rollbackEx) {
                throw new RentalRejectedException("Failed to rollback transaction after error: " + e.getMessage(), rollbackEx);
            }
            throw new RentalRejectedException(failureMsg, e);
        } catch (MusicSchoolDBException e) {
            throw new RentalRejectedException("Error accessing the database", e);
        }
    }
    

    
    


    // /**
    //  * Terminates an ongoing rental.
    //  * 
    //  * @param rentalId       The ID of the rental to terminate.
    //  * @param serialNumber   The serial number of the instrument.
    //  * @throws MusicRentException If unable to terminate the rental.
    //  */
    public void terminateRental(int rentalId, InstrumentDTO instrument) throws RentalRejectedException {
        String failureMsg = "Could not terminate rental: " + rentalId + " for instrument: " + instrument.getSerialNumber();
        try {
            int instrumentId = instrument.getInstrumentId();
            if (instrumentId == 0) {
                throw new RentalRejectedException("Instrument not found.");
            }
    
            System.out.println("Debug: Terminating rental for instrumentId: " + instrumentId); // Debug statement
    
            soundgood.deleteRentalInstrument(rentalId, instrumentId);
            soundgood.updateInstrumentStatusToAvailable(instrumentId);
    
            soundgood.commit();
            System.out.println("Debug: Rental terminated for rentalId: " + rentalId + ", instrumentId: " + instrumentId); // Debug statement
        } catch (SQLException e) {
            try {
                soundgood.rollback();
            } catch (MusicSchoolDBException rollbackEx) {
                throw new RentalRejectedException("Failed to rollback transaction after error: " + e.getMessage(), rollbackEx);
            }
            throw new RentalRejectedException(failureMsg, e);
        } catch (MusicSchoolDBException e) {
            throw new RentalRejectedException("Error accessing the database", e);
        }
    }
    
    


    public InstrumentDTO findInstrumentBySerialNumber(String serialNumber) throws MusicSchoolDBException {
        System.out.println("Searching for instrument with serial number: " + serialNumber);
        try {
            return soundgood.getInstrumentBySerialNumber(serialNumber);
        } catch (Exception e) {
            System.out.println("Error finding instrument: " + e.getMessage());
            throw new MusicSchoolDBException("Instrument not found: " + serialNumber, e);
        }
    }
    
    public int getRentalsCountByStudent(int studentId) throws RentalRejectedException {
        try {
            int count = soundgood.countRentalsByStudent(studentId);
            soundgood.commit();
            return count;
        } catch (MusicSchoolDBException e) {
            try {
                soundgood.rollback();
            } catch (MusicSchoolDBException rollbackEx) {
                throw new RentalRejectedException("Failed to rollback transaction after error: " + e.getMessage(), rollbackEx);
            }
            throw new RentalRejectedException("Could not count rentals for student: " + studentId, e);
        }
    }
    
    
    

    private void commitOngoingTransaction(String failureMsg) throws RentalRejectedException {
        try {
            soundgood.commit();
        } catch (MusicSchoolDBException msde) {
            throw new RentalRejectedException(failureMsg, msde);
        }
    }

    private void rollbackOngoingTransaction() throws RentalRejectedException { 
        try { 
            soundgood.rollback(); 
        } catch (MusicSchoolDBException msde) { 
            throw new RentalRejectedException("Failed to rollback transaction.", msde); 
        } 
    }
}
