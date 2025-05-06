using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;
using System.Configuration;
using System.Data.SqlClient;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class SuccessOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_eml"] == null)
            {
                Response.Redirect("~/FOS/Login.aspx");
                return;
            }
            else
            {
                lblOrderid.Text = Session["OrderId"].ToString();
                lblDate.Text = Convert.ToDateTime(Session["OrderDate"]).ToString("MMMM dd, yyyy");
                lblEstimate.Text = "20-25 minutes";
                lblAmount.Text = "₹" + Convert.ToDecimal(Session["TotalAmount"]).ToString("F2");

                SendOrderEmail();
            }
        }

        private void SendOrderEmail()
        {
            try
            {
                string userEmail = Session["s_eml"].ToString();
                string orderId = Session["OrderId"].ToString();
                string date = DateTime.Now.ToString();
                string paymentMethod = Session["PaymentMethod"].ToString();
                string address = Session["address"].ToString();
                decimal subtotal = Convert.ToDecimal(Session["subTotal"]);

                decimal deliveryFee = 20;
                decimal tax = subtotal * 0.05m;
                decimal total = subtotal + deliveryFee + tax;

                string emailTemplate = $@"
                    <h1 class=""text-3xl font-bold text-gray-800 mb-2"">
                        Order Confirmed!
                    </h1>
                    <p class=""text-gray-600 text-center"">
                        Thank you for your purchase! Your order has been received and is
                        being processed.
                    </p>
                    <h2 class=""text-xl font-semibold text-gray-800 mb-4"">
                        Order Summary
                    </h2>
                    <p class=""text-gray-600 mb-2"">
                        Order Number:
                        <span class=""font-medium text-gray-800"">
                            {orderId}
                        </span>
                    </p>
                    <p class=""text-gray-600 mb-2"">
                        Date:
                        <span class=""font-medium text-gray-800"">
                            {date}
                        </span>
                    </p>
                    <p class=""text-gray-600 mb-2"">
                        Payment Method:
                        <span class=""font-medium text-gray-800"">
                            {paymentMethod}
                        </span>
                    </p>
                    <p class=""text-gray-600 mb-2"">Shipping Address:</p>
                    <p class=""font-medium text-gray-800"">{address}</p>
                                                    
                    <span class=""text-gray-600"">Subtotal:</span>
                    <span class=""font-medium text-gray-800"">₹{subtotal}</span>
                                               <br><br>
                    <span class=""text-gray-600"">Shipping:</span>
                    <span class=""font-medium text-gray-800"">₹{deliveryFee}</span>
                                               <br><br>
                    <span class=""text-gray-600"">Tax:</span>
                    <span class=""font-medium text-gray-800"">₹{tax}</span>
                                                <br><br>
                    <span class=""text-gray-800 font-semibold"">Total:</span>
                    <span class=""font-bold text-gray-800"">₹{total}</span>   
                ";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("kashtabhanjanfood@gmail.com");
                mail.To.Add(userEmail);
                mail.Subject = "Your Order Confirmation";
                mail.Body = emailTemplate;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("kashtabhanjanfood@gmail.com", "kkyc oixf saeb serx");
                smtp.EnableSsl = true;
                smtp.Send(mail);

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Failed to send email: " + ex.Message + "');</script>");
            }
        }
    }
}