using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class updateStatus : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["OrderId"]))
                {
                    string orderId = Request.QueryString["OrderId"];
                    orderNumber.Text = orderId;

                    // Optional: Disable the textbox if you don't want it editable
                    orderNumber.ReadOnly = true;
                }

                if (Session["DeliveryAgentId"] != null)
                {
                    BindDeliveryLogs();
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

        private void BindDeliveryLogs()
        {
            funcon();

            string qry = @"
                SELECT 
                    o.OrderId,
                    dl.StatusUpdate AS Status,
                    dl.Timestamp AS Updated
                FROM 
                    DeliveryLogs dl
                INNER JOIN 
                    OrderAssignments oa ON dl.AssignmentId = oa.AssignmentId
                INNER JOIN 
                    Orders o ON oa.OrderId = o.OrderId
                ORDER BY 
                    dl.Timestamp DESC";

            cmd = new SqlCommand(qry, conn);
            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            gvStatusUpdates.DataSource = dt;
            gvStatusUpdates.DataBind();
        }



        protected void updateButton_Click(object sender, EventArgs e)
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);
            int orderId = Convert.ToInt32(orderNumber.Text.Trim());
            string newStatus = status.SelectedValue;
            DateTime timestamp = DateTime.Now;

            funcon();

            string qry = "SELECT AssignmentId FROM OrderAssignments WHERE OrderId=@OrderId AND DeliveryAgentId=@AgentId";
            cmd = new SqlCommand(qry, conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@AgentId", agentId);
            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                int assignmentId = Convert.ToInt32(result);

                string qry1 = "SELECT OrderStatus FROM Orders WHERE OrderId=@OrderId";
                cmd = new SqlCommand(qry1, conn);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                string currentStatus = Convert.ToString(cmd.ExecuteScalar());

                if (currentStatus == "Pending" && (newStatus == "Out for Delivery" || newStatus == "Delivered"))
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Admin has not started preparing this order yet.";
                    return;
                }

                if (currentStatus == "Preparing" && newStatus == "Delivered")
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Order must be marked 'Out for Delivery' before 'Delivered'.";
                    return;
                }

                string qry2 = "INSERT INTO DeliveryLogs (AssignmentId, StatusUpdate, Timestamp) VALUES (@AssignmentId, @StatusUpdate, @Timestamp)";
                cmd = new SqlCommand(qry2, conn);
                cmd.Parameters.AddWithValue("@AssignmentId", assignmentId);
                cmd.Parameters.AddWithValue("@StatusUpdate", newStatus);
                cmd.Parameters.AddWithValue("@Timestamp", timestamp);
                cmd.ExecuteNonQuery();

                string qry3 = "UPDATE Orders SET OrderStatus=@OrderStatus WHERE OrderId=@OrderId";
                cmd = new SqlCommand(qry3, conn);
                cmd.Parameters.AddWithValue("@OrderStatus", newStatus);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                cmd.ExecuteNonQuery();

                if(newStatus == "Delivered")
                {
                    string qry4 = "UPDATE OrderAssignments SET AssignmentStatus='Delivered', DeliveredAt=@DeliveredAt WHERE AssignmentId=@AssignmentId";
                    cmd = new SqlCommand(qry4, conn);
                    cmd.Parameters.AddWithValue("DeliveredAt", timestamp);
                    cmd.Parameters.AddWithValue("@AssignmentId", assignmentId);
                    cmd.ExecuteNonQuery();
                }

                BindDeliveryLogs();
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Status updated successfully!";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "No order assigned with this ID!";
            }
        }
    }
}