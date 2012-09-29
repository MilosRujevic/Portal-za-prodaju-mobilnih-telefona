using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_Manage_Users : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (!User.IsInRole("manage_users") && !User.IsInRole("manage_privileges")) Response.Redirect("~/Administrator/"); // Error: not allowed!
    }

		/*
		 * Update isAoproved field from checkbox
		 */
		protected void cbApproved_OnCheckedChange(object sender, EventArgs e)
		{
			CheckBox chkApproved = (CheckBox)sender;
			//Label lblEmail = (Label)chkApproved.NamingContainer.FindControl("lblEmail");
			HyperLink hlEmail = (HyperLink)chkApproved.NamingContainer.FindControl("hlEmail");

			string email = hlEmail.Text;
			bool approved = chkApproved.Checked;
		
			string sql = "UPDATE my_aspnet_membership SET IsApproved = + " + approved  + " WHERE Email = '" + email + "'";
			DB.ExecuteSQLNonQuery(sql);
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