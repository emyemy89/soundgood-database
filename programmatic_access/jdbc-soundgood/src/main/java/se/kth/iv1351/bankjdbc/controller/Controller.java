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
import se.kth.iv1351.bankjdbc.integration.SoundgoodDAO;
import se.kth.iv1351.bankjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;
import se.kth.iv1351.bankjdbc.model.RentalRejectedException;
import se.kth.iv1351.bankjdbc.model.InstrumentException;
import se.kth.iv1351.bankjdbc.model.RentalManager;


/**
 * This is the application's only controller, all calls to the model pass here.
 * The controller is also responsible for calling the DAO. Typically, the
 * controller first calls the DAO to retrieve data (if needed), then operates on
 * the data, and finally tells the DAO to store the updated data (if any).
 */
public class Controller {
    private final SoundgoodDAO soundgood;

    private final RentalManager rentalManager; 

   /** 
    * * Creates a new instance, and retrieves a connection to the database. 
    * * 
    * @throws SoundgoodDBException If unable to connect to the database. 
    */ 
    public Controller() throws SoundgoodDBException { 
        this.soundgood = new SoundgoodDAO(); 
        this.rentalManager = new RentalManager(soundgood); 
    }


    /** 
     * 
     * * Creates a new instance with a given RentalManager. 
    * * @param rentalManager The RentalManager to use for business constaint 
    */ 
    public Controller(RentalManager rentalManager) throws SoundgoodDBException { 
        this.soundgood = new SoundgoodDAO(); 
        this.rentalManager = rentalManager; 
    }

    /**
     * Lists all available instruments
     *
     * @param instrumentName The type of instrument to list.
     * @return A list containing all available instruments of the specified type.
     * @throws SoundgoodDBException
     * @throws MusicRentException if unable to list instruments.
     */
    public List<InstrumentDTO> getAvailableInstruments(String instrumentName) throws InstrumentException, SoundgoodDBException {
        try {
            List<InstrumentDTO> instruments= soundgood.readAvailableInstruments(instrumentName);
            try{
                soundgood.commit();
            }catch(SoundgoodDBException e){
                throw new InstrumentException("Can not read instrument"+e);
            }
            return instruments;
        }
        catch (SoundgoodDBException e) {
                soundgood.rollback();
                throw new InstrumentException("Could not list available instruments: "+ instrumentName, e);
            }
    }

    /**
      * Rents an instrument to a student
      * 
      * @param studentId       The id of the student renting the instrument
      * @param InstrumentDTO   The instrument to rent
      * @throws RentalRejectedException If unable to rent it
     * @throws SoundgoodDBException If problem arises with rentalManager
      */
    public void rentInstrument(int studentId, InstrumentDTO instrument) throws RentalRejectedException, SoundgoodDBException { 
        String failureMsg = "Could not rent instrument: " + instrument.getSerialNumber() + " to student: " + studentId; 
        try { 
            rentalManager.checkRentalLimit(studentId);  // constraint for 2 instr limit, present in model layer
            int instrumentId = instrument.getInstrumentId();
            if (instrumentId == 0) {
                throw new RentalRejectedException("Can't find instrument.");
            }
            soundgood.createRental(studentId);
            int rentalId = soundgood.getGeneratedRentalId();
            soundgood.insertRentalInstrument(rentalId, instrumentId, studentId);
            soundgood.updateInstrumentStatus(instrumentId, "rented");
        } catch (SQLException e) {
            throw new RentalRejectedException(failureMsg, e);
        }
    }
    
    

    
    


     /**
      * Terminates an ongoing rental.
      * 
      * @param rentalId                  the id of rental to terminate
      * @param InstrumentDTO             the instrument
      * @throws RentalRejectedException  if unable to terminate the rental
      */
    public void terminateRental(int rentalId, InstrumentDTO instrument) throws RentalRejectedException {
        String failureMsg="Could not terminate rental: "+ rentalId +" for instrument: "+ instrument.getSerialNumber();
        try {
            int instrumentId=instrument.getInstrumentId();
            if (instrumentId== 0) {
                throw new RentalRejectedException("Instrument not found");
            }
    
            soundgood.updateRentalStatus(rentalId, "terminated");
            soundgood.updateInstrumentStatusToAvailable(instrumentId);
            commitOngoingTransaction(failureMsg);
        } catch (SQLException e) {
            rollbackOngoingTransaction();
            throw new RentalRejectedException(failureMsg, e);
        }
    }
    
    
    

    /**
      * Finds an instrument given its serial number
      * 
      * @param serialNumber            the serial nb of the instrument
      * @throws SoundgoodDBException   if unable to find the instrument
      */
    public InstrumentDTO findInstrumentBySerialNumber(String serialNumber) throws SoundgoodDBException {
        try {
            return soundgood.readInstrumentBySerialNumber(serialNumber);
        } catch (Exception e) {
            System.out.println("Error finding instrument: " + e.getMessage());
            throw new SoundgoodDBException("Instrument not found: " + serialNumber, e);
        }
    }
    

    /**
      * Finds how many active rentals a studen has
      * 
      * @param studentId                  The particular student
      * @throws RentalRejectedException   If unable to count the rentals
      */
    public int getRentalsCountByStudent(int studentId) throws RentalRejectedException {
        try {
            int count = soundgood.readRentalCountByStudent(studentId);
            soundgood.commit();
            return count;
        } catch (SoundgoodDBException e) {
            rollbackOngoingTransaction();
            throw new RentalRejectedException("Could not count rentals for student: " + studentId, e);
        }
    }


    /**
    * Usd to commit a transaction
    *
    *@param failureMsg                 Error to print
    *@throws RentedRejectedException   Along with failure message if an error occurs
    */
    private void commitOngoingTransaction(String failureMsg) throws RentalRejectedException {
        try {
            soundgood.commit();
        } catch (SoundgoodDBException msde) {
            throw new RentalRejectedException(failureMsg, msde);
        }
    }

    /**
    * Usd to rollback a transaction
    *
    *@throws RentedRejectedException   If an error occurs
    */
    private void rollbackOngoingTransaction() throws RentalRejectedException { 
        try { 
            soundgood.rollback(); 
        } catch (SoundgoodDBException msde) { 
            throw new RentalRejectedException("Failed to rollback transaction.", msde); 
        }
    }
}

