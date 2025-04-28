using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Drawing;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class trackOrder : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        public static int userId; // int type hona chahiye!

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["s_eml"] == null)
                {
                    Response.Redirect("~/FOS/Login.aspx");
                    return;
                }
                else
                {
                    GetUserIdFromEmail();
                    LoadOrders();
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

        private void GetUserIdFromEmail()
        {
            funcon();
            string email = Session["s_eml"].ToString();

            string query = "SELECT UserId FROM Users WHERE Email = @Email";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Email", email);
            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                userId = Convert.ToInt32(result);
            }
            else
            {
                msg.Text = "User not found.";
            }
        } 

        private void LoadOrders()
        {
            funcon();

            string query = "SELECT OrderId, OrderDate, OrderStatus, TotalAmount FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC";
            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }
    }
}