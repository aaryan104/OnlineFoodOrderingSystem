using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class UpdateOrderStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string orderId = Request.QueryString["orderid"];
                lblOrder.Text = "Order ID: " + orderId;
            }
        }

        public void btnUpdate_Click(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["orderid"]);
            string status = ddlStatus.SelectedValue;
            DeliveryAgentDAL dal = new DeliveryAgentDAL();
            dal.UpdateOrderStatus(orderId, status);
            Response.Redirect("AgentDashboard.aspx");
        }

    }
}