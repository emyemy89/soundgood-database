package se.kth.iv1351.bankjdbc.model;

/**
 * Specifies a read-only view of an instrument.
 */
public interface InstrumentDTO {

 
    
    public int getInstrumentId();

    public String getSerialNumber();

    public String getInstrumentName();

    public String getBrand();

    public String getRentalPrice();


    public String getStatus();
}
