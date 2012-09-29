using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (Profile.IsAnonymous) Response.Redirect("~/Account/Login.aspx"); // Error: not a user!
			
			if (Profile.Category != "administrator") {
				// Response.Redirect("~/Account/Login.aspx"); // Error: not administrator!
				lblH2ListOrders.Visible = false;
				hlListOrders.Visible = false;
			}

			if (!User.IsInRole("manage_users"))
			{
				hlCreateUser.Enabled = false;
				hlCreateUser.Style.Add("text-decoration", "line-through");
			}

			if (!User.IsInRole("manage_users") && !User.IsInRole("manage_privileges"))
			{
				hlManageUsers.Enabled = false;
				hlManageUsers.Style.Add("text-decoration", "line-through");
			}

			if (!User.IsInRole("manage_devices"))
			{
				hlManageCompanies.Enabled = false;
				hlManageCompanies.Style.Add("text-decoration", "line-through");
				hlAddNewDevice.Enabled = false;
				hlAddNewDevice.Style.Add("text-decoration", "line-through");
			}
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