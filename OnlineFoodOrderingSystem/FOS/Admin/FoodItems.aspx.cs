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
    public partial class FoodItems : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        public static int Id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                submitBtn.Visible = true;
                updateBtn.Visible = false;
                fungrid();
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

        public void fungrid()
        {
            try
            {
                funcon();
                // ORDER BY Name DESC
                String qry = "SELECT ItemId, Name, Description, Price, Category FROM MenuItems";
                cmd = new SqlCommand(qry, conn);
                sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                MenuItems.DataSource = ds;
                MenuItems.DataBind();
                conn.Close();
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }

        protected void submitBtn_Click(object sender, EventArgs e)
        {
            String img = "../../StoreImage/" + txtUpload.FileName;

            try
            {
                funcon();
                string checkNameQuery = "SELECT COUNT(*) FROM MenuItems WHERE Name=@checkName";
                cmd = new SqlCommand(checkNameQuery, conn);
                cmd.Parameters.AddWithValue("@checkName", txtName.Text);
                int nameExists = (int)cmd.ExecuteScalar();

                if (nameExists > 0)
                {
                    msg.Text = "This Food is already available, Please Try Something Else!";
                }
                else if (txtName.Text == string.Empty || txtPrice.Text == string.Empty || txtDescription.Text == string.Empty
                    || txtCategory.SelectedIndex == 0 || txtUpload == null)
                {
                    msg.Text = "Enter All Fields!";
                }
                else
                {
                    string qry = "INSERT INTO MenuItems(Name,Description,Price,Category,ImageUrl)" +
                        " VALUES(@name,@description,@price,@category,@img)";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                    cmd.Parameters.AddWithValue("@category", txtCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@img", img);

                    int res = cmd.ExecuteNonQuery();

                    txtUpload.SaveAs(Server.MapPath(img));

                    if (res > 0)
                    {
                        msg.Text = "Data inserted successfully!";
                        txtPrice.Text = string.Empty;
                        txtName.Text = string.Empty;
                        txtDescription.Text = string.Empty;
                        txtCategory.SelectedIndex = 0;
                    }
                    else
                    {
                        msg.Text = "Data insertion failed.";
                    }
                }
                fungrid();
                conn.Close();
            }
            catch (Exception ex)
            {
                msg.Text = ex.Message;
            }
        }

        protected void resetBtn_Click1(object sender, EventArgs e)
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtCategory.SelectedIndex = 0;
            hiddenItemId.Value = string.Empty;
            submitBtn.Visible = true;
            updateBtn.Visible = false;
        }



        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string itemId = btn.CommandArgument;

            try
            {
                funcon();
                string qry = "SELECT Name, Description, Price, Category, ImageUrl FROM MenuItems WHERE ItemId = @itemId";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@itemId", itemId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtName.Text = dr["Name"].ToString();
                    txtDescription.Text = dr["Description"].ToString();
                    txtPrice.Text = dr["Price"].ToString();
                    txtCategory.SelectedValue = dr["Category"].ToString();

                    hiddenItemId.Value = itemId.ToString();

                    submitBtn.Visible = false;
                    updateBtn.Visible = true;
                    txtName.ReadOnly = true;
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                msg.Text = ex.Message;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string itemId = btn.CommandArgument;

            try
            {
                funcon();
                String qry = "DELETE FROM MenuItems WHERE ItemId=@id";
                SqlCommand cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("id", itemId);
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
                fungrid();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }

        protected void updateBtn_Click(object sender, EventArgs e)
        {
            string itemId = hiddenItemId.Value;
            try
            {
                String img = "../../StoreImage/" + txtUpload.FileName;
                funcon();

                String qry = "UPDATE MenuItems SET Name=@name, Description=@description, Price=@price, Category=@category, ImageUrl=@image WHERE ItemId=@id";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                cmd.Parameters.AddWithValue("@category", txtCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@image", img);
                cmd.Parameters.AddWithValue("@id", itemId);

                int res = cmd.ExecuteNonQuery();
                if (res > 0)
                {   
                    msg.Text = "Data Update!";
                    submitBtn.Visible = true;
                    updateBtn.Visible = false;
                    txtName.ReadOnly = false;
                    txtName.Text = string.Empty;
                    txtDescription.Text = string.Empty;
                    txtPrice.Text = string.Empty;
                    txtCategory.SelectedIndex = 0;
                    hiddenItemId.Value = string.Empty;
                }
                else
                {
                    msg.Text = "Data not Update!";
                    conn.Close();
                }
                fungrid();
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
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
                MenuItems.DataSource = ds;
                MenuItems.DataBind();
                conn.Close();
                //MessageBox.Show(search);
            }
            catch (Exception ex)
            {
                //Response.Write("Error");
                msg.Text = ex.ToString();
            }
        }
    }
}