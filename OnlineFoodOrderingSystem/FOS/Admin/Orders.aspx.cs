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
                fungrid(); // Load all orders by default
                fetchOrder(); // Fetch order counts
            }
            else
            {
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "FilterOrders")
                {
                    fungrid(eventArgument); // Filter orders based on the selected status
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

        public void fungrid(string status = "All")
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

            if (status != "All")
            {
                qry += " WHERE O.OrderStatus = @Status";
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
    }
}