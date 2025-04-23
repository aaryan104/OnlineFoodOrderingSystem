using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class AgentLogin : System.Web.UI.Page
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

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Response.Write("Login BTN clickes!");
            String email = txtEmail.Text;
            String pass = txtPass.Text;

            if (email == string.Empty && pass == string.Empty)
            {
                lblMessage.Text = "Please Enter Email and Password!";
            }
            else
            {
                funcon();

                string qry = "SELECT DeliveryAgentId FROM DeliveryAgents WHERE Email=@eml AND PasswordHash=@pwd";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("eml", email);
                cmd.Parameters.AddWithValue("pwd", pass);

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    Session["DeliveryAgentId"] = result.ToString();
                    Response.Redirect("~/FOS/DeliveryAgent/DeliveryAgentDashboard.aspx");
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                }
                conn.Close();
            }
        }
    }
}