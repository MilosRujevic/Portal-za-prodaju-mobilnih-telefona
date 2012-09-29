<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Manage_User.aspx.cs" Inherits="Administrator_Manage_User" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

	<asp:Table ID="profileTable" runat="server" CellPadding="6" Width="50%" 
		meta:resourcekey="profileTableResource1">
		<asp:TableRow meta:resourcekey="TableRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource1">Username / E-mail</asp:TableCell>
			<asp:TableCell>
				<asp:Label ID="lblUsername" runat="server" 
				meta:resourcekey="lblUsernameResource1"></asp:Label>
</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource2">
			<asp:TableCell meta:resourcekey="TableCellResource3">Category</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlCategory" runat="server" 
				meta:resourcekey="ddlCategoryResource1">
					<asp:ListItem Value="client" Text="client" meta:resourcekey="ListItemResource1"></asp:ListItem>
					
<asp:ListItem Value="administrator" Text="administrator" 
						meta:resourcekey="ListItemResource2"></asp:ListItem>
				
</asp:DropDownList>
			
</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource3">
			<asp:TableCell meta:resourcekey="TableCellResource5">Name</asp:TableCell>
			<asp:TableCell>
				<asp:TextBox ID="tbName" runat="server" meta:resourcekey="tbNameResource1"></asp:TextBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource4">
			<asp:TableCell meta:resourcekey="TableCellResource7">Surname</asp:TableCell>
			<asp:TableCell>
				<asp:TextBox ID="tbSurname" runat="server" meta:resourcekey="tbSurnameResource1"></asp:TextBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource5">
			<asp:TableCell meta:resourcekey="TableCellResource9">No. of Search Items</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlSearchSize" runat="server" meta:resourcekey="ddlSearchSizeResource1">
					<asp:ListItem Value="5" Text="5" meta:resourcekey="ListItemResource3"></asp:ListItem>
					<asp:ListItem Value="10" Text="10" meta:resourcekey="ListItemResource4"></asp:ListItem>
					<asp:ListItem Value="15" Text="15" meta:resourcekey="ListItemResource5"></asp:ListItem>
					<asp:ListItem Value="20" Text="20" meta:resourcekey="ListItemResource6"></asp:ListItem>
				</asp:DropDownList>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource6">
			<asp:TableCell meta:resourcekey="TableCellResource11">Language</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlLanguages" runat="server" 
					DataSourceID="sourceLanguages" DataTextField="language" DataValueField="id"
					meta:resourcekey="ddlLanguagesResource1">
				</asp:DropDownList>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource7">
			<asp:TableCell meta:resourcekey="TableCellResource13">Can order</asp:TableCell>
			<asp:TableCell><asp:CheckBox 
				ID="cbCanOrder" runat="server" meta:resourcekey="cbCanOrderResource1"></asp:CheckBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource8">
			<asp:TableCell meta:resourcekey="TableCellResource15">Can view orders</asp:TableCell>
			<asp:TableCell><asp:CheckBox 
				ID="cbCanViewOrders" runat="server" meta:resourcekey="cbCanViewOrdersResource1"></asp:CheckBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource9">
			<asp:TableCell meta:resourcekey="TableCellResource17">Can edit profile</asp:TableCell>
			<asp:TableCell>
				<asp:CheckBox ID="cbCanEditProfile" runat="server" meta:resourcekey="cbCanEditProfileResource1"></asp:CheckBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource10">
			<asp:TableCell meta:resourcekey="TableCellResource19">Can manage users</asp:TableCell>
			<asp:TableCell>
				<asp:CheckBox ID="cbCanManageUsers" runat="server" meta:resourcekey="cbCanManageUsersResource1"></asp:CheckBox>			
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource11">
			<asp:TableCell meta:resourcekey="TableCellResource21">Can manage privileges</asp:TableCell>
			<asp:TableCell>
				<asp:CheckBox ID="cbCanManagePrivileges" runat="server" meta:resourcekey="cbCanManagePrivilegesResource1"></asp:CheckBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource12">
			<asp:TableCell meta:resourcekey="TableCellResource23">Can manage devices</asp:TableCell>
			<asp:TableCell>
				<asp:CheckBox ID="cbCanManageDevices" runat="server" meta:resourcekey="cbCanManageDevicesResource1"></asp:CheckBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableFooterRow meta:resourcekey="TableFooterRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource25"></asp:TableCell>
			<asp:TableCell>
				<asp:Button ID="btnSubmitProfileInfo" runat="server" Text="Save" 
					onclick="btnSubmitProfileInfo_Click" 
					meta:resourcekey="btnSubmitProfileInfoResource1" />
			</asp:TableCell>
		</asp:TableFooterRow>
	</asp:Table>

	<asp:SqlDataSource ID="sourceLanguages" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM languages">
	</asp:SqlDataSource>

</asp:Content>