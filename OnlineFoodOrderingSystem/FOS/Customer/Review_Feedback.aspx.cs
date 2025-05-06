using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class Review_Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["OrderId"] != null)
                {
                    int orderId = Convert.ToInt32(Request.QueryString["OrderId"]);
                    txtOrderId.Text = orderId.ToString();  // ✅ Set in textbox
                }
                else
                {
                    Response.Redirect("~/FOS/Login.aspx");
                }
            }
        }

        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(Request.QueryString["OrderId"]);
            string comment = txtComment.Text;
            int rating = Convert.ToInt32(hfRating.Value);

            string constr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                string query = "INSERT INTO Feedback (OrderId, Rating, Comment, FeedbackDate) VALUES (@OrderId, @Rating, @Comment, @date)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@OrderId", orderId);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@Comment", comment);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            //lblMessage.Text = "Thank you for your feedback!";
            Response.Redirect("Home.aspx");
        }
    }
}