using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineFoodOrderingSystem.FOS.Admin
{
    public partial class ReviewAndFeedback : System.Web.UI.Page
    {
        SqlConnection conn;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            BindFeedbacks();
        }

        protected string GetStarRating(int rating)
        {
            string stars = "";
            for (int i = 0; i < rating; i++)
            {
                stars += "★";
            }
            return stars;
        }


        private void BindFeedbacks()
        {
            string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT u.FirstName + ' ' + u.LastName AS FullName, 
                                        f.FeedbackId,
                                        f.OrderId, 
                                        f.Rating, 
                                        f.Comment, 
                                        f.FeedbackDate
                                FROM Feedback f
                                INNER JOIN Orders o ON f.OrderId = o.OrderId
                                INNER JOIN Users u ON o.UserId = u.UserId
                                ORDER BY f.FeedbackDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvFeedbacks.DataSource = dt;
                        gvFeedbacks.DataBind();
                    }
                }
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string FeedbackId = btn.CommandArgument;

            try
            {
                //Response.Write("Your Selected Id id : " + FeedbackId);
                funcon();

                String qry = "DELETE FROM Feedback WHERE FeedbackId=@id";
                SqlCommand cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("id", FeedbackId);
                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    msg.Text = "Data Remove!";
                }
                else
                {
                    msg.Text = "Data not Removed!";
                    conn.Close();
                }
                BindFeedbacks();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
    }
}