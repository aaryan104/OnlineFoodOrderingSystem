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
    public partial class Transaction : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
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

        private void LoadOrders()
        {
            funcon();

            string qry = @"SELECT 
                            o.OrderId, 
                            u.FirstName + ' ' + u.LastName AS FullName,
                            u.UserId,
                            u.PhoneNumber,
                            o.TotalAmount, 
                            o.OrderDate,
                            p.PaymentMethod, 
                            p.PaymentStatus, 
                            p.PaymentDate
                        FROM Orders o
                        JOIN Payments p ON o.OrderId = p.OrderId
                        JOIN Users u ON o.UserId = u.UserId";

            cmd = new SqlCommand(qry, conn);
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            gvOrders.DataSource = dt;
            gvOrders.DataBind();
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                DeleteOrder(orderId);
                LoadOrders();
            }
        }

        private void DeleteOrder(int orderId)
        {
            funcon();

            string query = "DELETE FROM Payments WHERE OrderId=@OrderId";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@OrderId", orderId);
            int res = cmd.ExecuteNonQuery();

            if(res > 0)
            {
                msg.Text = "Data Deleted!";
            }
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string orderId = btn.CommandArgument;

            Response.Write("Your Selected Id id : " + orderId);
        }
    }
}