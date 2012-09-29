<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Search" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

	<div class="fleft50">
		<h2>
			<asp:Label ID="lblSearch" runat="server" Text="Search" 
				meta:resourcekey="lblSearchResource1"></asp:Label>
		</h2>

		<table>
			<tr>
				<td><asp:Label ID="lblCompany" runat="server" Text="Company" 
						meta:resourcekey="lblCompanyResource1"></asp:Label></td>
				<td><asp:TextBox ID="txtCompany" runat="server" 
						meta:resourcekey="txtCompanyResource1" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblModel" runat="server" Text="Model" 
						meta:resourcekey="lblModelResource1"></asp:Label></td>
				<td><asp:TextBox ID="txtModel" runat="server" 
						meta:resourcekey="txtModelResource1" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblOs" runat="server" Text="Operating System" 
						meta:resourcekey="lblOsResource1"></asp:Label></td>
				<td><asp:TextBox ID="txtOs" runat="server" meta:resourcekey="txtOsResource1" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblPrice" runat="server" Text="Price" 
						meta:resourcekey="lblPriceResource1"></asp:Label></td>
				<td><asp:TextBox ID="txtPrice" runat="server" 
						meta:resourcekey="txtPriceResource1" /></td>
			</tr>
			<tr>
				<td><asp:Label ID="lblMinMax" runat="server" Text="Maximum or mimimum price" 
						meta:resourcekey="lblMinMaxResource1"></asp:Label></td>
				<td>
					<asp:DropDownList ID="ddlMinMax" runat="server" 
						meta:resourcekey="ddlMinMaxResource1">
						<asp:ListItem Selected="True" Text="Maximum" Value="max" 
							meta:resourcekey="ListItemResource1"></asp:ListItem>
						<asp:ListItem Selected="False" Text="Minumum" Value="min" 
							meta:resourcekey="ListItemResource2"></asp:ListItem>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<asp:Button ID="btnSearch" runat="server" text="Search" 
						onclick="btnSearch_Click1" meta:resourcekey="btnSearchResource1" />
				<td>
			</tr>
		</table>
	</div>

	<div class="fleft50">
		<h3>
			<asp:Label ID="lblSearchResults" runat="server" Text="Search Results" 
				Visible="False" meta:resourcekey="lblSearchResultsResource1"></asp:Label>
		</h3>
		
		<asp:Table ID="tblResults" runat="server" class="searchResults" 
			meta:resourcekey="tblResultsResource1" BorderStyle="Solid" BorderWidth="1px" 
			BorderColor="#BBBBBB" CellSpacing="5" CellPadding="5" Visible="False">
			<asp:TableHeaderRow runat="server" meta:resourcekey="TableHeaderRowResource1">
				<asp:TableCell ID="TableCell1" runat="server" Text="Model" 
					meta:resourcekey="TableCell1Resource1"></asp:TableCell>
				<asp:TableCell ID="TableCell2" runat="server" Text="Company" 
					meta:resourcekey="TableCell2Resource1"></asp:TableCell>
				<asp:TableCell ID="TableCell3" runat="server" Text="OS" 
					meta:resourcekey="TableCell3Resource1"></asp:TableCell>
				<asp:TableCell ID="TableCell4" runat="server" Text="Price" 
					meta:resourcekey="TableCell4Resource1"></asp:TableCell>
			</asp:TableHeaderRow>
		</asp:Table>
	</div>

</asp:Content>

