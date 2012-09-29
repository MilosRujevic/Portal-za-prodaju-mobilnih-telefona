<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Device.aspx.cs" Inherits="Device" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	
	<h2>
		<asp:Label ID="lblH2DeviceName" runat="server"></asp:Label>
	</h2>

	<div class="deviceinfo">
		<div class="deviceimage" style="color: #fff">
			<asp:DetailsView ID="dvPictures" runat="server" Height="50px" Width="125px"
				DataSourceID="sourcePictures" AutoGenerateRows="False" AllowPaging="True" 
				GridLines="None" BorderWidth="0px">
				<Fields>
					<asp:BoundField DataField="id" InsertVisible="False" SortExpression="id" />
					<asp:BoundField DataField="mobile_device_id" HeaderText="mobile_device_id" 
							ReadOnly="true" SortExpression="mobile_device_id" Visible="False" />
					<asp:ImageField DataImageUrlField="picture"
							DataImageUrlFormatString="~\Pictures\{0}">
					</asp:ImageField>
					<asp:CommandField ShowEditButton="False" ShowInsertButton="False" />
				</Fields>
			</asp:DetailsView>
		</div>

	<asp:SqlDataSource ID="sourcePictures" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>"
		DeleteCommand="DELETE FROM pictures WHERE [id] = @id"
		InsertCommand="INSERT INTO pictures (mobile_device_id, picture) VALUES (@DeviceID, @picture)"
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>"
		SelectCommand="SELECT * FROM pictures WHERE mobile_device_id = @DeviceID"
		UpdateCommand="UPDATE pictures SET picture = @picture WHERE id = @id">
		<SelectParameters>  
				<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
		</SelectParameters>  
		<DeleteParameters>
			<asp:Parameter Name="id" Type="Int32" />
		</DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="mobile_device_id" Type="Int32" />
			<asp:Parameter Name="picture" Type="String" />
			<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="mobile_device_id" Type="Int32" />
			<asp:Parameter Name="picture" Type="String" />
		</UpdateParameters>
	</asp:SqlDataSource>

		<div class="devicespecs">
			<asp:DetailsView ID="dvDevices" runat="server" 
					Height="50px" Width="410px"
					DataSourceID="sourceDevices" AutoGenerateRows="False" BorderWidth="0px" 
					BorderStyle="None" GridLines="None" CellSpacing="4"
					OnItemDeleted="dvDevices_ItemDeleted">
					<Fields>
							<asp:CommandField ShowDeleteButton="False" ShowEditButton="False" 
								ShowInsertButton="False" ShowCancelButton="False" />
							<asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
								 SortExpression="id" Visible="False" />
							<asp:BoundField DataField="model_name" HeaderText="Model" 
								SortExpression="model_name" />
							<asp:TemplateField HeaderText="Company" > 
								<ItemTemplate><%# DB.FetchCompanyName(Eval("company_id").ToString())%></ItemTemplate>
								<InsertItemTemplate>
									<asp:DropDownList id="ddlCompanies" runat="server"
										DataSourceID="sourceCompanies"
										DataTextField="name"
										DataValueField="id"
										SelectedValue='<%# Bind("company_id")%>'>
									</asp:DropDownList>
								</InsertItemTemplate>
								<EditItemTemplate>
									<asp:DropDownList id="ddlCompanies" runat="server"
										DataSourceID="sourceCompanies"
										DataTextField="name"
										DataValueField="id"
										SelectedValue='<%# Bind("company_id")%>'>
									</asp:DropDownList>
								</EditItemTemplate> 
							</asp:TemplateField>
							<asp:BoundField DataField="spec_shape" HeaderText="Shape" 
								SortExpression="spec_shape" />
							<asp:BoundField DataField="spec_os" HeaderText="Operating System" 
								SortExpression="spec_os" />
							<asp:BoundField DataField="spec_connectivity" HeaderText="Connectivity" 
								SortExpression="spec_connectivity" />
							<asp:BoundField DataField="spec_display" HeaderText="Display Properties" 
								SortExpression="spec_display" />
							<asp:BoundField DataField="spec_interface" HeaderText="Interface" 
								SortExpression="spec_interface" />
							<asp:BoundField DataField="spec_camera" HeaderText="Camera" 
								SortExpression="spec_camera" />
							<asp:BoundField DataField="spec_memory" HeaderText="Memory" 
								SortExpression="spec_memory" />
							<asp:BoundField DataField="spec_battery" HeaderText="Battery" 
								SortExpression="spec_battery" />
							<asp:BoundField DataField="available" HeaderText="Available" 
								SortExpression="available" />
      				<asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" />
					</Fields>
			</asp:DetailsView>
		</div>
	</div>

	<asp:SqlDataSource ID="sourceCompanies" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM companies"> 
	</asp:SqlDataSource>

  <asp:SqlDataSource ID="sourceDevices" runat="server" 
      ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
      DeleteCommand="DELETE FROM mobile_devices WHERE id = @DeviceID" 
      InsertCommand="INSERT INTO mobile_devices (company_id, model_name, spec_shape, spec_os, spec_connectivity, spec_display, spec_interface, spec_camera spec_memory, spec_battery, available, price) VALUES (@company_id, @model_name, @spec_shape, @spec_os, @spec_connectivity, @spec_display, @spec_interface, @spec_camera @spec_memory, @spec_battery, @available, @price)" 
      ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
      SelectCommand="SELECT * FROM mobile_devices WHERE id=@DeviceID" 
      UpdateCommand="UPDATE mobile_devices SET company_id = @company_id, model_name = @model_name, spec_shape = @spec_shape, spec_os = @spec_os, spec_connectivity = @spec_connectivity, spec_display = @spec_display, spec_interface = @spec_interface, spec_camera = @spec_camera, spec_memory = @spec_memory, spec_battery = @spec_battery, available = @available, price = @price WHERE id = @DeviceID">
			<SelectParameters>  
				<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
		  </SelectParameters>
      <DeleteParameters>
          <asp:Parameter Name="id" Type="Int32" />
					<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
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
					<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
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
					<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
      </UpdateParameters>
  </asp:SqlDataSource>


<div class="addToCart">
	<h2>
		<asp:Label ID="lblH2AddToCart" runat="server" Text="Add to Cart" Visible="false"></asp:Label>
	</h2>
<!-- add to cart -->
	<asp:Label ID="lblAmount" runat="server" Text="Amount:" Visible="False"></asp:Label>
	<asp:DropDownList ID="ddlAmount" runat="server" Visible="False">
		<asp:ListItem Selected="True">1</asp:ListItem>
		<asp:ListItem>2</asp:ListItem>
		<asp:ListItem>3</asp:ListItem>
		<asp:ListItem>4</asp:ListItem>
		<asp:ListItem>5</asp:ListItem>
	</asp:DropDownList>
	
	<asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" Visible="false" />
	<asp:Label ID="lblAddToCartResult" runat="server" />
</div>
<!-- /add to cart -->

<div class="comments">
	<h2>
		<asp:Label ID="lblH2Comments" runat="server" Text="Comments"></asp:Label>
	</h2>

	<asp:GridView ID="gvComments" runat="server" DataSourceID="sourceComments" 
		AutoGenerateColumns="False" AllowPaging="True" CellSpacing="5" 
		BorderStyle="None" Width="100%">
		<Columns>
			<asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
				 SortExpression="id" Visible="False" />
			<asp:BoundField DataField="mobile_device_id" HeaderText="mobile_device_id" 
				 SortExpression="mobile_device_id" Visible="False" />
			<asp:BoundField DataField="nickname" HeaderText="Nickname" 
				SortExpression="nickname" />
			<asp:BoundField DataField="pros" HeaderText="Pros" SortExpression="pros" />
			<asp:BoundField DataField="cons" HeaderText="Cons" SortExpression="cons" />
		</Columns>
	</asp:GridView>
</div>

	<asp:SqlDataSource ID="sourceComments" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		DeleteCommand="DELETE FROM comments WHERE id = @id" 
		InsertCommand="INSERT INTO comments (pros, cons, nickname, mobile_device_id) VALUES (@pros, @cons, @nickname, @DeviceID)" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM comments WHERE mobile_device_id=@DeviceID" 
		UpdateCommand="UPDATE comments SET pros = @pros, cons = @cons, nickname = @nickname, mobile_device_id = @mobile_device_id WHERE id = @id">
		<SelectParameters>
			<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
		</SelectParameters>
		<DeleteParameters>
			<asp:Parameter Name="id" Type="Int32" />
		</DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="id" Type="Int32" />
			<asp:Parameter Name="pros" Type="String" />
			<asp:Parameter Name="cons" Type="String" />
			<asp:Parameter Name="nickname" Type="String" />
			<asp:Parameter Name="mobile_device_id" Type="Int32" />
			<asp:QueryStringParameter Name="DeviceID" QueryStringField="id" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="pros" Type="String" />
			<asp:Parameter Name="cons" Type="String" />
			<asp:Parameter Name="nickname" Type="String" />
			<asp:Parameter Name="mobile_device_id" Type="Int32" />
			<asp:Parameter Name="id" Type="Int32" />
		</UpdateParameters>
	</asp:SqlDataSource>

<!-- commenting -->
	<div class="postComment">
		<h2>
			<asp:Label ID="lblPostComment" runat="server" Text="Post Comment"></asp:Label>
		</h2>

		<table>
			<tr>
				<td><asp:Label ID="lblNickname" runat="server" Text="Nickname"></asp:Label></td>
				<td><asp:TextBox ID="txtNickname" runat="server" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblPros" runat="server" Text="Pros"></asp:Label></td>
				<td><asp:TextBox ID="txtPros" runat="server" Rows="4" TextMode="MultiLine" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblCons" runat="server" Text="Cons"></asp:Label></td>
				<td><asp:TextBox ID="txtCons" runat="server" Rows="4" TextMode="MultiLine" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Button ID="btnPostComment" runat="server" text="Post Comment" OnClick="btnPostComment_Click" />
				<td>
			</tr>
		</table>
	
		<asp:Label ID="lblPostCommentResult" runat="server" />
	</div>
<!-- /commenting -->

</asp:Content>

