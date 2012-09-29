using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Serialization;

/// <summary>
/// Summary description for DeviceDetailsService
/// </summary>
[WebService(Namespace = "http://portmob.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class DeviceDetailsService : System.Web.Services.WebService {

    public DeviceDetailsService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
		[SoapInclude(typeof(SoapDevice))]
    public SoapDevice GetDevice(int id) {
				SoapDevice device = DB.FetchSoapDevice(id);
				return device;
    }
    
}
