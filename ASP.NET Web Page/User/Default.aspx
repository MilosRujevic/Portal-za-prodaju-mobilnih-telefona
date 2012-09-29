<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="User_Default" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2Prifile" runat="server" Text="Profile" 
			meta:resourcekey="lblH2PrifileResource1"></asp:Label>
	</h2>
	
	<asp:Table ID="profileTable" runat="server" CellPadding="5" 
		meta:resourcekey="profileTableResource1">
		<asp:TableRow meta:resourcekey="TableRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource1">Username / E-mail</asp:TableCell>
			<asp:TableCell>
				<asp:Label ID="lblUsername" runat="server"></asp:Label>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource2">
			<asp:TableCell meta:resourcekey="TableCellResource3">Category</asp:TableCell>
			<asp:TableCell>
				<asp:Label ID="lblCategory" runat="server"></asp:Label>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource3">
			<asp:TableCell meta:resourcekey="TableCellResource5">Name</asp:TableCell>
			<asp:TableCell>
				<asp:TextBox ID="tbName" runat="server"></asp:TextBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource4">
			<asp:TableCell meta:resourcekey="TableCellResource7">Surname</asp:TableCell>
			<asp:TableCell>
				<asp:TextBox ID="tbSurname" runat="server"></asp:TextBox>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource5">
			<asp:TableCell meta:resourcekey="TableCellResource9">Password</asp:TableCell>
			<asp:TableCell>
				<asp:HyperLink ID="hlChangePassword" runat="server" 
				NavigateUrl="~/Account/ChangePassword.aspx" 
				meta:resourcekey="hlChangePasswordResource1">Change Password</asp:HyperLink>
</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource6">
			<asp:TableCell meta:resourcekey="TableCellResource11">No. of Search Items</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlSearchSize" runat="server" Meta:resourcekey="ddlSearchSizeResource1" >
					<asp:ListItem Value="5" Text="5" meta:resourcekey="ListItemResource1"></asp:ListItem>
					<asp:ListItem Value="10" Text="10" meta:resourcekey="ListItemResource2"></asp:ListItem>
					<asp:ListItem Value="15" Text="15" meta:resourcekey="ListItemResource3"></asp:ListItem>
					<asp:ListItem Value="20" Text="20" meta:resourcekey="ListItemResource4"></asp:ListItem>
				</asp:DropDownList>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableRow meta:resourcekey="TableRowResource7">
			<asp:TableCell meta:resourcekey="TableCellResource13">Language</asp:TableCell>
			<asp:TableCell>
				<asp:DropDownList ID="ddlLanguages" runat="server" DataSourceID="sourceLanguages" 
					DataTextField="language" DataValueField="id" meta:resourcekey="ddlLanguagesResource1">
				</asp:DropDownList>
			</asp:TableCell>
		</asp:TableRow>

		<asp:TableFooterRow meta:resourcekey="TableFooterRowResource1">
			<asp:TableCell meta:resourcekey="TableCellResource15"></asp:TableCell>
			<asp:TableCell>
				<asp:Button ID="btnSubmitProfileInfo" runat="server" Text="Save" onclick="btnSubmitProfileInfo_Click" meta:resourcekey="btnSubmitProfileInfoResource1" />
				<asp:Label ID="lblSaveFeedback" runat="server" Text="" meta:resourcekey="lblSaveFeedbackResource1"></asp:Label>
			</asp:TableCell>
		</asp:TableFooterRow>
	</asp:Table>

</div>

	<asp:SqlDataSource ID="sourceLanguages" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM languages">
	</asp:SqlDataSource>

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2ShoppingCart" runat="server" Text="Shopping Cart" 
			meta:resourcekey="lblH2ShoppingCartResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlShoppingCart" NavigateUrl="~/User/Shopping_Cart.aspx" 
		Text="View Shopping Cart" runat="server" 
		meta:resourcekey="hlShoppingCartResource1" />

	<h2>
		<asp:Label ID="lblH2Orders" runat="server" Text="Past Orders" 
			meta:resourcekey="lblH2OrdersResource1"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlViewOrders" NavigateUrl="~/User/View_Orders.aspx" 
		Text="View Past Orders" runat="server" 
		meta:resourcekey="hlViewOrdersResource1" />


	<h2>
		<asp:Label ID="lblH2Administrator" runat="server" Text="Administrator"></asp:Label>
	</h2>
	<asp:HyperLink ID="hlAdministrator" NavigateUrl="~/Administrator/" Text="Administrator" runat="server" />
</div>
</asp:Content>