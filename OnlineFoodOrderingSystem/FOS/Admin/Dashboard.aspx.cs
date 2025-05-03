using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace OnlineFoodOrderingSystem.FOS.Admin
{
    public partial class Home : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fungrid();
                fetchOrder();
            }
            else
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "FilterOrders")
                {
                    fungrid(); // Filter orders based on the selected status
                }
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

        public void fungrid()
        {
            funcon();
            String qry = @"
                SELECT 
                    oa.AssignmentId,
                    oa.OrderId,
                    oa.DeliveryAgentId,
                    u.FirstName + ' ' + u.LastName AS CustomerName,
                    da.FirstName + ' ' + da.LastName AS DeliveryAgentName,
                    u.PhoneNumber AS CustomerPhone,
                    da.PhoneNumber AS DeliveryPhone,
                    o.TotalAmount AS Amount,
                    oa.AssignmentStatus,
                    oa.AssignedAt
                FROM 
                    OrderAssignments oa
                JOIN 
                    Orders o ON oa.OrderId = o.OrderId
                JOIN 
                    Users u ON o.UserId = u.UserId
                JOIN 
                    DeliveryAgents da ON oa.DeliveryAgentId = da.DeliveryAgentId
                ORDER BY 
                    oa.AssignedAt DESC";

            cmd = new SqlCommand(qry, conn);
            sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                gvDashboard.DataSource = ds;
                gvDashboard.DataBind();
            }
            else
            {
                gvDashboard.DataSource = null;
                gvDashboard.DataBind();
            }

            conn.Close();
        }

        public void fetchOrder()
        {
            funcon();
            string todayDate = DateTime.Now.ToString("yyyy-MM-dd");

            string qry1 = "SELECT COUNT(*) FROM orders";
            cmd = new SqlCommand(qry1, conn);
            int rowCount1 = (int)cmd.ExecuteScalar();
            lblOrder.Text = rowCount1.ToString();

            string qry2 = "SELECT SUM(TotalAmount) FROM orders";
            cmd = new SqlCommand(qry2, conn);
            object result = cmd.ExecuteScalar();
            decimal rowCount2 = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            lblRevenue.Text = rowCount2.ToString("C");

            string qry3 = "SELECT COUNT(*) FROM Users";
            cmd = new SqlCommand(qry3, conn);
            int rowCount3 = (int)cmd.ExecuteScalar();
            lblUser.Text = rowCount3.ToString();

            string qry4 = "SELECT COUNT(*) FROM orders WHERE CAST(OrderDate AS DATE) = @TodayDate";
            cmd = new SqlCommand(qry4, conn);
            cmd.Parameters.AddWithValue("@TodayDate", todayDate);
            int rowCount4 = (int)cmd.ExecuteScalar();
            lblTodayOrder.Text = rowCount4.ToString();

            string qry5 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Pending'";
            cmd = new SqlCommand(qry5, conn);
            int rowCount5 = (int)cmd.ExecuteScalar();
            lblWaiting.Text = rowCount5.ToString();

            string qry6 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Out for Delivery'";
            cmd = new SqlCommand(qry6, conn);
            int rowCount6 = (int)cmd.ExecuteScalar();
            lblOntheway.Text = rowCount6.ToString();

            string qry7 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Delivered'";
            cmd = new SqlCommand(qry7, conn);
            int rowCount7 = (int)cmd.ExecuteScalar();
            lblCompleted.Text = rowCount7.ToString();

            string qry8 = "SELECT COUNT(*) FROM MenuItems";
            cmd = new SqlCommand(qry8, conn);
            int rowCount8 = (int)cmd.ExecuteScalar();
            //string items = rowCount8.ToString();

            int items = rowCount8 - 1;
            lblFood.Text = items + "+ Items";

            string qry9 = "SELECT COUNT(*) FROM DeliveryAgents";
            cmd = new SqlCommand(qry9, conn);
            int rowCount9 = (int)cmd.ExecuteScalar();
            lblAgents.Text = rowCount9.ToString();

            string qry10 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Pending'";
            cmd = new SqlCommand(qry10, conn);
            int rowCount10 = (int)cmd.ExecuteScalar();
            lblPending.Text = rowCount10.ToString();

            string qry11 = "SELECT COUNT(*) FROM Payments WHERE PaymentStatus='Successful'";
            cmd = new SqlCommand(qry11, conn);
            int rowCount11 = (int)cmd.ExecuteScalar();
            lblPayment.Text = rowCount11.ToString();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string AssignmentId = btn.CommandArgument;

            try
            {
                //Response.Write("Your Selected Id id : " + deliveryId);
                funcon();

                String qry = "DELETE FROM OrderAssignments WHERE AssignmentId=@id";
                SqlCommand cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("id", AssignmentId);
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
                msg.Text = "Delete Id " + AssignmentId + " Logs First.";
            }
        }
    }
}