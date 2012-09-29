<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="View_Orders.aspx.cs" Inherits="User_View_Orders" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	<h2><asp:Label ID="lblH2ViewOrders" runat="server" Text="View Orders" 
			meta:resourcekey="lblH2ViewOrdersResource1"></asp:Label></h2>

	<asp:GridView ID="gvOrders" runat="server" DataSourceID="sourceOrders" 
	AutoGenerateColumns="False" Width="80%" CellPadding="6" OnRowDataBound="gvOrders_RowCreated" OnRowCommand="gvOrders_RowCommand"
		meta:resourcekey="gvOrdersResource1">
		<Columns>
			<asp:BoundField DataField="unique_code" HeaderText="Order ID" 
				SortExpression="unique_code" meta:resourcekey="BoundFieldResource1" />
			<asp:BoundField DataField="timestamp" HeaderText="Timestamp" 
				SortExpression="timestamp" meta:resourcekey="BoundFieldResource2" />
			<asp:BoundField DataField="deadline" HeaderText="Deadline" 
				SortExpression="deadline" meta:resourcekey="BoundFieldResource3" />
			<asp:BoundField DataField="status" HeaderText="Status" 
				SortExpression="status" meta:resourcekey="BoundFieldResource4" />
			<asp:ButtonField ButtonType="Button" HeaderText="$$$" Text="$$$" CommandName="Pay" />
		</Columns>
	</asp:GridView>
	<asp:SqlDataSource ID="sourceOrders" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM orders"></asp:SqlDataSource>
</asp:Content>

