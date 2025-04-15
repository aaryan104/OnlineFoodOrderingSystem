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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_eml"] == null)
            {
                Response.Redirect("~/FOS/Login.aspx");
            }

            if (!IsPostBack)
            {
                if (Request.Form["Items[0].ItemId"] == null)
                {
                    // If coming directly to checkout without items, redirect to home
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    LoadOrderItems();
                    LoadUserAddress();
                }
            }
        }

        private void LoadOrderItems()
        {
            DataTable dtOrderItems = new DataTable();
            dtOrderItems.Columns.Add("ItemId", typeof(int));
            dtOrderItems.Columns.Add("Name", typeof(string));
            dtOrderItems.Columns.Add("Price", typeof(decimal));
            dtOrderItems.Columns.Add("Quantity", typeof(int));
            dtOrderItems.Columns.Add("ImageUrl", typeof(string));

            decimal subtotal = 0;

            // Get items from form data
            int index = 0;
            while (Request.Form[$"Items[{index}].ItemId"] != null)
            {
                int itemId = Convert.ToInt32(Request.Form[$"Items[{index}].ItemId"]);
                int quantity = Convert.ToInt32(Request.Form[$"Items[{index}].Quantity"]);

                // Get item details from database
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT Name, Price, ImageUrl FROM MenuItems WHERE ItemId = @ItemId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@ItemId", itemId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            DataRow row = dtOrderItems.NewRow();
                            row["ItemId"] = itemId;
                            row["Name"] = reader["Name"].ToString();
                            row["Price"] = Convert.ToDecimal(reader["Price"]);
                            row["Quantity"] = quantity;
                            row["ImageUrl"] = reader["ImageUrl"].ToString();
                            dtOrderItems.Rows.Add(row);

                            subtotal += Convert.ToDecimal(reader["Price"]) * quantity;
                        }
                    }
                }
                index++;
            }

            rptOrderItems.DataSource = dtOrderItems;
            rptOrderItems.DataBind();

            // Calculate totals
            decimal deliveryFee = 40m;
            decimal total = subtotal + deliveryFee;

            //subtotal.InnerText = "₹" + subtotal.ToString("0.00");
            totalAmount.InnerText = "₹" + total.ToString("0.00");

            // Store order details in session for later use
            Session["CurrentOrder"] = new
            {
                Subtotal = subtotal,
                DeliveryFee = deliveryFee,
                Total = total,
                Items = dtOrderItems
            };
        }

        private void LoadUserAddress()
        {
            string email = Session["s_eml"].ToString();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
            {
                conn.Open();
                string query = @"SELECT u.FullName, a.AddressLine1, a.AddressLine2, a.City, a.State, a.Pincode
                               FROM Users u
                               LEFT JOIN UserAddresses a ON u.UserId = a.UserId
                               WHERE u.Email = @Email AND a.IsDefault = 1";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string address = $"{reader["FullName"]}<br>";
                        address += $"{reader["AddressLine1"]}<br>";
                        if (!string.IsNullOrEmpty(reader["AddressLine2"].ToString()))
                            address += $"{reader["AddressLine2"]}<br>";
                        address += $"{reader["City"]}, {reader["State"]} - {reader["Pincode"]}";

                        deliveryAddress.InnerHtml = address;
                    }
                    else
                    {
                        deliveryAddress.InnerText = "No address found. Please add an address.";
                    }
                }
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["CurrentOrder"] == null)
            {
                Response.Redirect("Home.aspx");
                return;
            }

            string paymentMethod = Request.Form["paymentMethod"];
            string email = Session["s_eml"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conStr"].ConnectionString))
                {
                    conn.Open();

                    // 1. Get user ID
                    int userId;
                    string getUserQuery = "SELECT UserId FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(getUserQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        userId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    // 2. Create order
                    string createOrderQuery = @"INSERT INTO Orders (UserId, OrderDate, TotalAmount, Status, PaymentMethod) 
                                             VALUES (@UserId, @OrderDate, @TotalAmount, @Status, @PaymentMethod);
                                             SELECT SCOPE_IDENTITY();";

                    decimal total = Convert.ToDecimal(((dynamic)Session["CurrentOrder"]).Total);

                    int orderId;
                    using (SqlCommand cmd = new SqlCommand(createOrderQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@OrderDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TotalAmount", total);
                        cmd.Parameters.AddWithValue("@Status", "Pending");
                        cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);

                        orderId = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    // 3. Add order items
                    DataTable items = ((dynamic)Session["CurrentOrder"]).Items;
                    foreach (DataRow row in items.Rows)
                    {
                        string addItemQuery = @"INSERT INTO OrderItems (OrderId, ItemId, Quantity, UnitPrice)
                                              VALUES (@OrderId, @ItemId, @Quantity, @UnitPrice)";

                        using (SqlCommand cmd = new SqlCommand(addItemQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@OrderId", orderId);
                            cmd.Parameters.AddWithValue("@ItemId", row["ItemId"]);
                            cmd.Parameters.AddWithValue("@Quantity", row["Quantity"]);
                            cmd.Parameters.AddWithValue("@UnitPrice", row["Price"]);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Clear session and redirect to confirmation
                    Session.Remove("CurrentOrder");
                    Response.Redirect($"OrderConfirmation.aspx?orderId={orderId}");
                }
            }
            catch (Exception ex)
            {
                // Handle error
                Response.Write($"<script>alert('Error processing order: {ex.Message}');</script>");
            }
        }
    }
}