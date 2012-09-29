using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Profile;

/// <summary>
/// Summary description for User
/// </summary>
public class UserProfile
{
	public UserProfile()
	{
		//
		// TODO: Add constructor logic here
		//
	}

	public static ProfileCommon GetProfile(string username)
	{
		return (ProfileCommon)ProfileBase.Create(username, true);
	}

	public static string GetName(string username)
	{
		return GetProfile(username).Name;
	}

	public static string GetSurname(string username)
	{
		return GetProfile(username).Surname;
	}

	public static int GetLanguage(string username)
	{
		return GetProfile(username).Language;
	}

	public static int GetSearchSize(string username)
	{
		return GetProfile(username).SearchSize;
	}

	public static string GetCategory(string username)
	{
		return GetProfile(username).Category;
	}
}