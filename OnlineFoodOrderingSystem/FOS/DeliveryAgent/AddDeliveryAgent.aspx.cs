using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.DeliveryAgent
{
    public partial class AddDeliveryAgent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            DeliveryAgentDAL dal = new DeliveryAgentDAL();
            dal.AddAgent(txtName.Text, txtEmail.Text, txtPassword.Text);
            Response.Redirect("AgentDashboard.aspx");
        }
    }
}