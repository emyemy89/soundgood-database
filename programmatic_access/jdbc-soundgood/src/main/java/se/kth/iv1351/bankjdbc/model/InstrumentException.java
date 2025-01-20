package se.kth.iv1351.bankjdbc.model;

/**
 * This exception it thrown when create, read, or delete of an instrument fails
 */
public class InstrumentException extends Exception {

    /*
     * @param reason Why the exception was thrown
     */
    public InstrumentException(String reason) {
        super(reason);
    }

    /**
     * @param reason    Why the exception was thrown
     * @param rootCause  The exception that caused the problem.
     */
    public InstrumentException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }
}

