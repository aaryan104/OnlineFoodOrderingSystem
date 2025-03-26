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
        public static String eml = String.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["s_eml"] != null)
            {
                eml = Session["s_eml"].ToString();
            }
            else
            {
                Response.Redirect("~/FOS/Login.aspx");
            }

            if (!IsPostBack)
            {
                string selectedCategory = Request.Form["hiddenCategory"] ?? "all";
                FetchMenuItems(selectedCategory);
            }
        }

        //private void RegisterCategoryScript()
        //{
        //    string script = @"
        //        <script>

        //        </script>";

        //    ClientScript.RegisterStartupScript(this.GetType(), "CategoryScript", script);
        //}

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

        public void FetchMenuItems(string category)
        {
            try
            {
                funcon();

                string qry = category == "all"
                    ? "SELECT ItemId, Name, ImageUrl, Price, Category, Description FROM MenuItems"
                    : "SELECT ItemId, Name, ImageUrl, Price, Category, Description FROM MenuItems WHERE Category = @Category";
                cmd = new SqlCommand(qry, conn);
                if (category != "all")
                {
                    cmd.Parameters.AddWithValue("@Category", category);
                    switch (category)
                    {
                        case "Dinner":
                            msg.Text = "Dinner Section!";
                            break;
                        case "Lunch":
                            msg.Text = "Lunch Section!";
                            break;
                        case "Breakfast":
                            msg.Text = "Breakfast Section!";
                            break;
                        case "Drinks":
                            msg.Text = "Drinks Section!";
                            break;
                        case "Fast-Food":
                            msg.Text = "Fast-Food Section!";
                            break;
                        default:
                            msg.Text = string.Empty;
                            break;
                    }
                }
                else
                {
                    msg.Text = "Popular All Dishes";

                }
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                // Debugging to check data
                //Response.Write("Rows fetched: " + dt.Rows.Count);

                if (dt.Rows.Count > 0)
                {
                    MenuItemsRepeater.DataSource = dt;
                    MenuItemsRepeater.DataBind();
                }
                else
                {
                    Response.Write("No data found for category: " + category);
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string category = Request.Form["hiddenCategory"];
                if (!string.IsNullOrEmpty(category))
                {
                    FetchMenuItems(category);
                }
            }
        }

        //protected void searchInput_TextChanged(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        string search = searchInput.Text;

        //        funcon();
        //        string qry = "SELECT * FROM MenuItems WHERE Name LIKE @search + '%'";
        //        cmd = new SqlCommand(qry, conn);
        //        cmd.Parameters.AddWithValue("@search", search);
        //        sda = new SqlDataAdapter(cmd);
        //        DataSet ds = new DataSet();
        //        sda.Fill(ds);
        //        MenuItemsRepeater.DataSource = ds;
        //        MenuItemsRepeater.DataBind();
        //        conn.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write(ex.ToString());
        //    }
        //}
    }
}