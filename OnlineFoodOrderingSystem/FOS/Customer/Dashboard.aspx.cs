using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchMenuItems();
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
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.ToString());
            }
        }

        public void FetchMenuItems()
        {
            try
            {
                funcon();

                string qry = "SELECT ItemId, Name, ImageUrl, Price, Category, Description FROM MenuItems";
                cmd = new SqlCommand(qry, conn);
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                MenuItemsRepeater.DataSource = dt;
                MenuItemsRepeater.DataBind();
            }
            catch (Exception ex)
            {
               Response.Write("Error fetching data: " + ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
    }
}