using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace OnlineFoodOrderingSystem.FOS.Admin
{
    public partial class DeliveryBoy : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            BindDeliveryAgents();
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

        private void BindDeliveryAgents()
        {
            funcon();

            string query = "SELECT DeliveryAgentId, FirstName, LastName, Email, PhoneNumber, VehicleNumber, Status, Address FROM DeliveryAgents";
            sda = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            
            GridViewDeliveryAgents.DataSource = dt;
            GridViewDeliveryAgents.DataBind();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string deliveryId = btn.CommandArgument;

            try
            {
                //Response.Write("Your Selected Id id : " + deliveryId);
                funcon();

                String qry = "DELETE FROM MenuItems WHERE ItemId=@id";
                SqlCommand cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("id", deliveryId);
                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    msg.Text = "Data Remove!";
                }
                else
                {
                    msg.Text = "Data not Removed!";
                    conn.Close();
                }
                BindDeliveryAgents();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string agentId = hiddenItemId.Value;

            if (firstName.Text == string.Empty || lastName.Text == string.Empty || email.Text == string.Empty || phoneNumber.Text == string.Empty
                || vehicleNumber.Text == string.Empty || status.SelectedValue == string.Empty || workingArea.SelectedValue == string.Empty)
            {
                msg.Text = "Enter Empty Values!";
            }
            else
            {
                try
                {
                    funcon();

                    String qry = "UPDATE DeliveryAgents SET FirstName=@firstname, LastName=@lastname, Email=@email, PhoneNumber=@phone, VehicleNumber=@vehical, Status=@status, Address=@address WHERE DeliveryAgentId=@AgentId";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("@firstname", firstName.Text);
                    cmd.Parameters.AddWithValue("@lastname", lastName.Text);
                    cmd.Parameters.AddWithValue("@email", email.Text);
                    cmd.Parameters.AddWithValue("@phone", phoneNumber.Text);
                    cmd.Parameters.AddWithValue("@vehical", vehicleNumber.Text);
                    cmd.Parameters.AddWithValue("@status", status.SelectedValue);
                    cmd.Parameters.AddWithValue("@address", workingArea.SelectedValue);
                    cmd.Parameters.AddWithValue("@AgentId", agentId);

                    int res = cmd.ExecuteNonQuery();

                    if (res > 0)
                    {
                        msg.Text = "Data Update!";
                    }
                    else
                    {
                        msg.Text = "Data not Update!";
                    }
                    BindDeliveryAgents();
                }
                catch (Exception ex)
                {
                    msg.Text = ex.ToString();
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string deliveryId = btn.CommandArgument;

            try
            {
                funcon();
                string qry = "SELECT FirstName, LastName, Email, PhoneNumber, VehicleNumber, Status, Address FROM DeliveryAgents WHERE DeliveryAgentId = @agentId";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@agentId", deliveryId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    firstName.Text = dr["FirstName"].ToString();
                    lastName.Text = dr["LastName"].ToString();
                    email.Text = dr["Email"].ToString();
                    phoneNumber.Text = dr["PhoneNumber"].ToString();
                    vehicleNumber.Text = dr["VehicleNumber"].ToString();
                    status.SelectedValue = dr["Status"].ToString();
                    workingArea.SelectedValue = dr["Address"].ToString();
                    password.Text = "********";

                    hiddenItemId.Value = deliveryId.ToString();
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                msg.Text = ex.Message;
            }
        }
    }
}