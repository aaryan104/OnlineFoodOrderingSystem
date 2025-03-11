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
                //FetchMenuItems(); 
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
                string qry = "SELECT * FROM MenuItems WHERE Name LIKE @search + '%'";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@search", search);
                sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                MenuItemsRepeater.DataSource = ds;
                MenuItemsRepeater.DataBind();
                conn.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void btnAll_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnAll);
            FetchMenuItems(); // Show all items when "All" is clicked
        }

        protected void btnDinner_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnDinner);
            fetchMenuByCategory("Dinner"); // Show only Dinner items
        }

        protected void btnBreakfast_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnBreakfast);
            fetchMenuByCategory("Breakfast"); // Show only Breakfast items
        }

        protected void btnFastFood_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnFastFood);
            fetchMenuByCategory("Fast-Food"); // Show only Fast Food items
        }

        protected void btnDrinks_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnDrinks);
            fetchMenuByCategory("Drinks"); // Show only Drinks items
        }

        protected void btnLunch_Click(object sender, EventArgs e)
        {
            SetActiveButton(btnLunch);
            fetchMenuByCategory("Lunch"); // Show only Lunch items
        }

        private void fetchMenuByCategory(string Category)
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

        private void SetActiveButton(LinkButton activeButton)
        {
            btnAll.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";
            btnDinner.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";
            btnBreakfast.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";
            btnFastFood.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";
            btnDrinks.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";
            btnLunch.CssClass = "px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2";

            activeButton.CssClass = "px-6 py-2 bg-primary text-white rounded-full flex items-center gap-2";
        }
    }
}