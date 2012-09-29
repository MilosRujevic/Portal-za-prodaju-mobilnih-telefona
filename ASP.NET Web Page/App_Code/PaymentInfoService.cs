using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Serialization;

/// <summary>
/// Summary description for PaymentInfoService
/// </summary>
[WebService(Namespace = "http://portmob.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class PaymentInfoService : System.Web.Services.WebService {

    public PaymentInfoService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string GetOrderStatus(string order_code)
		{
				return DB.FetchStringField("status", "orders", "unique_code", order_code);
    }

		/*
		public string GetOrderStatusAndNotify(string order_code)
		{
			string status = DB.FetchStringField("status", "orders", "unique_code", order_code);
			return status;
		}
		 */
    
}
