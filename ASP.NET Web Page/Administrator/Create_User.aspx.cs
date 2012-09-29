using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Administrator_Create_User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (!User.IsInRole("manage_users")) Response.Redirect("~/Administrator/"); // Error: not allowed!
    }

		protected void btnCreateUser_Click(object sender, EventArgs e)
		{
			UserNameRequired.Validate();
			RegularExpressionValidator1.Validate();

			// create new user
			string username = tbUsername.Text;
			string password = Global.CalculateMD5Hash(DateTime.UtcNow.ToString()).Substring(26);
			Membership.CreateUser(username, password);

			// email = username
			MembershipUser newUser = Membership.GetUser(username);
			newUser.Email = username;
			Membership.UpdateUser(newUser);

			// Add default roles
			Roles.AddUserToRole(username, "order");
			Roles.AddUserToRole(username, "view_orders");
			Roles.AddUserToRole(username, "edit_profile");

			// fill default prfile
			ProfileCommon profile = UserProfile.GetProfile(username);
			profile.Category = ddlCategory.SelectedValue;
			profile.Name = tbName.Text;
			profile.Surname = tbSurname.Text;
			profile.SearchSize = UInt16.Parse(ddlSearchSize.SelectedValue);
			profile.Language = UInt16.Parse(ddlLanguages.SelectedValue);
			profile.Save();

			// send info email
			Global.SendAccountInfo(username, profile.Name + " " + profile.Surname, password);

			Response.Redirect("~/Administrator/");
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