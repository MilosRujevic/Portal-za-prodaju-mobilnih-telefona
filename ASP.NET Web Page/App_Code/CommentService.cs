using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using MySql.Data.MySqlClient;
using System.Xml.Serialization;

/// <summary>
/// Summary description for CommentService
/// </summary>
[WebService(Namespace = "http://portmob.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class CommentService : System.Web.Services.WebService {

    public CommentService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string PostComment(string deviceId, string nickname, string pros, string cons) {
        if (DB.FetchDeviceName(deviceId) == null) return "Error: Device not found!";
				if (string.IsNullOrEmpty(pros) && string.IsNullOrEmpty(cons)) return "Error: You must write a comment!";

				if (string.IsNullOrEmpty(nickname)) nickname = "Anonymous";
				MySqlConnection con = DB.getNewConnection();
				con.Open();

				string sql = "INSERT INTO comments (mobile_device_id, nickname, pros, cons) VALUES (@deviceId, @nickname, @pros, @cons)";
				MySqlCommand cmd = new MySqlCommand(sql, con);

				cmd.Parameters.AddWithValue("@deviceId", deviceId);
				cmd.Parameters.AddWithValue("@nickname", nickname);
				cmd.Parameters.AddWithValue("@pros", pros);
				cmd.Parameters.AddWithValue("@cons", cons);

				cmd.ExecuteNonQuery();
				con.Close();

				return "Success: Comment posted!";
    }

		[WebMethod]
		[SoapInclude(typeof(SoapComment[]))]
		public List<SoapComment> GetComments(string deviceId)
		{
			List<SoapComment> comments = new List<SoapComment>();

			MySqlConnection con = DB.getNewConnection();
			con.Open();

			string sql = "SELECT * FROM comments WHERE mobile_device_id = " + deviceId;
			MySqlCommand cmd = new MySqlCommand(sql, con);
			MySqlDataReader reader = cmd.ExecuteReader();

			while (reader.Read())
			{
				SoapComment comment = new SoapComment();
				comment.Nickname = (string)reader["nickname"];
				comment.Pros = (string)reader["pros"];
				comment.Cons = (string)reader["cons"];

				comments.Add(comment);
			}

			reader.Close();
			con.Close();

			return comments;
		}
}