using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS
{
    public partial class ResetPassword : System.Web.UI.Page
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            funcon();

            string newPassword = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string email = Session["UserEmail"] as string;

            if (string.IsNullOrEmpty(email))
            {
                lblMessage.Text = "Session expired. Try again.";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblMessage.Text = "Passwords do not match!";
                return;
            }

            try
            {
                string qry = "UPDATE Users SET PasswordHash = @Password WHERE Email = @Email";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@Password", newPassword);
                cmd.Parameters.AddWithValue("@Email", email);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    //lblMessage.Text =  "Password Reset Sucess!";
                    Response.Redirect("~/FOS/Login.aspx");
                }
                else
                {
                    lblMessage.Text = "Password reset failed. Try again.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                if (conn != null && conn.State == ConnectionState.Open)
                {
                    conn.Close();
                }
            }
        }

    }
}