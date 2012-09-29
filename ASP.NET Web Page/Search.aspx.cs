using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Search : System.Web.UI.Page
{
		private string company;
		private string model;
		private string os;
		private string price;
		private string minmax;
		private int searchStart;
		private int searchSize;
		

    protected void Page_Load(object sender, EventArgs e)
    {
			if (Request.QueryString["m"] == null)
			{
				searchStart = 0;
			}
			else
			{
				searchStart = Convert.ToInt32(Request.QueryString["m"]);
				btnSearch_Click1(sender, e);
			}
    }

		protected void btnSearch_Click1(object sender, EventArgs e)
		{
			SearchService searchService = new SearchService();

			company = txtCompany.Text;
			model = txtModel.Text;
			os = txtOs.Text;
			price = txtPrice.Text;
			minmax = ddlMinMax.SelectedValue;			

			searchSize = Profile.SearchSize;
			if (searchSize <= 0) searchSize = 10;
			List<SoapDevice> devicesList = searchService.Search(company, model, os, price, minmax, searchStart, searchSize);

			lblSearchResults.Visible = true;
			
			foreach (var device in devicesList)
			{
				TableRow tr = new TableRow();
				TableCell tdLink = new TableCell();
				TableCell tdCompany = new TableCell();
				TableCell tdOs = new TableCell();
				TableCell tdPrice = new TableCell();

				// model row
				HyperLink link = new HyperLink();
				link.NavigateUrl = "~/Device.aspx?id=" + device.Id.ToString();
				link.Text = device.Name;

				tdLink.Controls.Add(link);
				tr.Cells.Add(tdLink);

				// company row
				Label lblCompany = new Label();
				lblCompany.Text = device.Company;
				tdCompany.Controls.Add(lblCompany);
				tr.Cells.Add(tdCompany);

				// operating system row
				Label lblOs = new Label();
				lblOs.Text = device.SpecOs;
				tdOs.Controls.Add(lblOs);
				tr.Cells.Add(tdOs);

				// price row
				Label lblPrice = new Label();
				lblPrice.Text = device.Price.ToString();
				tdPrice.Controls.Add(lblPrice);
				tr.Cells.Add(tdPrice);

				tblResults.Rows.Add(tr);
			}

			if (searchStart > 0)
			{
				// prev
				int searchStartPrev = searchStart - searchSize;

				TableRow trPrev = new TableRow();
				TableCell tdPrev = new TableCell();

				HyperLink linkPrev = new HyperLink();
				linkPrev.ID = "btnPrev";
				linkPrev.Text = "<<<";
				linkPrev.NavigateUrl = "~/Search.aspx?m=" + searchStartPrev;
				tdPrev.Controls.Add(linkPrev);
				trPrev.Cells.Add(tdPrev);
				tblResults.Rows.Add(trPrev);
			}

			if (searchService.Search(company, model, os, price, minmax, searchStart + searchSize, searchSize).Count() > 0)
			{
				// next?
				searchStart += searchSize;
				
				TableRow trNext = new TableRow();
				TableCell tdNext = new TableCell();
				
				HyperLink linkNext = new HyperLink();
				linkNext.ID = "btnNext";
				linkNext.Text = ">>>";
				linkNext.NavigateUrl = "~/Search.aspx?m=" + searchStart;
				tdNext.Controls.Add(linkNext);
				trNext.Cells.Add(tdNext);
				tblResults.Rows.Add(trNext);
			}

			tblResults.Visible = true;
		}

		/*
		protected void btnNext_Click(object sender, EventArgs e)
		{
			searchStart += searchSize;
			btnSearch_Click1(sender, e);
		}
		 */

		protected override void InitializeCulture()
		{
			if (Profile.Language == 2)
			{
				System.Globalization.CultureInfo culture = new System.Globalization.CultureInfo("sr-Latn-RS");
				System.Threading.Thread.CurrentThread.CurrentUICulture = culture;
				System.Threading.Thread.CurrentThread.CurrentCulture = culture;
			}

			base.InitializeCulture();
		}
}