<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Price_List.aspx.cs" Inherits="Price_List" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	<h2>
		<asp:Label ID="lblPriceList" runat="server" Text="Price List" 
			meta:resourcekey="lblPriceListResource1"></asp:Label>
	</h2>

	<div class="centerText">
		<asp:GridView ID="gvPriceList" runat="server" DataSourceID="sourcePrices" 
			AutoGenerateColumns="False" Width="40%" CellPadding="7" 
			meta:resourcekey="gvPriceListResource1">
			<Columns>
				<asp:BoundField DataField="model_name" HeaderText="Model Name" 
					SortExpression="model_name" meta:resourcekey="BoundFieldResource1" />
				<asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" 
					meta:resourcekey="BoundFieldResource2" />
			</Columns>
		</asp:GridView>
	</div>

	<asp:SqlDataSource ID="sourcePrices" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT price, model_name, company_id FROM mobile_devices">
	</asp:SqlDataSource>
</asp:Content>

