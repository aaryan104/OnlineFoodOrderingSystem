using OnlineFoodOrderingSystem.FOS.Customer;
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
    public partial class Orders : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["CurrentFilter"] = "All"; // Default filter
                fungrid();
                fetchOrder();
                LoadAgents();
            }
            else
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "FilterOrders")
                {
                    ViewState["CurrentFilter"] = eventArgument;
                    fungrid(eventArgument);
                }
            }

            if (Request["__EVENTTARGET"] == "AssignAgentPostback")
            {
                string orderId = hiddenOrderId.Value;
                string agentId = hiddenAgentId.Value;
                AssignOrderToAgent(orderId, agentId);
            }
        }

        public void funcon()
        {
            string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            conn = new SqlConnection(conStr);
            try
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void fungrid(string status = "All")
        {
            funcon();
            String qry = @"SELECT O.OrderId, U.FirstName, U.LastName, U.Email, O.OrderDate, O.TotalAmount AS Amount, O.OrderStatus AS Status 
                    FROM dbo.Orders O JOIN dbo.Users U ON O.UserId = U.UserId 
                    {0}
                    ORDER BY 
                    CASE 
                        WHEN O.OrderStatus = 'Pending' THEN 1
                        WHEN O.OrderStatus = 'Preparing' THEN 2
                        WHEN O.OrderStatus = 'Out for Delivery' THEN 3
                        WHEN O.OrderStatus = 'Delivered' THEN 4
                        WHEN O.OrderStatus = 'Cancelled' THEN 5
                        ELSE 6
                    END, O.OrderDate DESC";

            if (status != "All")
            {
                qry = string.Format(qry, "WHERE O.OrderStatus = @Status");
            }
            else
            {
                qry = string.Format(qry, "");
            }

            cmd = new SqlCommand(qry, conn);

            if (status != "All")
            {
                cmd.Parameters.AddWithValue("@Status", status);
            }

            sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvDashboard.DataSource = ds;
                gvDashboard.DataBind();
                lblNoData.Visible = false;
            }
            else
            {
                gvDashboard.DataSource = null;
                gvDashboard.DataBind();
                lblNoData.Visible = true;
            }

            conn.Close();
        }

        public void fetchOrder()
        {
            funcon();

            string qry1 = "SELECT COUNT(*) FROM orders";
            cmd = new SqlCommand(qry1, conn);
            int rowCount1 = (int)cmd.ExecuteScalar();
            lblOrder.Text = rowCount1.ToString();
            
            string qry2 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Pending'";
            cmd = new SqlCommand(qry2, conn);
            int rowCount2 = (int)cmd.ExecuteScalar();
            lblPending.Text = rowCount2.ToString();

            string qry3 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Delivered'";
            cmd = new SqlCommand(qry3, conn);
            int rowCount3 = (int)cmd.ExecuteScalar();
            lblComplete.Text = rowCount3.ToString();

            string qry4 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Cancelled'";
            cmd = new SqlCommand(qry4, conn);
            int rowCount4 = (int)cmd.ExecuteScalar();
            lblCancel.Text = rowCount4.ToString();
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            LinkButton btnShow = (LinkButton)sender;
            string orderId = btnShow.CommandArgument;

            try
            {
                funcon();
                string qry = "SELECT O.OrderId, U.FirstName, U.LastName, U.Email, O.OrderDate, O.TotalAmount AS Amount, O.OrderStatus AS Status " +
                             "FROM dbo.Orders O " +
                             "JOIN dbo.Users U ON O.UserId = U.UserId " +
                             "WHERE O.OrderId = @OrderId";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@OrderId", orderId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())  
                {
                    lblFirstname.Text = dr["FirstName"].ToString();
                    lblLastname.Text = dr["LastName"].ToString();
                    lblEmail.Text = dr["Email"].ToString();
                    lblId.Text = dr["OrderId"].ToString();
                    lblDate.Text = Convert.ToDateTime(dr["OrderDate"]).ToString("MMM dd, yyyy HH:mm");
                    lblStatus.Text = dr["Status"].ToString();
                    lblAmount.Text = dr["Amount"].ToString();
                }
                conn.Close();

                LoadOrderProducts(orderId);

                orderDetailsModal.Style["display"] = "block";
            }
            catch (Exception ex)
            {
                msg.Text = ex.Message;
            }
        }

        private void LoadOrderProducts(string orderId)
        {
            string qry = @"SELECT M.Name AS ProductName, OD.Quantity, OD.Subtotal AS Price
                         FROM dbo.OrderDetails OD
                         JOIN dbo.MenuItems M ON OD.ItemId = M.ItemId
                         WHERE OD.OrderId = @OrderId";

            cmd = new SqlCommand(qry, conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        private void LoadAgents()
        {
            funcon();
            string qry = @"
                SELECT DA.DeliveryAgentId, DA.FirstName, DA.LastName,
                       CASE WHEN EXISTS (
                           SELECT 1 FROM OrderAssignments OA
                           WHERE OA.DeliveryAgentId = DA.DeliveryAgentId
                           AND OA.AssignmentStatus='Assigned'
                       ) THEN 1 ELSE 0 END AS HasOrder
                FROM DeliveryAgents DA WHERE Status='Active'";

            SqlCommand cmd = new SqlCommand(qry, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptAgents.DataSource = dt;
            rptAgents.DataBind();
        }

        public void AssignOrderToAgent(string orderId, string agentId)
        {
            if (string.IsNullOrEmpty(orderId))
            {
                msg.Text = "Please select exactly one order.";
                return;
            }

            try
            {
                funcon();
                string insertQry = @"INSERT INTO OrderAssignments (OrderId, DeliveryAgentId, AssignmentStatus, AssignedAt) 
                             VALUES (@OrderId, @AgentId, 'Assigned', GETDATE())";
                SqlCommand cmdInsert = new SqlCommand(insertQry, conn);
                cmdInsert.Parameters.AddWithValue("@OrderId", orderId);
                cmdInsert.Parameters.AddWithValue("@AgentId", agentId);
                cmdInsert.ExecuteNonQuery();

                SqlCommand cmdUpdate = new SqlCommand("UPDATE Orders SET OrderStatus='Preparing' WHERE OrderId=@OrderId", conn);
                cmdUpdate.Parameters.AddWithValue("@OrderId", orderId);
                cmdUpdate.ExecuteNonQuery();

                msg.ForeColor = System.Drawing.Color.Green;
                msg.Text = "Order assigned successfully.";
                fungrid();
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string orderId = btn.CommandArgument;

            try
            {
                //Response.Write("Your Selected Id id : " + deliveryId);
                funcon();

                String qry = "DELETE FROM Orders WHERE OrderId=@id";
                SqlCommand cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("id", orderId);
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
                fungrid();
            }
            catch (Exception ex)
            {
                msg.Text = "Delete Id no. " + orderId + " Order first";
            }
        }
    }
}