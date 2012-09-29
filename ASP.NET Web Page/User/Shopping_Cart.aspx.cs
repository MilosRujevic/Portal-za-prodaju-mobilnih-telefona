using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Security.Cryptography;

public partial class User_Shopping_Cart : System.Web.UI.Page
{
		protected double priceOfAll = 0;
	
    protected void Page_Load(object sender, EventArgs e)
    {
			if (Profile.IsAnonymous) Response.Redirect("~/Account/Login.aspx"); // Error: not a user!
			if (!User.IsInRole("order")) Response.Redirect("~");
			sourceShoppingCart.SelectCommand = "SELECT * FROM carts WHERE user_id = " + Global.GetUserID();

			// provera da li je korpa prazna
			string user_id = Global.GetUserID();

			MySqlConnection con = DB.getNewConnection();
			string sql = "SELECT * FROM carts WHERE user_id = " + user_id;

			con.Open();
			MySqlCommand cmd = new MySqlCommand(sql, con);
			MySqlDataReader reader = cmd.ExecuteReader();

			if (!reader.Read())
			{
				OrderWizard.Visible = false;
				lblCartEmpty.Visible = true;
			}
    }

		protected double FetchPrice(int device_id, int amount)
		{
			double price = DB.FetchPrice(device_id) * amount;
			priceOfAll += price;
			return price;
		}

		// DELETE iz GridView-a je jednostavno previse bagovao...
		protected void btnRemove_Click(object sender, EventArgs e)
		{
			Button btn = (Button)sender;
      string idToDel = btn.CommandArgument;

			DB.DeleteRow("carts", "id", idToDel);

			Response.Redirect(Request.RawUrl);
		}

		protected void OrderWizard_FinishButtonClick(object sender, WizardNavigationEventArgs e)
		{
			string user_id = Global.GetUserID();

			MySqlConnection con = DB.getNewConnection();
			string sql = "SELECT * FROM carts WHERE user_id = " + user_id;

			con.Open();
			MySqlCommand cmd = new MySqlCommand(sql, con);
			MySqlDataReader reader = cmd.ExecuteReader();

			bool okToOrder = true;

			lock(Global.dbMutex) {

				while (reader.Read())
				{
					int mobile_device_id = (int)reader["mobile_device_id"];
					int amount = (int)reader["amount"];

					if (amount > DB.FetchAvailable(mobile_device_id))
					{
						okToOrder = false;
					}
				}

				if (okToOrder) PlaceOrder(user_id);
			}

			if (!okToOrder) { /* TODO error msg */ }

			reader.Close();
			con.Close();

			if (okToOrder) Response.Redirect(Request.Url.ToString());
		}

		private void PlaceOrder(string user_id) {

			// place order
			string unique_code = user_id + "-" + DateTime.UtcNow.ToString("MMddHHmm");
			unique_code += "-" + Global.CalculateMD5Hash(DateTime.UtcNow.ToString()).Substring(28);

			string sql = "INSERT INTO orders (user_id, unique_code, deadline, status) VALUES ("
				+ user_id + ","
				+ "'" + unique_code + "'" + ","
				+ "DATE_ADD(NOW(), INTERVAL 15 DAY),"
				+ "'pending'" + ")";
			DB.ExecuteSQLNonQuery(sql);

			// fetch id of the order
			int order_id = DB.FetchIntField("id", "orders", "unique_code", unique_code);

			MySqlConnection con = DB.getNewConnection();
			con.Open();

			// report variables
			double totalPrice = 0;
			string tableString = @"<table>
				<tr>
					<th>Device Name</th>
					<th>Price</th>
					<th>Amount</th>
				</tr>";

			// place order items
			sql = "SELECT * FROM carts WHERE user_id = " + user_id;
			MySqlCommand cmd = new MySqlCommand(sql, con);
			MySqlDataReader reader = cmd.ExecuteReader();
			while (reader.Read())
			{
				int mobile_device_id = (int)reader["mobile_device_id"];
				int amount = (int)reader["amount"];
				double price = DB.FetchPrice(mobile_device_id);
				
				sql = "INSERT INTO order_items (mobile_device_id, order_id, amount, price) VALUES ("
					+ mobile_device_id + ","
					+ order_id + ","
					+ amount.ToString() + ","
					+ price + ")";

				DB.ExecuteSQLNonQuery(sql);
				DB.AddToAmount(mobile_device_id, -amount); // update availability

				// update report variables
				totalPrice += price * amount;
				tableString += "<tr>";
					tableString += "<td>" + DB.FetchDeviceName(mobile_device_id).ToString() + "</td>";
					tableString += "<td>" + price.ToString() + "</td>";
					tableString += "<td>" + amount.ToString() + "</td>";
				tableString += "</tr>";
			}
			reader.Close();
			tableString += "</table>";

			// create and send report and invoice PDFs
			string userNameAndSurname = Profile.Name + " " + Profile.Surname;
			PDFReport.MakeReportPDF(unique_code, totalPrice.ToString(), tableString);
			PDFReport.MakeInvoicePDF(unique_code, userNameAndSurname, totalPrice.ToString());
			PDFReport.SendEmail(unique_code, Profile.UserName, userNameAndSurname);

			// delete from cart
			sql = "DELETE FROM carts WHERE user_id = " + user_id;
			cmd = new MySqlCommand(sql, con);
			cmd.ExecuteNonQuery();
			
			con.Close();
		}

		protected override void InitializeCulture()
		{
			if (Profile.Language == 2)
			{
				System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("sr-Latn-RS");
				System.Threading.Thread.CurrentThread.CurrentUICulture = culture;
				System.Threading.Thread.CurrentThread.CurrentCulture = culture;
			}

			base.InitializeCulture();
		}
}