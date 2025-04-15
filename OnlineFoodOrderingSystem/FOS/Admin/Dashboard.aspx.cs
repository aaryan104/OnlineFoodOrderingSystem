using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace OnlineFoodOrderingSystem.FOS.Admin
{
    public partial class Home : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fungrid();
                fetchOrder();
            }
        }

        public void funcon()
        {
            string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            conn = new SqlConnection(conStr);
            try
            {
                if (conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        public void fungrid()
        {
            funcon();
            String qry = "SELECT O.OrderId, U.FirstName, U.LastName, U.Email, O.OrderDate, O.TotalAmount AS Amount, O.OrderStatus AS Status " +
                "FROM  dbo.Orders O " +
                "JOIN dbo.Users U " +
                "ON O.UserId = U.UserId;";
            cmd = new SqlCommand(qry, conn);
            sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvDashboard.DataSource = ds;
            gvDashboard.DataBind();
            conn.Close();
        }

        public void fetchOrder()
        {
            funcon();
            string todayDate = DateTime.Now.ToString("yyyy-MM-dd");

            string qry1 = "SELECT COUNT(*) FROM orders";
            cmd = new SqlCommand(qry1, conn);
            int rowCount1 = (int)cmd.ExecuteScalar();
            lblOrder.Text = rowCount1.ToString();

            string qry2 = "SELECT SUM(TotalAmount) FROM orders";
            cmd = new SqlCommand(qry2, conn);
            object result = cmd.ExecuteScalar();
            decimal rowCount2 = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            lblRevenue.Text = rowCount2.ToString("C");

            string qry3 = "SELECT COUNT(*) FROM Users";
            cmd = new SqlCommand(qry3, conn);
            int rowCount3 = (int)cmd.ExecuteScalar();
            lblUser.Text = rowCount3.ToString();

            string qry4 = "SELECT COUNT(*) FROM orders WHERE CAST(OrderDate AS DATE) = @TodayDate";
            cmd = new SqlCommand(qry4, conn);
            cmd.Parameters.AddWithValue("@TodayDate", todayDate);
            int rowCount4 = (int)cmd.ExecuteScalar();
            lblTodayOrder.Text = rowCount4.ToString();

            string qry5 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Pending'";
            cmd = new SqlCommand(qry5, conn);
            int rowCount5 = (int)cmd.ExecuteScalar();
            lblWaiting.Text = rowCount5.ToString();

            string qry6 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Out for Delivery'";
            cmd = new SqlCommand(qry6, conn);
            int rowCount6 = (int)cmd.ExecuteScalar();
            lblOntheway.Text = rowCount6.ToString();

            string qry7 = "SELECT COUNT(*) FROM Orders WHERE OrderStatus='Delivered'";
            cmd = new SqlCommand(qry7, conn);
            int rowCount7 = (int)cmd.ExecuteScalar();
            lblCompleted.Text = rowCount7.ToString();
        }
    }
}