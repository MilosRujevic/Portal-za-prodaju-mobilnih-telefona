<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Manage_Users.aspx.cs" Inherits="Administrator_Manage_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

<h2><asp:Label ID="lblH2ManageUsers" runat="server" Text="Manage Users"></asp:Label></h2>

	<asp:GridView ID="gvManageUsers" runat="server" DataSourceID="sourceMembership" AutoGenerateColumns="False" ShowFooter="true" CellPadding="6" Width="50%">
		<Columns>
						
			<asp:TemplateField HeaderText="Username / Email">
				<ItemTemplate>
					<asp:HyperLink ID="hlEmail" runat="server" NavigateUrl='<%# "~/Administrator/Manage_User.aspx?user=" + Eval("Email") %>'><%# Eval("Email") %></asp:HyperLink>
					<asp:Label ID="lblEmail" runat="server" Text=''></asp:Label>
				</ItemTemplate>
				<FooterTemplate>
					<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Administrator/Create_User.aspx">Create New User</asp:HyperLink>
				</FooterTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="Category">
				<ItemTemplate>
					<asp:Label ID="lblCategory" runat="server" Text='<%# UserProfile.GetCategory(Eval("Email").ToString()) %>'></asp:Label>
				</ItemTemplate>
			</asp:TemplateField>

			<asp:TemplateField HeaderText="Approved">
				<ItemTemplate>
					<asp:CheckBox ID="cbApproved" runat="server" Checked='<%# Eval("isApproved") %>' 
						AutoPostBack="true" OnCheckedChanged="cbApproved_OnCheckedChange"></asp:CheckBox>
				</ItemTemplate>
			</asp:TemplateField>

		</Columns>
	</asp:GridView>

	<asp:SqlDataSource ID="sourceMembership" runat="server" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT userId, Email, IsApproved FROM my_aspnet_membership">
	</asp:SqlDataSource>

</asp:Content>

