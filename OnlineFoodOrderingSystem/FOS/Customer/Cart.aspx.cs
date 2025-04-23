using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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

    }
}