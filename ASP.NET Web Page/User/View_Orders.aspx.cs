using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class User_View_Orders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (Profile.IsAnonymous) Response.Redirect("~/Account/Login.aspx"); // Error: not a user!
			if (!User.IsInRole("view_orders")) Response.Redirect("~");

			checkDeadlines();

			sourceOrders.SelectCommand = "SELECT * FROM orders WHERE user_id = " + Global.GetUserID();
    }

		/**
		 * Proverava da li je nekoj porudzbini istekao deadline
		 */
		protected void checkDeadlines()
		{
			MySqlConnection con = DB.getNewConnection();
			con.Open();

			string sql = "SELECT * FROM orders WHERE user_id = " + Global.GetUserID() + " AND deadline < NOW() AND status ='pending'";
			MySqlCommand cmd = new MySqlCommand(sql, con);
			MySqlDataReader reader = cmd.ExecuteReader();


			// vrati kolicinu u promet
			while (reader.Read())
			{
					int orderId = (int)reader["id"];
					DB.ExecuteSQLNonQuery("UPDATE orders SET status = 'failed' WHERE id = " + orderId);

					sql = "SELECT * FROM order_items WHERE order_id = " + orderId;
					cmd = new MySqlCommand(sql, con);
					MySqlDataReader readerItems = cmd.ExecuteReader();
					while (readerItems.Read()) {
						int deviceId = (int)readerItems["mobile_device_id"];
						int amount = (int)readerItems["amount"];

						sql = "UPDATE mobile_devices SET amount = amount + " + amount + " WHERE id = " + deviceId;
						DB.ExecuteSQLNonQuery(sql);
					}
			}
			reader.Close();
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

		/**
		 * Handle order commands
		 */
		protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			// Wanna pay?
			if ("Pay" == e.CommandName)
			{
				int index = Convert.ToInt32(e.CommandArgument);

				GridViewRow selectedRow = gvOrders.Rows[index];
				string uniqueCode = selectedRow.Cells[0].Text;
				string status = selectedRow.Cells[3].Text;

				if ("pending" == status) {
					string sql = "UPDATE orders SET status = 'done' WHERE unique_code = '" + uniqueCode + "'";
					DB.ExecuteSQLNonQuery(sql);
				}
			}

			Response.Redirect(Request.Url.ToString());
		}

		/**
		 * Update / disable grid options for user
		 */
		protected void gvOrders_RowCreated(object sender, GridViewRowEventArgs e)
		{
			if ("pending" != e.Row.Cells[3].Text)
			{
				e.Row.Cells[4].Controls.Clear();
			}
		}
}