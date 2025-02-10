using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Click(object sender, EventArgs e)
        {
            String role = txtRole.Text;
            String email = username.Text;
            String pass = password.Text;

            if(email == string.Empty && pass == string.Empty)
            {
                lblMessage.Text = "Please Enter Email and Password!";
            }
            else if(role == "Restaurant")
            {
                if (email == "admin@gmail.com" && pass == "admin123")
                {
                    Response.Redirect("~/FOS/Admin/Home.aspx");
                }
                else
                {
                    lblMessage.Text = "Incorrect email or password!";
                }
            }
            else if(role == "Customer")
            {
                if(email == "shivam@gmail.com" && pass == "shivam123")
                {
                    Response.Redirect("~/FOS/Customer/Dashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Incorrect email or password!";
                }
            }
            else if(role == "Delivery")
            {
                if(email == "delivery@gmail.com" && pass == "delivery123")
                {
                    Response.Redirect("~/FOS/DeliveryAgent/Agent.aspx");
                }
                else
                {
                    lblMessage.Text = "Incorrect email or password!";
                }
            }
        }
    }
}