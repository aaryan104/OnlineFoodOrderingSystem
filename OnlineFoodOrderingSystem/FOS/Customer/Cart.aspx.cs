using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string discountCode = Request.QueryString["code"];
                string discountValue = Request.QueryString["discount"];

                if (!string.IsNullOrEmpty(discountValue) && decimal.TryParse(discountValue, out decimal discount))
                {
                    ApplyDiscount(discount);
                }

                LoadCartItems();
            }
        }

        private void ApplyDiscount(decimal discount)
        {
            decimal subtotal = GetCurrentSubtotal();
            decimal tax = subtotal * 0.05m;
            decimal total = subtotal + tax - discount;

            Session["Total"] = total;
            Session["Discount"] = discount;
        }

        private decimal GetCurrentSubtotal()
        {
            // Implement logic to calculate the current subtotal from the cart items
            // This is just a placeholder
            return 0; // Replace with actual subtotal calculation
        }

        private void LoadCartItems()
        {
            // Implement your logic to load cart items and display them
        }

        protected void btnProceedToCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                string cartJson = hfCartData.Value;

                if (!string.IsNullOrEmpty(cartJson))
                {
                    JavaScriptSerializer js = new JavaScriptSerializer();
                    List<CartItem> cartList = js.Deserialize<List<CartItem>>(cartJson);

                    if (cartList != null && cartList.Count > 0)
                    {
                        DataTable cartTable = new DataTable();
                        cartTable.Columns.Add("ItemId", typeof(int));
                        cartTable.Columns.Add("Name", typeof(string));
                        cartTable.Columns.Add("Price", typeof(decimal));
                        cartTable.Columns.Add("ImageUrl", typeof(string));
                        cartTable.Columns.Add("Quantity", typeof(int));

                        decimal subtotal = 0;

                        foreach (var item in cartList)
                        {
                            cartTable.Rows.Add(item.id, item.name, item.price, item.image, item.quantity);
                            subtotal += item.price * item.quantity;
                        }

                        decimal deliveryFee = 20; // Always ₹20 delivery
                        decimal subtotalPlusDelivery = subtotal + deliveryFee;
                        decimal tax = subtotalPlusDelivery * 0.05m; // 5% tax on subtotal + delivery
                        decimal total = subtotalPlusDelivery + tax;

                        Session["CartItems"] = cartTable;
                        Session["Subtotal"] = subtotal;
                        Session["DeliveryFee"] = deliveryFee;
                        Session["Tax"] = tax;
                        Session["Total"] = total;

                        Response.Redirect("~/FOS/Customer/Checkout.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Cart is empty!');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Cart data missing!');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error processing cart: " + ex.Message + "');</script>");
            }
        }


        public class CartItem
        {
            public int id { get; set; }
            public string name { get; set; }
            public decimal price { get; set; }
            public string image { get; set; }
            public int quantity { get; set; }
        }
    }
}