<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Manage_Companies.aspx.cs" Inherits="Administrator_Manage_Companies" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2ManageCompanies" runat="server" Text="Manage Companies" 
			meta:resourcekey="lblH2ManageCompaniesResource1"></asp:Label>
	</h2>

    <asp:GridView ID="gwCompanies" runat="server" AllowSorting="True" 
        DataSourceID="sourceCompanies"
        ShowHeaderWhenEmpty="True"
				DataKeyNames="id" Width="70%" CellPadding="6" 
		meta:resourcekey="gwCompaniesResource1">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
							meta:resourcekey="CommandFieldResource1" />
        </Columns>
    </asp:GridView>
</div>

<div class="fleft50">
	<h2>
		<asp:Label ID="lblH2AddNewCompany" runat="server" Text="Add New Company" 
			meta:resourcekey="lblH2AddNewCompanyResource1"></asp:Label>
	</h2>
			
	<asp:DetailsView ID="dwCompanies" runat="server" Width="70%"
		DataSourceID="sourceCompanies" 
		DataKeyNames="id"
		DefaultMode="Insert" AutoGenerateRows="False" CellPadding="6" 
		meta:resourcekey="dwCompaniesResource1">

		<Fields>
			<asp:BoundField DataField="name" HeaderText="Company Name" 
				SortExpression="name" meta:resourcekey="BoundFieldResource1" />
			<asp:CommandField ShowInsertButton="True" ShowCancelButton="False" 
				InsertText="Add" meta:resourcekey="CommandFieldResource2" />
		</Fields>
	</asp:DetailsView>
</div>

    <asp:SqlDataSource ID="sourceCompanies" runat="server" 
        ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
        DeleteCommand="DELETE FROM companies WHERE id = @id" 
        InsertCommand="INSERT INTO companies (name) VALUES (@name)" 
        ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM companies" 
        UpdateCommand="UPDATE companies SET name = @name WHERE id = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="id" Type="Int32" />
            <asp:Parameter Name="name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" Type="String" />
  
	          <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

