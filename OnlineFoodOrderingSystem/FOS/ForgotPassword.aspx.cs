using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;  
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS
{
    public partial class FP : System.Web.UI.Page
    {
        static string generatedOTP;
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        public void funcon()
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
                conn = new SqlConnection(conStr);
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                    // Response.Write("connection success");
                }
                else
                {
                    Response.Write("not connect");

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            lblMessage.Text = null;
            msg.Text = null;

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Please enter your email.";
                return;
            }

            funcon();
            string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email=@checkEmail";
            cmd = new SqlCommand(checkEmailQuery, conn);
            cmd.Parameters.AddWithValue("@checkEmail", email);
            int emailExists = (int)cmd.ExecuteScalar();

            if (emailExists == 0)
            {
                msg.Text = "This Email Is Not Registered Yet!";
            }
            else
            {
                Random rnd = new Random();
                generatedOTP = rnd.Next(100000, 999999).ToString();

                if (SendOTP(email, generatedOTP))
                {
                    Session["OTP"] = generatedOTP;
                    Session["UserEmail"] = email;
                    Response.Redirect("VerifyOTP.aspx");
                }
                else
                {
                    lblMessage.Text = "Failed to send OTP. Try again.";
                }
            }
        }


        private bool SendOTP(string email, string otp)
        {
            try
            {
                string emailTemplate = $@"
                    <div style='font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2'>
                        <div style='margin:50px auto;width:70%;padding:20px 0'>
                            <div style='border-bottom:1px solid #eee'>
                                <a href='~/FOS/Index.aspx' style='font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600'>Kashtabhanjan</a>
                            </div>
                            <p style='font-size:1.1em'>Hi,</p>
                            <p>Thank you for choosing Kashtabhanjan. Use the following OTP to complete your Reset Password procedures. OTP is valid for 5 minutes only.</p>
                            <h2 style='background: #00466a;margin: 0 auto;width: max-content;padding: 0 10px;color: #fff;border-radius: 4px;'>{otp}</h2>
                            <p style='font-size:0.9em;'>Regards,<br />Kashtabhanjan</p>
                            <hr style='border:none;border-top:1px solid #eee' />
                            <div style='float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300'>
                                <p>Kashtabhanjan</p>
                                <p>107 Raghunandan, Ved Road, Katargam, surat</p>
                                <p>Gujarat</p>
                            </div>
                        </div>
                    </div>";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("kashtabhanjanfood@gmail.com");
                mail.To.Add(email);
                mail.Subject = "Password Reset OTP";
                mail.Body = emailTemplate;
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("kashtabhanjanfood@gmail.com", "kkyc oixf saeb serx");
                smtp.EnableSsl = true;
                smtp.Send(mail);

                return true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                return false;
            }
        }

    }
}