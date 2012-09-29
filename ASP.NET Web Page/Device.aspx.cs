using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;

public partial class Device : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			string deviceName = DB.FetchDeviceName(Request.QueryString["id"]);

			if (deviceName == null) Response.Redirect(Global.BaseUrl);
			lblH2DeviceName.Text = deviceName;

			if (!IsPostBack)
			{
				if (User.IsInRole("order")) {
					btnAddToCart.Visible = true;
					lblAmount.Visible = true;
					ddlAmount.Visible = true;
					lblH2AddToCart.Visible = true;
				}

				if (User.IsInRole("manage_devices")) {
					CommandField cmd = new CommandField();
					cmd = (CommandField)dvDevices.Fields[0];
					cmd.ShowEditButton = true;
					cmd.ShowDeleteButton = true;

					cmd = (CommandField)dvPictures.Fields[3];
					cmd.ShowEditButton = true;
					cmd.ShowInsertButton = true;
					cmd.ShowDeleteButton = true;
				}
			}
    }

		/**
		 * Redirect after item delete
		 */ 
		protected void dvDevices_ItemDeleted(object sender, EventArgs e) 
		{
			Response.Redirect("~/");
		}

		protected void btnPostComment_Click(object sender, EventArgs e)
		{
			CommentService cs = new CommentService();

			string deviceId = Request.QueryString["id"];
			string nickname = txtNickname.Text;
			string pros = txtPros.Text;
			string cons = txtCons.Text;

			string result = cs.PostComment(deviceId, nickname, pros, cons);

			//lblPostCommentResult.Text = result;

			Response.Redirect(Request.RawUrl);
		}

		protected void btnAddToCart_Click(object sender, EventArgs e)
		{
			string amount = ddlAmount.Text;
			string device = Request.QueryString["id"];
			string user = Global.GetUserID();

			MySqlConnection con = DB.getNewConnection();
			con.Open();

			string sql = "INSERT INTO carts (mobile_device_id, user_id, amount) VALUES (@device, @user, @amount)";
			MySqlCommand cmd = new MySqlCommand(sql, con);

			cmd.Parameters.AddWithValue("@device", device);
			cmd.Parameters.AddWithValue("@user", user);
			cmd.Parameters.AddWithValue("@amount", amount);

			cmd.ExecuteNonQuery();
			con.Close();

			lblAddToCartResult.Text = "Added to card!";
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
