using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SoapDevice
/// </summary>
public class SoapDevice 
{
	private int id;
	private string name;
	private string company;
	private string specShape;
	private string specOs;
	private string specConnectivity;
	private string specDisplay;
	private string specInterface;
	private string specCamera;
	private string specMemory;
	private string specBattery;
	private int available;
	private double price;

	private string picture;

	public SoapDevice() {}

	public SoapDevice(int id)
	{
		this.id = id;
	}

	public int Id { get; set; }
	public string Name { get; set; }
	public string Company { get; set; }
	public string SpecOs { get; set; }
	public string SpecShape { get; set; }
	public string SpecConnectivity { get; set; }
	public string SpecDisplay { get; set; }
	public string SpecInterface { get; set; }
	public string SpecCamera { get; set; }
	public string SpecMemory { get; set; }
	public string SpecBattery { get; set; }
	public int Available { get; set; }
	public double Price { get; set; }

	public string Picture { get; set; }
}