using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class LiveTracking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["orderid"]);
            DeliveryAgentDAL dal = new DeliveryAgentDAL();
            string status = dal.GetOrderStatus(orderId);
            lblTracking.Text = "Order Status: " + status;
        }
    }
}