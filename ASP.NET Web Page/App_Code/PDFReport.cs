using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using iTextSharp.text.html.simpleparser;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Net;
using System.Net.Mail;
using System.Drawing;
using System.Drawing.Imaging;

/// <summary>
/// Generating report and invoice PDFs, sending to customer
/// </summary>
public class PDFReport
{
	public PDFReport()
	{
		//
		// TODO: Add constructor logic here
		//
	}

	private static string GetReportLocation(string unique_code)
	{
		return HttpContext.Current.Server.MapPath("~/PDFs/" + unique_code + "_report.pdf");
	}

	private static string GetInvoiceImageLocation(string unique_code)
	{
		return HttpContext.Current.Server.MapPath("~/PDFs/" + unique_code + "_invoice.png");
	}

	private static string GetInvoiceLocation(string unique_code)
	{
		return HttpContext.Current.Server.MapPath("~/PDFs/" + unique_code + "_invoice.pdf");
	}

	public static bool SendEmail(string unique_code, string userEmail, string userNameAndSurname)
	{
		var fromAddress = new MailAddress("x@gmail.com", "PortMob Team");
		var toAddress = new MailAddress(userEmail, userNameAndSurname);
		string fromPassword = "x";
		string subject = "Order information";
		string body = "Hello " + userNameAndSurname + "!\n\nYour order id is: " + unique_code;

		Attachment attachReport, attachInvoice;
		attachReport = new Attachment(GetReportLocation(unique_code));
		attachInvoice = new Attachment(GetInvoiceLocation(unique_code));

		var smtp = new SmtpClient
							 {
									 Host = "smtp.gmail.com",
									 Port = 587,
									 EnableSsl = true,
									 DeliveryMethod = SmtpDeliveryMethod.Network,
									 UseDefaultCredentials = false,
									 Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
							 };
		using (var message = new MailMessage(fromAddress, toAddress)
												 {
														 Subject = subject,
														 Body = body
												 })
		{
				message.Attachments.Add(attachReport);
				message.Attachments.Add(attachInvoice);

				smtp.Send(message);
		}

		return true;
	}

	/*
	 * using iTextSharp open source library http://sourceforge.net/projects/itextsharp/
	 * and tuturial by http://www.4guysfromrolla.com/articles/030911-1.aspx
	 */
	public static bool MakeReportPDF(string unique_code, string totalPrice, string tableString)
	{
		if (string.IsNullOrEmpty(unique_code)) return false; // Error: bad arguments!

		// Create a Document object
		var document = new Document(PageSize.A4, 50, 50, 25, 25);

		// Create a new PdfWriter object, specifying the output stream
		var output = new FileStream(GetReportLocation(unique_code), FileMode.Create);
		var writer = PdfWriter.GetInstance(document, output);

		// Open the Document for writing
		document.Open();

		// Read in the contents of the Receipt.htm HTML template file
		string contents = File.ReadAllText(HttpContext.Current.Server.MapPath("~/Resources/order_report_template.html"));

		// Replace the placeholders with the user-specified text
		contents = contents.Replace("[ORDERID]", unique_code);
		contents = contents.Replace("[TOTALPRICE]", totalPrice); // Convert.ToDecimal(txtTotalPrice.Text).ToString("c"));
		contents = contents.Replace("[ORDERDATE]", DateTime.Now.ToShortDateString());
		contents = contents.Replace("[ITEMS]", tableString);

		var parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(contents), null);
		foreach (var htmlElement in parsedHtmlElements)
			document.Add(htmlElement as IElement);

		// Close the Document - this saves the document contents to the output stream
		document.Close();

		return true;
	}

	/*
	 * Make example invoice
	 */
	public static bool MakeInvoicePDF(string unique_code, string nameAndSurname, string amountOfMoney)
	{
		if (string.IsNullOrEmpty(unique_code)) return false; // Error: bad arguments!

		string invoiceImageLocation = GetInvoiceImageLocation(unique_code);
		string invoiceLocation = GetInvoiceLocation(unique_code);

		// get invoice image
		string invoiceResource = HttpContext.Current.Server.MapPath("~/Resources/uplatnica.png");
		Bitmap bmpInvoice = new Bitmap(invoiceResource);
		Graphics g = Graphics.FromImage(bmpInvoice);

		// draw data on invoice
		g.DrawString(nameAndSurname,
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 30, 68);
		g.DrawString("Narudzbina " + unique_code,
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 30, 138);
		g.DrawString("PortMob",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 30, 212);

		g.DrawString("189",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 320, 68);
		g.DrawString("RSD",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 380, 68);
		g.DrawString(amountOfMoney,
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 470, 68);

		g.DrawString("123-4567891011121-31",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 400, 115);
		g.DrawString("97",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 320, 159);
		g.DrawString("12-345678910111",
				new System.Drawing.Font("Tahoma", 12), Brushes.Black, 430, 159);

		// save invoice image to file
		bmpInvoice.Save(invoiceImageLocation, ImageFormat.Png);

		// free memory
		g.Dispose();
		bmpInvoice.Dispose();

		// insert image in PDF
				// Create a Document object
				var document = new Document(PageSize.A4, 50, 50, 25, 25);

				// Create a new PdfWriter object, specifying the output stream
				var output = new FileStream(invoiceLocation, FileMode.Create);
				var writer = PdfWriter.GetInstance(document, output);

				// Open the Document for writing
				document.Open();

				// You can add additional elements to the document. Let's add an image in the upper right corner
				var imgToPDF = iTextSharp.text.Image.GetInstance(invoiceImageLocation);
				// resize img to fit PDF
				int W = 596, H = 296;
				imgToPDF.ScaleAbsolute(W, H);
				imgToPDF.SetAbsolutePosition(0, 500);
				document.Add(imgToPDF);

				document.Close();

		// delete invoice image
		File.Delete(invoiceImageLocation);

		return true;
	}
}