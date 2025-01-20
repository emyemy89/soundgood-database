package se.kth.iv1351.bankjdbc.integration;

/**
 * Thrown when a call to the music school database fails.
 */
public class SoundgoodDBException extends Exception {

    /**
     * Create a new instance thrown because of the specified reason
     *
     * @param reason Why the exception was thrown.
     */
    public SoundgoodDBException(String reason) {
        super(reason);
    }

    /**
     *
     * @param reason    Why the exception was thrown
     * @param rootCause The exception that caused this exception to be thrown.
     */
    public SoundgoodDBException(String reason, Throwable rootCause) {
        super(reason, rootCause);
    }
}
