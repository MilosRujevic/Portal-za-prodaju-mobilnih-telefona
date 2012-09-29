<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Administrator_Default" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2CreateUser" runat="server" Text="Create User" 
			meta:resourcekey="lblH2CreateUserResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlCreateUser" runat="server" Text="Open Create User Panel" 
		NavigateUrl="~/Administrator/Create_User.aspx" 
		meta:resourcekey="hlCreateUserResource1"></asp:HyperLink>
	
	<h2>
		<asp:Label ID="lblH2ManageUsers" runat="server" Text="Manage Users" 
			meta:resourcekey="lblH2ManageUsersResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlManageUsers" runat="server" Text="Open Manage Users Panel" 
		NavigateUrl="~/Administrator/Manage_Users.aspx" 
		meta:resourcekey="hlManageUsersResource1"></asp:HyperLink>
</div>

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2AddNewDevice" runat="server" Text="Add New Device" 
			meta:resourcekey="lblH2AddNewDeviceResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlAddNewDevice" runat="server" 
		Text="Open Add New Device Panel" 
		NavigateUrl="~/Administrator/Add_New_Device.aspx" 
		meta:resourcekey="hlAddNewDeviceResource1"></asp:HyperLink>

	<h2>
		<asp:Label ID="lblH2ManageCompanies" runat="server" Text="Manage Companies" 
			meta:resourcekey="lblH2ManageCompaniesResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlManageCompanies" runat="server" 
		Text="Open Manage Companies Panel" 
		NavigateUrl="~/Administrator/Manage_Companies.aspx" 
		meta:resourcekey="hlManageCompaniesResource1"></asp:HyperLink>
</div>

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2ListOrders" runat="server" Text="List Orders" 
			meta:resourcekey="lblH2ListOrdersResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlListOrders" runat="server" 
		Text="Open List Orders Menu" 
		NavigateUrl="~/Administrator/List_orders.aspx" 
		meta:resourcekey="hlListOrdersResource1"></asp:HyperLink>
</div>
</asp:Content>

