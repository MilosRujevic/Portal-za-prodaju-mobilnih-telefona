using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Administrator_Manage_User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (!User.IsInRole("manage_users") && !User.IsInRole("manage_privileges")) Response.Redirect("~/Administrator/"); // Error: not allowed!

			// privilege: manage users
			if (!User.IsInRole("manage_users"))
			{
				ddlCategory.Enabled = false;
				tbName.Enabled = false;
				tbSurname.Enabled = false;
				ddlSearchSize.Enabled = false;
				ddlLanguages.Enabled = false;
			}

			// privilege: manage privileges
			if (!User.IsInRole("manage_privileges"))
			{
				cbCanOrder.Enabled = false;
				cbCanViewOrders.Enabled = false;
				cbCanEditProfile.Enabled = false;
				cbCanManageDevices.Enabled = false;
				cbCanManagePrivileges.Enabled = false;
				cbCanManageUsers.Enabled = false;
			}


			string queryString = Request.QueryString["user"];
			if (string.IsNullOrEmpty(queryString)) Response.Redirect(Global.BaseUrl);

			if (!IsPostBack)
			{
				// check if profile exists				
				ProfileCommon profile = UserProfile.GetProfile(queryString);
				if (profile == null) Response.Redirect(Global.BaseUrl);

				// load profile data
				lblUsername.Text = profile.UserName;
				ddlCategory.SelectedValue = profile.Category;
				tbName.Text = profile.Name;
				tbSurname.Text = profile.Surname;
				ddlSearchSize.SelectedValue = profile.SearchSize.ToString();
				ddlLanguages.SelectedValue = profile.Language.ToString();

				// load privileges
				cbCanOrder.Checked = Roles.IsUserInRole(queryString, "order");
				cbCanViewOrders.Checked = Roles.IsUserInRole(queryString, "view_orders");
				cbCanEditProfile.Checked = Roles.IsUserInRole(queryString, "edit_profile");
				cbCanManageUsers.Checked = Roles.IsUserInRole(queryString, "manage_users");
				cbCanManagePrivileges.Checked = Roles.IsUserInRole(queryString, "manage_privileges");
				cbCanManageDevices.Checked = Roles.IsUserInRole(queryString, "manage_devices");
			}
    }

		protected void btnSubmitProfileInfo_Click(object sender, EventArgs e)
		{
			string username = lblUsername.Text;

			// save user profile
			ProfileCommon profile = UserProfile.GetProfile(username);
			profile.Category = ddlCategory.SelectedValue;
			profile.Name = tbName.Text;
			profile.Surname = tbSurname.Text;
			profile.SearchSize = UInt16.Parse(ddlSearchSize.SelectedValue);
			profile.Language = UInt16.Parse(ddlLanguages.SelectedValue);
			profile.Save();

			// save user privileges
			if (cbCanOrder.Checked)
			{
				if (!Roles.IsUserInRole(username, "order")) Roles.AddUserToRole(username, "order");
			}
			else if (Roles.IsUserInRole(username, "order")) Roles.RemoveUserFromRole(username, "order");

			if (cbCanViewOrders.Checked)
			{
				if (!Roles.IsUserInRole(username, "view_orders")) Roles.AddUserToRole(username, "view_orders");
			}
			else if (Roles.IsUserInRole(username, "view_orders")) Roles.RemoveUserFromRole(username, "view_orders");

			if (cbCanEditProfile.Checked)
			{
				if (!Roles.IsUserInRole(username, "edit_profile")) Roles.AddUserToRole(username, "edit_profile");
			}
			else if (Roles.IsUserInRole(username, "edit_profile")) Roles.RemoveUserFromRole(username, "edit_profile");

			if (cbCanManageUsers.Checked)
			{
				if (!Roles.IsUserInRole(username, "manage_users")) Roles.AddUserToRole(username, "manage_users");
			}
			else if (Roles.IsUserInRole(username, "manage_users")) Roles.RemoveUserFromRole(username, "manage_users");

			if (cbCanManagePrivileges.Checked)
			{
				if (!Roles.IsUserInRole(username, "manage_privileges")) Roles.AddUserToRole(username, "manage_privileges");
			}
			else if (Roles.IsUserInRole(username, "manage_privileges")) Roles.RemoveUserFromRole(username, "manage_privileges");

			if (cbCanManageDevices.Checked)
			{
				if (!Roles.IsUserInRole(username, "manage_devices")) Roles.AddUserToRole(username, "manage_devices");
			}
			else if (Roles.IsUserInRole(username, "manage_devices")) Roles.RemoveUserFromRole(username, "manage_devices");
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