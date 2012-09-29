using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using MySql.Data.MySqlClient;
using System.Xml.Serialization;

/// <summary>
/// Summary description for SearchService
/// </summary>
[WebService(Namespace = "http://portmob.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class SearchService : System.Web.Services.WebService {

    public SearchService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

		[WebMethod]
		[SoapInclude(typeof(SoapDevice[]))]
		public List<SoapDevice> Search(string company, string model, string os, string price, string minmax, int startItem, int numOfItems)
		{
			List<SoapDevice> devices = new List<SoapDevice>();


			MySqlConnection con = DB.getNewConnection();
			con.Open();

			string sql = "SELECT * FROM mobile_devices m";
			int searchParams = 0;

			// search model
			if (!string.IsNullOrEmpty(model))
			{
				if (0 == searchParams++) sql += " WHERE";
				else sql += " AND";

				sql += " model_name LIKE '%" + model + "%'";
			}

			// search os
			if (!string.IsNullOrEmpty(os))
			{
				if (0 == searchParams++) sql += " WHERE";
				else sql += " AND";

				sql += " spec_os LIKE '%" + os + "%'";
			}

			// search price
			if (!string.IsNullOrEmpty(price))
			{
				if (0 == searchParams++) sql += " WHERE";
				else sql += " AND";

				if (minmax.Equals("min")) sql += " price >= " + price;
				else sql += " price <= " + price;
			}

			// search company
			if (!string.IsNullOrEmpty(company))
			{
				if (0 == searchParams++) sql += " WHERE";
				else sql += " AND";

				sql += " company_id IN (SELECT id FROM companies WHERE name LIKE '%" + company + "%')";
			}

			MySqlCommand cmd = new MySqlCommand(sql, con);

			MySqlDataReader reader = cmd.ExecuteReader();

			int currentItem = 0;
			while (reader.Read())
			{

				if (currentItem < startItem) { currentItem++; continue; }
				if (currentItem >= startItem + numOfItems) { currentItem++; break; }
				currentItem++;

				SoapDevice device = new SoapDevice();
				device.Id = (int)reader["id"];
				device.Name = (string)reader["model_name"];
				device.Company = DB.FetchCompanyName((int)reader["company_id"]);
				device.SpecOs = (string)reader["spec_os"];
				device.Price = (double)reader["price"];
				
				devices.Add(device);
			}

			reader.Close();
			con.Close();

			return devices;
		}
}
