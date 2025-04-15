using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class AgentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblAgentName.Text = Session["AgentName"].ToString();
                LoadOrders();
            }

        }

        public void LoadOrders()
        {
            DeliveryAgentDAL dal = new DeliveryAgentDAL();
            gvOrders.DataSource = dal.GetOrdersByAgent(Convert.ToInt32(Session["AgentId"]));
            gvOrders.DataBind();
        }

    }
}