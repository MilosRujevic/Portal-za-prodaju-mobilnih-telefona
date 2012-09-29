<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="List_Orders.aspx.cs" Inherits="Administrator_ListOrders" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

	<h2><asp:Label ID="lblH2ListOrders" runat="server" Text="List Orders" 
			meta:resourcekey="lblH2ListOrdersResource1"></asp:Label></h2>

	<asp:GridView ID="gvListOrders" runat="server" AllowSorting="True" 
		Width="60%" CellPadding="6"
		DataSourceID="sourceOrders" AutoGenerateColumns="False" 
		meta:resourcekey="gvListOrdersResource1">
		<Columns>
			<asp:BoundField DataField="unique_code" HeaderText="Unique Code" 
				SortExpression="unique_code" meta:resourcekey="BoundFieldResource1" />
			<asp:BoundField DataField="timestamp" HeaderText="Timestamp" 
				SortExpression="timestamp" meta:resourcekey="BoundFieldResource2" />
			<asp:BoundField DataField="deadline" HeaderText="Deadline" 
				SortExpression="deadline" meta:resourcekey="BoundFieldResource3" />
			<asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
				ReadOnly="True" SortExpression="id" Visible="False" 
				meta:resourcekey="BoundFieldResource4" />
			<asp:BoundField DataField="user_id" HeaderText="user_id" ReadOnly="True" 
				SortExpression="user_id" Visible="False" 
				meta:resourcekey="BoundFieldResource5" />
			<asp:BoundField DataField="status" HeaderText="Status" 
				SortExpression="status" meta:resourcekey="BoundFieldResource6" />
		</Columns>
	</asp:GridView>

	<asp:SqlDataSource ID="sourceOrders" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		DeleteCommand="DELETE FROM orders WHERE id = @id" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM orders" 
		UpdateCommand="UPDATE orders SET timestamp = @timestamp, unique_code = @unique_code, status = @status, deadline = @deadline WHERE id = @id">
		<DeleteParameters>
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="user_id" Type="Int32" />
		</DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="user_id" Type="Int32" />
			<asp:Parameter Name="timestamp" Type="DateTime" />
			<asp:Parameter Name="unique_code" Type="String" />
			<asp:Parameter Name="status" Type="String" />
			<asp:Parameter Name="deadline" Type="DateTime" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="timestamp" Type="DateTime" />
			<asp:Parameter Name="unique_code" Type="String" />
			<asp:Parameter Name="status" Type="String" />
			<asp:Parameter Name="deadline" Type="DateTime" />
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="user_id" Type="Int32" />
		</UpdateParameters>
	</asp:SqlDataSource>

</asp:Content>

