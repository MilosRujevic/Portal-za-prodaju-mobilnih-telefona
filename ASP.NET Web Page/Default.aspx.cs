using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

		protected override void InitializeCulture()
		{
			if (Profile.Language == 2) { 
				CultureInfo culture = new System.Globalization.CultureInfo("sr-Latn-RS");
				Thread.CurrentThread.CurrentUICulture = culture;
				Thread.CurrentThread.CurrentCulture = culture;
			}

			base.InitializeCulture();
		}

}
