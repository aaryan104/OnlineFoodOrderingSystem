using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class addAgent : System.Web.UI.Page
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

        protected void signupButton_Click(object sender, EventArgs e)
        {

            String folderPath = "~/StoreImage/UserImage/";
            String fileName = Path.GetFileName(profilePhoto.FileName);
            String img = Path.Combine(folderPath, fileName);

            if (firstName.Text == string.Empty || lastName.Text == string.Empty || password.Text == string.Empty
                    || email.Text == string.Empty || phoneNumber.Text == string.Empty || vehicleNumber.Text == string.Empty
                    || status.Text == string.Empty || workingArea.SelectedValue == "-- Select area --" || profilePhoto == null)
            {
                msg.Text = "Please fill all fields.";
                msg.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                funcon();
                string qry = "INSERT INTO DeliveryAgents (FirstName, LastName, Email, PasswordHash, PhoneNumber, VehicleNumber, Status, Address, ImageURL) " +
                             "VALUES (@firstname, @lastname, @email, @password, @phone, @vehical, @status, @address, @image)";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@firstname", firstName.Text);
                cmd.Parameters.AddWithValue("@lastname", lastName.Text);
                cmd.Parameters.AddWithValue("@email", email.Text);
                cmd.Parameters.AddWithValue("@password", password.Text);
                cmd.Parameters.AddWithValue("@phone", phoneNumber.Text);
                cmd.Parameters.AddWithValue("@vehical", vehicleNumber.Text);
                cmd.Parameters.AddWithValue("@status", status.Text);
                cmd.Parameters.AddWithValue("@address", workingArea.SelectedValue);
                cmd.Parameters.AddWithValue("@image", img);

                int res = cmd.ExecuteNonQuery();

                profilePhoto.SaveAs(Server.MapPath(img));

                if (res > 0)
                {
                    Response.Redirect("~/FOS/DeliveryAgent/AgentLogin.aspx");
                }
                else
                {
                    msg.Text = "Account Not Created!";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
                conn.Close();
            }
        }
    }
}