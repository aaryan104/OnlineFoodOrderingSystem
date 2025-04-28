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
    }
}