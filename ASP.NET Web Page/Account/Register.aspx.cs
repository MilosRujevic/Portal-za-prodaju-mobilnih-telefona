using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_Register : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        // RegisterUser.Email = RegisterUser.UserName;
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

				// Get name and surname text boxes
				TextBox tbName = (TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Name");
				TextBox tbSurname = (TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Surname");

				// fetch newly created profile
				string strUsername = RegisterUser.UserName;
				ProfileCommon p = Profile.GetProfile(strUsername);

				// Fill profile
				p.Name = tbName.Text;
				p.Surname = tbSurname.Text;
				p.Category = "client";
				p.SearchSize = 10;
				p.Language = 1;
				p.Save();

				// Add default roles
				Roles.AddUserToRole(strUsername, "order");
				Roles.AddUserToRole(strUsername, "view_orders");
				Roles.AddUserToRole(strUsername, "edit_profile");
				
        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/";
        }
        Response.Redirect(continueUrl);
    }

    protected void RegisterUser_CreatingUser(object sender, EventArgs e)
    {
        CreateUserWizard cuw = (CreateUserWizard)sender;
        cuw.Email = cuw.UserName;
    }

}