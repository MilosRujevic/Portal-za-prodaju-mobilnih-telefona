<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Shopping_Cart.aspx.cs" Inherits="User_Shopping_Cart" culture="auto" meta:resourcekey="PageResource1" uiculture="auto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	<h2><asp:Label ID="lblH2ShoppingCart" runat="server" Text="Shopping Cart" 
			meta:resourcekey="lblH2ShoppingCartResource1"></asp:Label></h2>

	<asp:Wizard ID="OrderWizard" runat="server" ActiveStepIndex="0" 
		onfinishbuttonclick="OrderWizard_FinishButtonClick" Width="60%" 
		meta:resourcekey="OrderWizardResource1">
		<WizardSteps>
			<asp:WizardStep ID="WizardStep1" runat="server" Title="Manage Orders" 
				meta:resourcekey="WizardStep1Resource1">
					<asp:GridView ID="gvShoppingCart" runat="server" 
						DataSourceID="sourceShoppingCart" AutoGenerateColumns="False" ShowFooter="True" 
						CellPadding="6" Width="100%" meta:resourcekey="gvShoppingCartResource1">
						<Columns>
							<asp:TemplateField HeaderText="Device" 
								meta:resourcekey="TemplateFieldResource1">
								<ItemTemplate><%# DB.FetchDeviceName(Eval("mobile_device_id").ToString())%></ItemTemplate>
							</asp:TemplateField>

							<asp:TemplateField HeaderText="Amount" 
								meta:resourcekey="TemplateFieldResource2">
								<ItemTemplate><%# Eval("amount") %></ItemTemplate>
							</asp:TemplateField>

							<asp:TemplateField HeaderText="USD" FooterText="Sum" 
								meta:resourcekey="TemplateFieldResource3">
								<ItemTemplate>
									<%# FetchPrice((int)Eval("mobile_device_id"), (int)Eval("amount")) %>
								</ItemTemplate>
								<FooterTemplate>
									<%# priceOfAll %>
								</FooterTemplate>
							</asp:TemplateField>

							<asp:TemplateField HeaderText="Remove" 
								meta:resourcekey="TemplateFieldResource4">
								<ItemTemplate>
									<asp:Button ID="btnRemove" runat="server" Text="Remove" 
										CommandArgument='<%# Eval("id") %>' CommandName="idToDel" 
										OnClick="btnRemove_Click" meta:resourcekey="btnRemoveResource1" />
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>

					</asp:GridView>
			</asp:WizardStep>


			<asp:WizardStep ID="WizardStep2" runat="server" Title="Confirm Orders" 
				meta:resourcekey="WizardStep2Resource1">
				<asp:GridView ID="GridView1" runat="server" 
						DataSourceID="sourceShoppingCart" AutoGenerateColumns="False" ShowFooter="True" 
					CellPadding="6" Width="100%" meta:resourcekey="GridView1Resource1">
						<Columns>
							<asp:TemplateField HeaderText="Device" 
								meta:resourcekey="TemplateFieldResource5">
								<ItemTemplate><%# DB.FetchDeviceName(Eval("mobile_device_id").ToString())%></ItemTemplate>
							</asp:TemplateField>

							<asp:TemplateField HeaderText="Amount" 
								meta:resourcekey="TemplateFieldResource6">
								<ItemTemplate><%# Eval("amount") %></ItemTemplate>
							</asp:TemplateField>

							<asp:TemplateField HeaderText="USD" FooterText="Sum" 
								meta:resourcekey="TemplateFieldResource7">
								<ItemTemplate>
									<%# FetchPrice((int)Eval("mobile_device_id"), (int)Eval("amount")) %>
								</ItemTemplate>
								<FooterTemplate>
									<%# priceOfAll %>
								</FooterTemplate>
							</asp:TemplateField>

						</Columns>

					</asp:GridView>
			</asp:WizardStep>
		</WizardSteps>
	</asp:Wizard>

	<h3>
		<asp:Label ID="lblCartEmpty" runat="server" Text="Shopping cart is empty!" Visible="false" />
	</h3>

	<asp:SqlDataSource ID="sourceShoppingCart" runat="server" 
		ConflictDetection="CompareAllValues" 
		ConnectionString="<%$ ConnectionStrings:mysqlConnectionString %>" 
		DeleteCommand="DELETE FROM carts WHERE id = @id" 
		OldValuesParameterFormatString="original_{0}" 
		ProviderName="<%$ ConnectionStrings:mysqlConnectionString.ProviderName %>" 
		SelectCommand="SELECT * FROM carts" >
		<DeleteParameters>
			<asp:Parameter Name="original_id" Type="Int32" />
			<asp:Parameter Name="original_mobile_device_id" Type="Int32" />
			<asp:Parameter Name="original_user_id" Type="Int32" />
			<asp:Parameter Name="original_amount" Type="Int32" />
		</DeleteParameters>
	</asp:SqlDataSource>
</asp:Content>

