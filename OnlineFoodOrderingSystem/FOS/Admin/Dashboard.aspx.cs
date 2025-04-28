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
            String qry = @"SELECT O.OrderId, U.FirstName, U.LastName, U.Email, O.OrderDate, O.TotalAmount AS Amount, O.OrderStatus AS Status 
                            FROM dbo.Orders O JOIN dbo.Users U ON O.UserId = U.UserId 
                            ORDER BY 
                            CASE 
                                WHEN o.OrderStatus = 'Pending' THEN 1
                                WHEN o.OrderStatus = 'Delivered' THEN 2
                                WHEN o.OrderStatus = 'Preparing' THEN 3
                                WHEN o.OrderStatus = 'Out for Delivery' THEN 4
                                WHEN o.OrderStatus = 'Delayed' THEN 5
                                WHEN o.OrderStatus = 'Cancelled' THEN 6
                                ELSE 7
                            END, o.OrderDate DESC";

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
    }
}