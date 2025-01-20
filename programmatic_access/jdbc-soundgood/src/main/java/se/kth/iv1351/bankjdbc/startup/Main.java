package se.kth.iv1351.bankjdbc.startup;

import se.kth.iv1351.bankjdbc.controller.Controller;
import se.kth.iv1351.bankjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.bankjdbc.view.BlockingInterpreter;

/**
 * Starts the music rental client.
 */
public class Main {
    /**
     * @param args There are no command line arguments.
     */
    public static void main(String[] args) {
        try {
            new BlockingInterpreter(new Controller()).handleCmds();
        } catch (SoundgoodDBException e) {
            System.out.println("Could not connect to the music school database.");
            e.printStackTrace();
        }
    }
}

