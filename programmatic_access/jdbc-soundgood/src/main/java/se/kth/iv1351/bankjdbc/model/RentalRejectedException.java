package se.kth.iv1351.bankjdbc.model;

/**
 * This exception is thrown when rental fails (start or end a rental)
 */
public class RentalRejectedException extends Exception {

    /**
     *
     * @param reason -- why the exception was thrown
     */
    public RentalRejectedException(String reason) {
        super(reason);
    }

    /**
     *
     * @param reason    why was it thrown
     * @param rootCause The exception that caused this exception to be thrown
     */
    public RentalRejectedException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }
}

