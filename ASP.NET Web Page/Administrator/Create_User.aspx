<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Create_User.aspx.cs" Inherits="Administrator_Create_User" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	<h2><asp:Label ID="lblH2CreateUser" runat="server" Text="Create User" 
			meta:resourcekey="lblH2CreateUserResource1"></asp:Label></h2>

	<asp:Table ID="profileTable" runat="server" CellPadding="6" Width="60%" 
		meta:resourcekey="profileTableResource1">
		<asp:TableRow meta:resourcekey="TableRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource1">Username / E-mail</asp:TableCell>
			<asp:TableCell>
				<asp:TextBox ID="tbUsername" runat="server" meta:resourcekey="tbUsernameResource1"></asp:TextBox>
					
					<asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="tbUsername" CssClass="failureNotification" 
						ErrorMessage="E-mail is required." ToolTip="E-mail is required." 
						meta:resourcekey="UserNameRequiredResource1">*</asp:RequiredFieldValidator>
					
					<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbUsername"
						ErrorMessage="E-mail address is not valid" 
						ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
						meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
			
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource2">
			<asp:TableCell meta:resourcekey="TableCellResource3">Category</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlCategory" runat="server" meta:resourcekey="ddlCategoryResource1">
					<asp:ListItem Value="client" Text="client" meta:resourcekey="ListItemResource1"></asp:ListItem>
					
					<asp:ListItem Value="administrator" Text="administrator" meta:resourcekey="ListItemResource2"></asp:ListItem>	
					
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
				<asp:DropDownList ID="ddlSearchSize" runat="server" meta:resourcekey="ddlSearchSizeResource1" >
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
				<asp:DropDownList ID="ddlLanguages" runat="server" DataSourceID="sourceLanguages" DataTextField="language" DataValueField="id" 
					meta:resourcekey="ddlLanguagesResource1">
				</asp:DropDownList>
			
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableFooterRow meta:resourcekey="TableFooterRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource13"></asp:TableCell>
			<asp:TableCell>
				<asp:Button ID="btnCreateUser" runat="server" Text="Save" onclick="btnCreateUser_Click" meta:resourcekey="btnCreateUserResource1" />
			
			</asp:TableCell>
		</asp:TableFooterRow>
	</asp:Table>

	<asp:SqlDataSource ID="sourceLanguages" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM languages">
	</asp:SqlDataSource>

</asp:Content>