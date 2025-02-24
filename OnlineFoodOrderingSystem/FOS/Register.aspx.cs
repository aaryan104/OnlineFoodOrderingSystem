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
    public partial class Register : System.Web.UI.Page
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

        protected void btnSignin_Click(object sender, EventArgs e)
        {
            string role = "Customer";
            try
            {
                funcon();
                string checkEmailQuery = "SELECT COUNT(*) FROM Users WHERE Email=@checkEmail";
                cmd = new SqlCommand(checkEmailQuery, conn);
                cmd.Parameters.AddWithValue("@checkEmail", txtEmail.Text);
                int emailExists = (int)cmd.ExecuteScalar();

                if (emailExists > 0)
                {
                    msg.Text = "This email is already in use. Please use a different email!";
                }
                else if (txtfirstName.Text == string.Empty || txtlastName.Text == string.Empty || txtPassword.Text == string.Empty
                    || txtEmail.Text == string.Empty || txtMobile.Text == string.Empty || txtAddress.Text == string.Empty)
                {
                    msg.Text = "Please fill all fields.";
                }
                else
                {
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
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }
    }
}