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
    public partial class Register : System.Web.UI.Page
    {
        static string generatedOTP;
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

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

        protected void verifyEmail_Click(object sender, EventArgs e)
        {
            //Response.Write("Send Email Clicked!");
            string email = txtEmail.Text.Trim();

            if (!string.IsNullOrEmpty(email))
            {
                string script = "document.getElementById('verificationCodeSection').classList.remove('hidden');";
                ClientScript.RegisterStartupScript(this.GetType(), "showVerification", script, true);
                
                msg.Text = null;

                funcon();
                string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email=@checkEmail";
                cmd = new SqlCommand(checkEmailQuery, conn);
                cmd.Parameters.AddWithValue("@checkEmail", email);
                int emailExists = (int)cmd.ExecuteScalar();

                if (emailExists > 0)
                {
                    msg.Text = "This email is already in use. Please use a different email!";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    Random rnd = new Random();
                    generatedOTP = rnd.Next(100000, 999999).ToString();

                    if (SendOTP(email, generatedOTP))
                    {
                        msg.Text = "Check your email:- " + email;
                        msg.ForeColor = System.Drawing.Color.Green;

                        string disableEmailScript = @"
                            document.getElementById('" + txtEmail.ClientID + @"').readOnly = true;
                            document.getElementById('" + txtEmail.ClientID + @"').style.border = '2px solid green';
                        ";
                        ClientScript.RegisterStartupScript(this.GetType(), "disableEmail", disableEmailScript, true);

                        msg.Text = "OTP verified! Email locked.";
                        msg.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        msg.Text = "Failed to send OTP. Try again.";
                    }
                }
            }
            else
            {
                msg.Text = "Please enter your email first!";
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
                msg.Text = "Error: " + ex.Message;
                msg.ForeColor = System.Drawing.Color.Red;
                return false;
            }
        }

        protected void btnRegi_Click(object sender, EventArgs e)
        {
            //Response.Write("Create Account Clicked!");
            string enteredOTP = txtOtp.Text.Trim();
            string role = "Customer";

            if (enteredOTP == generatedOTP)
            {
                generatedOTP = null;

                if (txtfirstName.Text == string.Empty || txtlastName.Text == string.Empty || txtPassword.Text == string.Empty
                    || txtEmail.Text == string.Empty || txtMobile.Text == string.Empty || txtAddress.Text == string.Empty)
                {
                    msg.Text = "Please fill all fields.";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    funcon();
                    string qry = "INSERT INTO Users (FirstName, LastName, Email, PasswordHash, PhoneNumber, Role, Address) " +
                                 "VALUES (@firstname, @lastname, @email, @password, @phone, @role, @address)";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("@firstname", txtfirstName.Text);
                    cmd.Parameters.AddWithValue("@lastname", txtlastName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@phone", txtMobile.Text);
                    cmd.Parameters.AddWithValue("@role", role);
                    cmd.Parameters.AddWithValue("@address", txtAddress.Text);

                    int res = cmd.ExecuteNonQuery();
                    if (res > 0)
                    {
                        Response.Redirect("~/FOS/Login.aspx");
                    }
                    else
                    {
                        msg.Text = "Account Not Created!";
                        msg.ForeColor = System.Drawing.Color.Red;
                    }
                    conn.Close();
                }
            }
            else
            {
                msg.Text = "Invalid OTP. Try again.";
                msg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void txtOtp_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtfirstName.Text = string.Empty;
            txtlastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtOtp.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtAddress.Text = string.Empty;
        }
    }
}