package soapobjects;

/**
 *
 * @author Aleksandar Abu-Samra
 */
public class SoapDevice {
	public int id;
	public String name;
	public String company;
	public String specShape;
	public String specOs;
	public String specConnectivity;
	public String specDisplay;
	public String specInterface;
	public String specCamera;
	public String specMemory;
	public String specBattery;
	public int available;
	public double price;

	public String picture;
	
	public String toString() {
		return name;
	}
	
	public int toInt() {
		return id;
	}
}
