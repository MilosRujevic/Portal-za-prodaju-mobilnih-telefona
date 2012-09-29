using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
			// dynamic menu
			if (Profile.IsAnonymous) {
				NavigationMenu.Items.RemoveAt(4);
				NavigationMenu.Items.RemoveAt(3);
			}
			else if (Profile.Category != "administrator") NavigationMenu.Items.RemoveAt(4); // sklanja admin link

			//CultureInfo srCulture = new System.Globalization.CultureInfo("sr-Latn-RS");
			//Thread.CurrentThread.CurrentUICulture = srCulture;
			//Thread.CurrentThread.CurrentCulture = srCulture;

//			Page.Culture = "sr-Latn-RS";
//			Page.UICulture = "sr-Latn-RS";
    }

}
