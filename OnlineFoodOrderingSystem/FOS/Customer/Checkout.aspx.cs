using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class Checkout : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_eml"] == null)
            {
                Response.Redirect("~/FOS/Login.aspx");
                return;
            }
            else
            {
                string email = Session["s_eml"].ToString();
                string connStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT Address FROM Users WHERE Email = @email", conn);
                    cmd.Parameters.AddWithValue("@email", email);

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        Session["address"] = result.ToString();
                    }
                }
            }

            if (!IsPostBack)
            {
                LoadCartData();
            }
        }

        private void LoadCartData()
        {
            try
            {
                if (Session["CartItems"] != null)
                {
                    decimal subtotal = Convert.ToDecimal(Session["Subtotal"]);
                    decimal deliveryFee = Convert.ToDecimal(Session["DeliveryFee"]);
                    decimal tax = Convert.ToDecimal(Session["Tax"]);
                    decimal total = Convert.ToDecimal(Session["Total"]);

                    hfSubtotal.Value = subtotal.ToString("0.00");
                    hfDeliveryFee.Value = deliveryFee.ToString("0.00");
                    hfTax.Value = tax.ToString("0.00");
                    hfTotal.Value = total.ToString("0.00");

                    amountToPay.InnerText = "₹" + total.ToString("0.00");
                    lblSubtotal.InnerText = "₹" + subtotal.ToString("0.00");
                    lblDelivery.InnerText = "₹" + deliveryFee.ToString("0.00");
                    lblTax.InnerText = "₹" + tax.ToString("0.00");
                    lblTotal.InnerText = "₹" + total.ToString("0.00");
                }
                else
                {
                    Response.Redirect("Cart.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error Loading Cart: " + ex.Message + "');</script>");
            }
        }


        protected void btnPay_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["CartItems"] == null)
                {
                    Response.Redirect("Cart.aspx");
                    return;
                }

                string email = Session["s_eml"].ToString();
                int userId = GetUserIdByEmail(email);

                if (userId == 0)
                {
                    Response.Write("<script>alert('User not found!');</script>");
                    return;
                }

                decimal subtotal = Convert.ToDecimal(hfSubtotal.Value);
                decimal tax = Convert.ToDecimal(hfTax.Value);
                decimal delivery = Convert.ToDecimal(hfDeliveryFee.Value);
                decimal total = Convert.ToDecimal(hfTotal.Value);

                int orderId = InsertOrder(userId, total);

                if (orderId > 0)
                {
                    Session["OrderId"] = orderId;
                    Session["OrderDate"] = DateTime.Now;
                    Session["TotalAmount"] = total;
                    Session["subTotal"] = subtotal;

                    InsertOrderDetails(orderId);
                    InsertPayment(orderId, total);

                    //Response.Write("<script>alert('OrderId: " + orderId + "');</script>");

                    Session.Remove("CartItems");

                    Response.Redirect("~/FOS/Customer/SuccessOrder.aspx");
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    Response.Write("<script>alert('Order Creation Failed!');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Payment Failed: " + ex.Message + "');</script>");
            }
        }


        private int GetUserIdByEmail(string email)
        {
            int userId = 0;
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
            {
                conn.Open();
                string query = "SELECT UserId FROM Users WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    userId = Convert.ToInt32(result);
                }
            }
            return userId;
        }

        private int InsertOrder(int userId, decimal totalAmount)
        {
            int orderId = 0;
            string status = "Pending";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
            {
                conn.Open();
                string query = "INSERT INTO Orders (UserId, OrderDate, TotalAmount, OrderStatus) OUTPUT INSERTED.OrderId VALUES (@UserId, @OrderDate, @TotalAmount, @Status)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmd.Parameters.AddWithValue("@Status", status);

                orderId = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return orderId;
        }

        private void InsertOrderDetails(int orderId)
        {
            DataTable cartTable = (DataTable)Session["CartItems"];

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
            {
                conn.Open();

                foreach (DataRow row in cartTable.Rows)
                {
                    string query = "INSERT INTO OrderDetails (OrderId, ItemId, Quantity, Subtotal) VALUES (@OrderId, @ItemId, @Quantity, @Price)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@ItemId", Convert.ToInt32(row["ItemId"]));
                    cmd.Parameters.AddWithValue("@Quantity", Convert.ToInt32(row["Quantity"]));
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(row["Price"]));
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void InsertPayment(int orderId, decimal amount)
        {
            string status = "Successful";
            string method = "PayPal";
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO Payments (OrderId, PaymentMethod, Amount, PaymentStatus, PaymentDate) VALUES (@OrderId, @Method, @Amount, @PaymentStatus, @PaymentDate)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@Method", method);
                    cmd.Parameters.AddWithValue("@Amount", amount);
                    cmd.Parameters.AddWithValue("@PaymentStatus", status);
                    cmd.Parameters.AddWithValue("@PaymentDate", DateTime.Now);
                    cmd.ExecuteNonQuery();

                    Session["PaymentMethod"] = method;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Payment Insert Error: " + ex.Message + "');</script>");
            }
        }
    }
}