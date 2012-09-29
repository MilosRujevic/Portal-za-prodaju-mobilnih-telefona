<%@ Page Title="PortMob | Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
		<h2>
			<asp:Label ID="lblH3" runat="server" Text="Latest Mobile Devices" 
				meta:resourcekey="lblH3Resource1"></asp:Label>
    </h2>

	<asp:ListView ID="lvLatestDevices" runat="server" DataSourceID="sourceDevices">
		<ItemTemplate>
			<div class="newitem">
				<asp:HyperLink ID="HyperLink2" runat="server" 
					NavigateUrl='<%# "~/Device.aspx?id=" + Eval("id") %>'>
					<asp:Image ID="Image2" runat="server" Width="260" ImageUrl='<%# "~\\Pictures\\" + DB.FetchImage((int)Eval("id")) %>' />
				</asp:HyperLink>

				<br />
				<asp:HyperLink ID="linkToDevice" runat="server" 
					NavigateUrl='<%# "~/Device.aspx?id=" + Eval("id") %>' 
					Text='<%# DB.FetchCompanyName((int)Eval("company_id")) + " " + Eval("model_name") %>'></asp:HyperLink>
			</div>
		</ItemTemplate>
	</asp:ListView>

	<asp:SqlDataSource ID="sourceDevices" runat="server" 
			ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
			ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
			SelectCommand="SELECT * FROM mobile_devices ORDER BY id DESC LIMIT 12"></asp:SqlDataSource>
</asp:Content>
