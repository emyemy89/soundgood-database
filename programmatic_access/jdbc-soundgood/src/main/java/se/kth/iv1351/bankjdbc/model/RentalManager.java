package se.kth.iv1351.bankjdbc.model;

import java.sql.SQLException;

import se.kth.iv1351.bankjdbc.integration.SoundgoodDAO;
import se.kth.iv1351.bankjdbc.integration.SoundgoodDBException;

/**
 * Manages the business logic for instrument rentals.
 */
public class RentalManager {
    private final SoundgoodDAO soundgood;

    public RentalManager(SoundgoodDAO soundgood) {
        this.soundgood = soundgood;
    }

    public void checkRentalLimit(int studentId) throws RentalRejectedException, SoundgoodDBException {
        int currentRentals = soundgood.readRentalCountByStudent(studentId);
        if (currentRentals >= 2) {
            throw new RentalRejectedException("Student has already rented 2 instruments.");
        }
    }

}
