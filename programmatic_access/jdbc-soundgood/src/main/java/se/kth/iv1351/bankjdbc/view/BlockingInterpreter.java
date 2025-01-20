package se.kth.iv1351.bankjdbc.view;

import java.util.List;
import java.util.Scanner;

import se.kth.iv1351.bankjdbc.controller.Controller;
import se.kth.iv1351.bankjdbc.model.InstrumentDTO;



/**
 * Reads and interprets user commands. This command interpreter is blocking, the user
 * interface does not react to user input while a command is being executed.
 */
public class BlockingInterpreter {
    private static final String PROMPT = "> ";
    private final Scanner console = new Scanner(System.in);
    private Controller ctrl;
    private boolean keepReceivingCmds = false;

    /**
     * Creates a new instance that will use the specified controller for all operations.
     * 
     * @param ctrl The controller used by this instance.
     */
    public BlockingInterpreter(Controller ctrl) {
        this.ctrl = ctrl;
    }

    /**
     * Stops the commend interpreter.
     */
    public void stop() {
        keepReceivingCmds = false;
    }

    /**
     * Interprets and performs user commands. This method will not return until the
     * UI has been stopped. The UI is stopped either when the user gives the
     * "quit" command, or when the method <code>stop()</code> is called.
     */
    public void handleCmds() {
        keepReceivingCmds = true;
        while (keepReceivingCmds) {
            try {
                CmdLine cmdLine = new CmdLine(readNextLine());
                switch (cmdLine.getCmd()) {
                    case HELP:
                        for (Command command : Command.values()) {
                            if (command == Command.ILLEGAL_COMMAND) {
                                continue;
                            }
                            System.out.println(command.toString().toLowerCase());
                        }
                        break;
                    case QUIT:
                        keepReceivingCmds = false;
                        break;
                    case LIST_INSTRUMENTS:
                        List<? extends InstrumentDTO> instruments = ctrl.getAvailableInstruments(cmdLine.getParameter(0));
                        if (instruments.isEmpty()) {
                            System.out.println("No instruments are available at this moment:(");
                        } else {
                            for (InstrumentDTO instrument : instruments) {
                                System.out.println("instrument: " + instrument.getInstrumentName() + ", "
                                                    + "brand: " + instrument.getBrand() + ", "
                                                    + "price: " + instrument.getRentalPrice());
                            }
                        }
                        break;
                    
                    case RENT_INSTRUMENT:
                        int studentId = Integer.parseInt(cmdLine.getParameter(0));
                        String instrumentSerialNumber = cmdLine.getParameter(1);
                        InstrumentDTO instrumentToRent = ctrl.findInstrumentBySerialNumber(instrumentSerialNumber);
                        if (instrumentToRent != null) {
                            ctrl.rentInstrument(studentId, instrumentToRent);
                        } else {
                            System.out.println("This instrument is not found: " + instrumentSerialNumber);
                        }
                        break;
                    case TERMINATE_RENTAL:
                        int rentalId = Integer.parseInt(cmdLine.getParameter(0));
                        String serialNumber = cmdLine.getParameter(1);
                        InstrumentDTO instrumentToTerminate = ctrl.findInstrumentBySerialNumber(serialNumber);
                        if (instrumentToTerminate != null) {
                            ctrl.terminateRental(rentalId, instrumentToTerminate);
                        } else {
                            System.out.println("This instrument is not found: " + serialNumber);
                        }
                        break;

                    default:
                        System.out.println("illegal command");
                }
            } catch (Exception e) {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    
    
    
    

    private String readNextLine() {
        System.out.print(PROMPT);
        return console.nextLine();
    }
}

