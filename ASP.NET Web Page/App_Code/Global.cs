using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Web.Security;
using System.Security.Cryptography;
using System.Net.Mail;
using System.Net;

/// <summary>
/// Summary description for Global
/// </summary>
public class Global
{
	public static string BaseUrl = "http://localhost/";
	public static object dbMutex = new object();

	public Global()
	{
		//
		// TODO: Add constructor logic here
		//
	}

	public static string CalculateMD5Hash(string input)
	{
		MD5 md5 = System.Security.Cryptography.MD5.Create();
		byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
		byte[] hash = md5.ComputeHash(inputBytes);

		System.Text.StringBuilder sb = new System.Text.StringBuilder();
		for (int i = 0; i < hash.Length; i++)
		{
			sb.Append(hash[i].ToString("X2"));
		}
		return sb.ToString();
	}

	public static string GetUserID()
	{
		return Membership.GetUser().ProviderUserKey.ToString();
	}

	public static bool SendAccountInfo(string userEmail, string userNameAndSurname, string password)
	{
		var fromAddress = new MailAddress("x@gmail.com", "PortMob Team");
		var toAddress = new MailAddress(userEmail, userNameAndSurname);
		string fromPassword = "x";
		string subject = "New account information";
		string body = "Hello " + userNameAndSurname + "!\n\n";
			body += "You have a new account at PortMob!\n";
			body += "Please login to out website with this info:\n";
			body += "Username: " + userEmail + "\n";
			body += "Password: " + password;

		var smtp = new SmtpClient
		{
			Host = "smtp.gmail.com",
			Port = 587,
			EnableSsl = true,
			DeliveryMethod = SmtpDeliveryMethod.Network,
			UseDefaultCredentials = false,
			Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
		};
		using (var message = new MailMessage(fromAddress, toAddress)
		{
			Subject = subject,
			Body = body
		})
		{
			smtp.Send(message);
		}

		return true;
	}
}