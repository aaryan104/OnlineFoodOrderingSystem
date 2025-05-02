using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Drawing;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class trackOrder : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        public static int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_eml"] == null)
            {
                Response.Redirect("~/FOS/Login.aspx");
                return;
            }

            GetUserIdFromEmail();

            if (!IsPostBack)
            {
                LoadOrders();
            }

            // ✅ This now works because HiddenField is set from JS
            if (IsPostBack && hiddenOrderId.Value != "")
            {
                LoadOrderDetails(hiddenOrderId.Value);
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
                msg.Text = ex.ToString();
            }
        }

        private void GetUserIdFromEmail()
        {
            funcon();
            string email = Session["s_eml"].ToString();

            string query = "SELECT UserId FROM Users WHERE Email = @Email";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", email);
            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                userId = Convert.ToInt32(result);
            }
            else
            {
                msg.Text = "User not found.";
            }
        } 

        private void LoadOrders()
        {
            funcon();

            string query = "SELECT OrderId, OrderDate, OrderStatus, TotalAmount FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }

        private void LoadOrderDetails(string orderId)
        {
            funcon();
            //Response.Write("<script>alert('OrderId: " + orderId + "');</script>");
            string query = @"SELECT TOP 1 
                            o.OrderId,
                            o.OrderDate,
                            o.DeliveryDate,
                            u.Address,
                            u.FirstName + ' ' + u.LastName AS CustomerName,
                            u.PhoneNumber,
                            p.PaymentMethod
                        FROM Orders o
                        INNER JOIN Users u ON o.UserId = u.UserId
                        LEFT JOIN Payments p ON o.OrderId = p.OrderId
                        WHERE o.OrderId = @OrderId AND o.UserId = @UserId";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            cmd.Parameters.AddWithValue("@UserId", userId);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblCustomerName.Text = reader["CustomerName"].ToString();
                lblContact.Text = reader["PhoneNumber"].ToString();
                lblOrderId.Text = reader["OrderId"].ToString();
                lblOrderDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("MMMM dd, yyyy");
                //lblEstimatedDelivery.Text = Convert.ToDateTime(reader["DeliveryDate"]).ToString("MMMM dd, yyyy");
                lblShippingAddress.Text = reader["Address"].ToString();
                lblPaymentMethod.Text = reader["PaymentMethod"].ToString();
                lblDebug.Text = $"Loaded orderId = {orderId}, userId = {userId}";
            }
            reader.Close();


            string itemQuery = @"SELECT m.Name AS ItemName, od.Quantity, od.Subtotal
                     FROM OrderDetails od
                     INNER JOIN MenuItems m ON od.ItemId = m.ItemId
                     WHERE od.OrderId = @OrderId";

            SqlCommand itemCmd = new SqlCommand(itemQuery, conn);
            itemCmd.Parameters.AddWithValue("@OrderId", orderId);
            SqlDataAdapter sda = new SqlDataAdapter(itemCmd);
            DataTable dtItems = new DataTable();
            sda.Fill(dtItems);

            rptOrderItems.DataSource = dtItems;
            rptOrderItems.DataBind();

            decimal total = 0;
            foreach (DataRow row in dtItems.Rows)
            {
                total += Convert.ToDecimal(row["Subtotal"]);
            }
            lblTotalAmount.Text = "₹" + total.ToString("F2");
        }
    }
}