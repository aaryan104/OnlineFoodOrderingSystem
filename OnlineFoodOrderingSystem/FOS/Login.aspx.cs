using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS
{
    public partial class Login : System.Web.UI.Page
    {
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

        protected void btn_Click(object sender, EventArgs e)
        {
            String email = txtEmail.Text;
            String pass = txtPass.Text;

            if(email == string.Empty && pass == string.Empty)
            {
                lblMessage.Text = "Please Enter Email and Password!";
            }
            else/* if(email != string.Empty && pass != string.Empty)*/
            {
                if (email == "admin@gmail.com" && pass == "admin123")
                {
                    Response.Redirect("~/FOS/Admin/Dashboard.aspx");
                }
                else if(email == "delivery@gmail.com" && pass == "delivery123")
                {
                    Response.Redirect("~/FOS/DeliveryAgent/DeliveryDashboard.aspx");
                }
                else
                {
                    funcon();
                    string qry = "SELECT COUNT(*) FROM Users WHERE Email=@eml AND PasswordHash=@pwd";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("eml", email);
                    cmd.Parameters.AddWithValue("pwd", pass);

                    int cnt = Convert.ToInt32(cmd.ExecuteScalar() ?? 0);

                    if (cnt > 0)
                    {
                        Session["s_eml"] = txtEmail.Text;
                        Response.Redirect("~/FOS/Customer/Home.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Incorrect email-password!";
                    }
                    conn.Close();
                }
            }
            //else
            //{
            //    lblMessage.Text = "Incorrect email-password";
            //}
        }
    }
}