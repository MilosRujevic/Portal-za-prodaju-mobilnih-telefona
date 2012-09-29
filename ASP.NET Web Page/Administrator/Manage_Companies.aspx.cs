using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_Manage_Companies : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (!User.IsInRole("manage_devices")) Response.Redirect("~/Administrator/"); // Error: not allowed!
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