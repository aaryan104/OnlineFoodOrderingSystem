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

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class DeliveryAgentDashboard : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        public static int Id;
        public static string IDs = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DeliveryAgentId"] != null)
                {
                    IDs = Session["DeliveryAgentId"].ToString();
                    LoadAssignedOrders();
                    fetchUsername();
                    fetchOrder();
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

        public void fetchUsername()
        {
            funcon();   
            string qry = "SELECT FirstName FROM DeliveryAgents WHERE DeliveryAgentId=@id";
            SqlCommand cmd = new SqlCommand(qry, conn);
            cmd.Parameters.AddWithValue("@id", IDs);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtName.Text = dr["FirstName"].ToString();
            }
        }

        public void fetchOrder()
        {
            funcon();
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);
            string todayDate = DateTime.Now.ToString("yyyy-MM-dd");

            string qry1 = @"
                SELECT COUNT(*) 
                FROM Orders o
                INNER JOIN OrderAssignments oa ON o.OrderId = oa.OrderId
                WHERE oa.DeliveryAgentId = @AgentId
                AND CAST(o.OrderDate AS DATE) = @TodayDate";
            cmd = new SqlCommand(qry1, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);
            cmd.Parameters.AddWithValue("@TodayDate", todayDate);
            int rowCount1 = (int)cmd.ExecuteScalar();
            lblTodayOrder.Text = rowCount1.ToString();

            string qry2 = @"
                SELECT COUNT(*) 
                FROM Orders o
                INNER JOIN OrderAssignments oa ON o.OrderId = oa.OrderId
                WHERE oa.DeliveryAgentId = @AgentId
                AND o.OrderStatus = 'Out for Delivery'";
            cmd = new SqlCommand(qry2, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);
            int rowCount2 = (int)cmd.ExecuteScalar();
            lblOntheway.Text = rowCount2.ToString();

            string qry3 = @"
                SELECT COUNT(*) 
                FROM Orders o
                INNER JOIN OrderAssignments oa ON o.OrderId = oa.OrderId
                WHERE oa.DeliveryAgentId = @AgentId
                AND o.OrderStatus = 'Delivered'";
            cmd = new SqlCommand(qry3, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);
            int rowCount3 = (int)cmd.ExecuteScalar();
            lblCompleted.Text = rowCount3.ToString();

            string qry4 = @"
                SELECT COUNT(*) 
                FROM Orders o
                INNER JOIN OrderAssignments oa ON o.OrderId = oa.OrderId
                WHERE oa.DeliveryAgentId = @AgentId
                AND o.OrderStatus = 'Cancelled'";
            cmd = new SqlCommand(qry4, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);
            int rowCount4 = (int)cmd.ExecuteScalar();
            lblCancel.Text = rowCount4.ToString();
        }

        private void LoadAssignedOrders()
        {
            int agentId = Convert.ToInt32(Session["DeliveryAgentId"]);

            funcon();
            string query = @"
                SELECT oa.AssignmentId,
                        o.OrderId,
                        u.UserId,
                        u.PhoneNumber,
                        u.FirstName + ' ' + u.LastName AS CustomerName,
                        o.TotalAmount,
                        o.OrderStatus,
                        o.OrderDate,
                        oa.AssignedAt
                FROM OrderAssignments oa
                    INNER JOIN Orders o ON oa.OrderId = o.OrderId
                    INNER JOIN Users u ON o.UserId = u.UserId
                WHERE oa.DeliveryAgentId = @AgentId
                    AND o.OrderStatus IN ('Preparing', 'Out for Delivery', 'Delivered')
                ORDER BY 
                    CASE 
                        WHEN o.OrderStatus = 'Preparing' THEN 1
                        WHEN o.OrderStatus = 'Out for Delivery' THEN 2
                        WHEN o.OrderStatus = 'Delivered' THEN 3
                        WHEN o.OrderStatus = 'Cancelled' THEN 4
                        ELSE 5
                    END, o.OrderDate DESC";

            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@AgentId", agentId);

            sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            sda.Fill(dt);
            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }
    }
}