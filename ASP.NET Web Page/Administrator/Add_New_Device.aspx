<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Add_New_Device.aspx.cs" Inherits="Administrator_Manage_Devices" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    
	<h2>
		<asp:Label ID="lblH2AddNewDevice" runat="server" Text="Add New Mobile Device" 
			meta:resourcekey="lblH2AddNewDeviceResource1"></asp:Label>
	</h2>

	<asp:DetailsView ID="dvDevices" runat="server" Height="50px" 
      Width="50%"
			DataSourceID="sourceDevices"
			DefaultMode="Insert" AutoGenerateRows="False" CellPadding="6" 
			meta:resourcekey="dvDevicesResource1">
      <Fields>
					<asp:BoundField DataField="model_name" HeaderText="Model" 
						SortExpression="model_name" meta:resourcekey="BoundFieldResource1" />
					<asp:TemplateField HeaderText="Company" 
						meta:resourcekey="TemplateFieldResource1" > 
						<ItemTemplate><%# DB.FetchCompanyName(Eval("company_id").ToString())%></ItemTemplate>
						<InsertItemTemplate>
							<asp:DropDownList id="ddlCompanies" runat="server"
								DataSourceID="sourceCompanies"
								DataTextField="name"
								DataValueField="id" 
								SelectedValue='<%# Bind("company_id")%>' 
								meta:resourcekey="ddlCompaniesResource1">
							</asp:DropDownList>
						</InsertItemTemplate> 
					</asp:TemplateField>
					<asp:BoundField DataField="spec_shape" HeaderText="Shape" 
						SortExpression="spec_shape" meta:resourcekey="BoundFieldResource2" />
					<asp:BoundField DataField="spec_os" HeaderText="Operating System" 
						SortExpression="spec_os" meta:resourcekey="BoundFieldResource3" />
					<asp:BoundField DataField="spec_connectivity" HeaderText="Connectivity" 
						SortExpression="spec_connectivity" meta:resourcekey="BoundFieldResource4" />
					<asp:BoundField DataField="spec_display" HeaderText="Display Properties" 
						SortExpression="spec_display" meta:resourcekey="BoundFieldResource5" />
					<asp:BoundField DataField="spec_interface" HeaderText="Interface" 
						SortExpression="spec_interface" meta:resourcekey="BoundFieldResource6" />
					<asp:BoundField DataField="spec_camera" HeaderText="Camera" 
						SortExpression="spec_camera" meta:resourcekey="BoundFieldResource7" />
					<asp:BoundField DataField="spec_memory" HeaderText="Memory" 
						SortExpression="spec_memory" meta:resourcekey="BoundFieldResource8" />
					<asp:BoundField DataField="spec_battery" HeaderText="Battery" 
						SortExpression="spec_battery" meta:resourcekey="BoundFieldResource9" />
					<asp:BoundField DataField="available" HeaderText="Available" 
						SortExpression="available" meta:resourcekey="BoundFieldResource10" />
					<asp:BoundField DataField="price" HeaderText="Price" 
						SortExpression="price" meta:resourcekey="BoundFieldResource11" />
          <asp:CommandField ShowDeleteButton="False" ShowEditButton="False" 
						ShowInsertButton="True" ShowCancelButton="False" 
						meta:resourcekey="CommandFieldResource1" />
      </Fields>
  </asp:DetailsView>

	<asp:SqlDataSource ID="sourceCompanies" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM companies"> 
	</asp:SqlDataSource>

  <asp:SqlDataSource ID="sourceDevices" runat="server" 
      ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
      DeleteCommand="DELETE FROM mobile_devices WHERE id = @id" 
      InsertCommand="INSERT INTO mobile_devices (company_id, model_name, spec_shape, spec_os, spec_connectivity, spec_display, spec_interface, spec_camera, spec_memory, spec_battery, available, price) VALUES (@company_id, @model_name, @spec_shape, @spec_os, @spec_connectivity, @spec_display, @spec_interface, @spec_camera, @spec_memory, @spec_battery, @available, @price)" 
      ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
      SelectCommand="SELECT * FROM mobile_devices" 
      UpdateCommand="UPDATE mobile_devices SET company_id = @company_id, model_name = @model_name, spec_shape = @spec_shape, spec_os = @spec_os, spec_connectivity = @spec_connectivity, spec_display = @spec_display, spec_interface = @spec_interface, spec_camera = @spec_camera, spec_memory = @spec_memory, spec_battery = @spec_battery, available = @available, price = @price WHERE id = @id">
      <DeleteParameters>
          <asp:Parameter Name="id" Type="Int32" />
      </DeleteParameters>
      <InsertParameters>
          <asp:Parameter Name="id" Type="Int32" />
          <asp:Parameter Name="company_id" Type="Int32" />
          <asp:Parameter Name="model_name" Type="String" />
          <asp:Parameter Name="spec_shape" Type="String" />
          <asp:Parameter Name="spec_os" Type="String" />
          <asp:Parameter Name="spec_connectivity" Type="String" />
          <asp:Parameter Name="spec_display" Type="String" />
          <asp:Parameter Name="spec_interface" Type="String" />
          <asp:Parameter Name="spec_camera" Type="String" />
          <asp:Parameter Name="spec_memory" Type="String" />
          <asp:Parameter Name="spec_battery" Type="String" />
          <asp:Parameter Name="available" Type="Int32" />
					<asp:Parameter Name="price" Type="Double" />
      </InsertParameters>
      <UpdateParameters>
					<asp:Parameter Name="id" Type="Int32" />
          <asp:Parameter Name="company_id" Type="Int32" />
          <asp:Parameter Name="model_name" Type="String" />
          <asp:Parameter Name="spec_shape" Type="String" />
          <asp:Parameter Name="spec_os" Type="String" />
          <asp:Parameter Name="spec_connectivity" Type="String" />
          <asp:Parameter Name="spec_display" Type="String" />
          <asp:Parameter Name="spec_interface" Type="String" />
          <asp:Parameter Name="spec_camera" Type="String" />
          <asp:Parameter Name="spec_memory" Type="String" />
          <asp:Parameter Name="spec_battery" Type="String" />
          <asp:Parameter Name="available" Type="Int32" />
					<asp:Parameter Name="price" Type="Double" />
      </UpdateParameters>
  </asp:SqlDataSource>

</asp:Content>

