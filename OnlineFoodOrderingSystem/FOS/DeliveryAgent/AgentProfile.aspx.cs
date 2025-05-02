using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class AgentProfile : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DeliveryAgentId"] != null)
                {
                    LoadDeliveryAgentProfile();
                    LoadDeliveryAgentInformation();
                    LoademployeeInformation();
                    EditDeliveryAgentProfile();
                }
                else
                {
                    Response.Redirect("AgentLogin.aspx");
                }
            }
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

        private void LoadDeliveryAgentProfile()
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);

            funcon();
            string query = "SELECT * FROM DeliveryAgents WHERE DeliveryAgentId = @AgentId";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                string firstName = reader["FirstName"].ToString();
                string lastName = reader["LastName"].ToString();

                lblName.Text = firstName + " " + lastName;
                lblEmail.Text = reader["Email"].ToString();
                lblPhone.Text = "+91 " + reader["PhoneNumber"].ToString();
                lblAddress.Text = reader["Address"].ToString();
                lblID.Text = reader["DeliveryAgentId"].ToString();
                lblStatus.Text = reader["Status"].ToString();
                lblVehicle.Text = reader["VehicleNumber"].ToString();

                string imagePath = reader["ImageURL"].ToString();
                if (!string.IsNullOrEmpty(imagePath))
                {
                    imgProfile.ImageUrl = imagePath;
                }
                else
                {
                    imgProfile.ImageUrl = "../Asset/Library/img/Default_Photo.jpg";
                }
            }
        }
        private void LoadDeliveryAgentInformation()
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);

            funcon();
            string query1 = "SELECT * FROM DeliveryAgents WHERE DeliveryAgentId = @AgentId";
            cmd = new SqlCommand(query1, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                string firstName = reader["FirstName"].ToString();
                string lastName = reader["LastName"].ToString();

                lblFullname.Text = firstName + " " + lastName;
                lblMail.Text = reader["Email"].ToString();
                lblPhonenumber.Text = "+91 " + reader["PhoneNumber"].ToString();
                lblAdd.Text = reader["Address"].ToString();
            }
        }

        private void LoademployeeInformation()
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);

            funcon();
            string query1 = "SELECT * FROM DeliveryAgents WHERE DeliveryAgentId = @AgentId";
            cmd = new SqlCommand(query1, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblAddres.Text = reader["Address"].ToString();
                lblIds.Text = reader["DeliveryAgentId"].ToString();
            }
        }

        private void EditDeliveryAgentProfile()
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);

            funcon();
            string query = "SELECT * FROM DeliveryAgents WHERE DeliveryAgentId = @AgentId";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                firstName.Text = reader["FirstName"].ToString();
                lastName.Text = reader["LastName"].ToString();

                email.Text = reader["Email"].ToString();
                phone.Text = reader["PhoneNumber"].ToString();

                string imagePath = reader["ImageURL"].ToString();
                if (!string.IsNullOrEmpty(imagePath))
                {
                    profilePreview.ImageUrl = imagePath;
                }
                else
                {
                    profilePreview.ImageUrl = "../Asset/Library/img/Default_Photo.jpg";
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);
            try
            {
                String img = "~/StoreImage/" + profilePicture.FileName;
                funcon();

                String qry = "UPDATE DeliveryAgents SET FirstName=@firstname, LastName=@lastname, Email=@email, PhoneNumber=@phone, Address=@address, ImageUrl=@img WHERE DeliveryAgentId=@id";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@firstname", firstName.Text);
                cmd.Parameters.AddWithValue("@lastname", lastName.Text);
                cmd.Parameters.AddWithValue("@email", email.Text);
                cmd.Parameters.AddWithValue("@phone", phone.Text);
                cmd.Parameters.AddWithValue("@address", workingArea.SelectedValue);
                cmd.Parameters.AddWithValue("@img", img);
                cmd.Parameters.AddWithValue("@id", agentId);

                int res = cmd.ExecuteNonQuery();

                profilePicture.SaveAs(Server.MapPath(img));

                if (res > 0)
                {
                    LoadDeliveryAgentProfile();
                    LoadDeliveryAgentInformation();
                    LoademployeeInformation();
                    EditDeliveryAgentProfile();
                }
                else
                {
                    msg.Text = "Data not Update!";
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string agentId = Session["DeliveryAgentId"].ToString();  // make sure session has user id
            string cPassword = currentPassword.Text;
            string nPassword = newPassword.Text;
            string conPassword = ConfirmPassword.Text;

            if(nPassword != conPassword)
            {
                passMsg.Text = "New password and confirmation do not match.";
            }

            try
            {
                funcon();

                string checkQuery = "SELECT PasswordHash FROM DeliveryAgents WHERE DeliveryAgentId = @AgentId";
                cmd = new SqlCommand(checkQuery, conn);
                cmd.Parameters.AddWithValue("@AgentId", agentId);
                string existingPassword = Convert.ToString(cmd.ExecuteScalar());

                if (existingPassword != cPassword)
                {
                    passMsg.Text = "Current password is incorrect.";
                    return;
                }

                string updateQuery = "UPDATE DeliveryAgents SET PasswordHash = @NewPassword WHERE DeliveryAgentId = @AgentId";
                cmd = new SqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@NewPassword", nPassword);
                cmd.Parameters.AddWithValue("@AgentId", agentId);
                cmd.ExecuteNonQuery();

                passMsg.ForeColor = System.Drawing.Color.Green;
                passMsg.Text = "Password changed successfully.";
            }
            catch (Exception ex)
            {
                passMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}