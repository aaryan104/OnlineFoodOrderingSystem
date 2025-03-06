using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        protected void searchInput_TextChanged(object sender, EventArgs e)
        {
            try
            {
                string search = searchInput.Text;

                funcon();
                String qry = "SELECT * from MenuItems WHERE Name LIKE @search + '%'";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@search", search);
                sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                MenuItemsRepeater.DataSource = ds;
                MenuItemsRepeater.DataBind();
                conn.Close();
                //MessageBox.Show(search);
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void btnAll_Click(object sender, EventArgs e)
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

        protected void btnDinner_Click(object sender, EventArgs e)
        {
            fetchMenuByCategory("Dinner");
        }

        protected void btnBreakfast_Click(object sender, EventArgs e)
        {
            fetchMenuByCategory("Breakfast");
        }

        protected void btnFastFood_Click(object sender, EventArgs e)
        {
            fetchMenuByCategory("Fast-Food");       
        }

        protected void btnDrinks_Click(object sender, EventArgs e)
        {
            fetchMenuByCategory("Drinks");
        }

        protected void btnLunch_Click(object sender, EventArgs e)
        {
            fetchMenuByCategory("Lunch");
        }

        private void fetchMenuByCategory(String Category)
        {
            try
            {
                funcon();

                string qry = "SELECT ItemId, Name, ImageUrl, Price, Category, Description FROM MenuItems WHERE Category=@category";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@category", Category);
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