using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (Profile.IsAnonymous) Response.Redirect("~/Account/Login.aspx"); // Error: not a user!

			if (!IsPostBack)
			{
				// populate user info text boxes
				lblUsername.Text = Profile.UserName; // read-only
				lblCategory.Text = Profile.Category; // read-only

				tbName.Text = Profile.Name;
				tbSurname.Text = Profile.Surname;
				ddlSearchSize.SelectedValue = Profile.SearchSize.ToString();
				ddlLanguages.SelectedValue = Profile.Language.ToString();

				// edit interface to privileges
				if (!User.IsInRole("view_orders")) {
					lblH2Orders.Visible = false;
					hlViewOrders.Visible = false;
				}

				if (!User.IsInRole("edit_profile"))
				{
					tbName.Enabled = false;
					tbSurname.Enabled = false;
					hlChangePassword.Enabled = false;
					ddlSearchSize.Enabled = false;
					ddlLanguages.Enabled = false;
					btnSubmitProfileInfo.Visible = false;
				}

				if (!User.IsInRole("order"))
				{
					lblH2ShoppingCart.Visible = false;
					hlShoppingCart.Visible = false;
				}

				if (!User.IsInRole("manage_users") && !User.IsInRole("manage_privileges") && !User.IsInRole("manage_devices"))
				{
					lblH2Administrator.Visible = false;
					hlAdministrator.Visible = false;
				}
			}
    }

		protected void btnSubmitProfileInfo_Click(object sender, EventArgs e)
		{
			Profile.Name = tbName.Text;
			Profile.Surname = tbSurname.Text;
			Profile.SearchSize = UInt16.Parse(ddlSearchSize.Text);
			Profile.Language = UInt16.Parse(ddlLanguages.SelectedValue);
			Profile.Save();

			lblSaveFeedback.Text = "Saved!";
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