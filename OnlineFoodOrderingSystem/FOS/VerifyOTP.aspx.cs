using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS
{
    public partial class VerifyOTP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            fetchEmail();
        }

        public void fetchEmail()
        {
            string email = Session["UserEmail"] as string;

            userEmail.Text = email;
        }

        protected void btnVerify_Click1(object sender, EventArgs e)
        {
            OTPverify();
        }

        protected void resendBtn_Click(object sender, EventArgs e)
        {
            OTPverify();
        }

        public void OTPverify()
        {
            string enteredOTP = input1.Text.Trim() + input2.Text.Trim() + input3.Text.Trim() + input4.Text.Trim() + input5.Text.Trim() + input6.Text.Trim();

            string sessionOTP = Session["OTP"] as string;

            if (enteredOTP == sessionOTP)
            {
                Session["OTP"] = null;
                Response.Redirect("ResetPassword.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid OTP. Try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}