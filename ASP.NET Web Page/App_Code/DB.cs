using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Configuration;


/// <summary>
/// Summary description for DB
/// </summary>
public class DB
{
	public DB()
	{
	}

	public static MySqlConnection getNewConnection() {
		return new MySqlConnection(ConfigurationManager.ConnectionStrings["mysqlConnectionString"].ConnectionString);
	}

	public static string FetchRow(string table, string row, string id)
	{
		if (string.IsNullOrEmpty(id)) return null;

		MySqlConnection con = getNewConnection();
		string sql = "SELECT * FROM " + table + " WHERE id = " + id;

		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		MySqlDataReader reader = cmd.ExecuteReader();

		string ret = null;

		while (reader.Read())
		{
			ret = (string)reader[row];
		}
		reader.Close();
		con.Close();

		return ret;
	}

	public static void DeleteRow(string table, string where, string id) {
		string sql = "DELETE FROM " + table + " WHERE " + where + " = " + id;
		ExecuteSQLNonQuery(sql);
	}
	
	public static string FetchDeviceName(string id)
	{
		return FetchRow("mobile_devices", "model_name", id);
	}
	public static string FetchDeviceName(int id)
	{
		return FetchRow("mobile_devices", "model_name", id.ToString());
	}

	public static string FetchCompanyName(string id)
	{
		return FetchRow("companies", "name", id);
	}
	public static string FetchCompanyName(int id)
	{
		return FetchRow("companies", "name", id.ToString());
	}

	public static int FetchIntField(string select, string from, string where, int id) {
		return FetchIntField(select, from, where, id.ToString());
	}
	public static int FetchIntField(string select, string from, string where, string id)
	{
		MySqlConnection con = getNewConnection();
		string sql = "SELECT " + select + " FROM " + from + " WHERE " + where + " = '" + id + "'";

		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		MySqlDataReader reader = cmd.ExecuteReader();

		int ret = 0;

		while (reader.Read())
		{
			ret = (int)reader[select];
		}
		reader.Close();
		con.Close();
		return ret;
	}

	public static string FetchStringField(string select, string from, string where, string id)
	{
		MySqlConnection con = getNewConnection();
		string sql = "SELECT " + select + " FROM " + from + " WHERE " + where + " = '" + id + "'";

		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		MySqlDataReader reader = cmd.ExecuteReader();

		string ret = null;

		while (reader.Read())
		{
			ret = (string)reader[select];
			break;
		}
		reader.Close();
		con.Close();
		return ret;
	}
	public static string FetchStringField(string select, string from, string where, int id)
	{
		return FetchStringField(select, from, where, id.ToString());
	}

	public static int FetchAvailable(int device_id)
	{
		return FetchIntField("available", "mobile_devices", "id", device_id);
	}

	public static double FetchPrice(int device_id)
	{
		MySqlConnection con = getNewConnection();
		string sql = "SELECT price FROM mobile_devices WHERE id = " + device_id;

		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		MySqlDataReader reader = cmd.ExecuteReader();

		double ret = 0;

		while (reader.Read())
		{
			ret = (double)reader["price"];
		}
		reader.Close();
		con.Close();
		return ret;
	}

	public static void ExecuteSQLNonQuery(string sql) {
		MySqlConnection con = getNewConnection();
		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		cmd.ExecuteNonQuery();
		con.Close();
	}

	public static void AddToAmount(int device_id, int amount) {
		string sql = "UPDATE mobile_devices SET available = available + " + amount + " WHERE id = " + device_id;
		ExecuteSQLNonQuery(sql);
	}

	public static string FetchImage(int device_id)
	{
		return FetchStringField("picture", "pictures", "mobile_device_id", device_id);
	}

	public static SoapDevice FetchSoapDevice(int device_id) 
	{
		SoapDevice device = new SoapDevice();

		MySqlConnection con = getNewConnection();
		string sql = "SELECT * FROM mobile_devices WHERE id = " + device_id;

		con.Open();
		MySqlCommand cmd = new MySqlCommand(sql, con);
		MySqlDataReader reader = cmd.ExecuteReader();

		while (reader.Read())
		{
			device.Id = device_id;
			device.Name = (string)reader["model_name"];
			if (device.Name == null) return null;
			device.Company = FetchCompanyName(device_id);
			device.SpecShape = (string)reader["spec_shape"];
			device.SpecOs = (string)reader["spec_os"];
			device.SpecConnectivity = (string)reader["spec_connectivity"];
			device.SpecDisplay = (string)reader["spec_display"];
			device.SpecInterface = (string)reader["spec_interface"];
			device.SpecCamera = (string)reader["spec_camera"];
			device.SpecMemory = (string)reader["spec_memory"];
			device.SpecBattery = (string)reader["spec_battery"];
			device.Available = (int)reader["available"];
			device.Price = (double)reader["price"];

			device.Picture = Global.BaseUrl + "Pictures/" + FetchImage(device_id);
		}
		reader.Close();
		con.Close();

		return device;
	}
}