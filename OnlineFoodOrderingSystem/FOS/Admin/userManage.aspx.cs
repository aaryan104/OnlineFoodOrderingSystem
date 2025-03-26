using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace OnlineFoodOrderingSystem.FOS.Admin
{
    public partial class userManage : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        //public static int Id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
                String qry = "SELECT UserId, FirstName, LastName, Email, PhoneNumber, Role, Address FROM Users";
                cmd = new SqlCommand(qry, conn);
                sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                UserGV.DataSource = ds;
                UserGV.DataBind();
                conn.Close();
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }


        protected void updateBtn_Click(object sender, EventArgs e)
        {
            string itemId = hiddenItemId.Value;
            try
            { 
                if(txtfirstName.Text == string.Empty || txtlastName.Text == string.Empty || txtEmail.Text == string.Empty || txtPassword.Text == string.Empty || 
                    txtPhone.Text == string.Empty || txtRole.Text == string.Empty || txtAddress.Text == string.Empty)
                {
                    msg.Text = "Select the user!";
                }
                else
                {
                    funcon();

                    String qry = "UPDATE Users SET FirstName=@firstname, LastName=@lastname, Email=@email, PhoneNumber=@phone, Role=@role, Address=@address WHERE UserId=@id";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("@firstname", txtfirstName.Text);
                    cmd.Parameters.AddWithValue("@lastname", txtlastName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@role", txtRole.SelectedValue);
                    cmd.Parameters.AddWithValue("@address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@id", itemId);

                    int res = cmd.ExecuteNonQuery();
                    if (res > 0)
                    {
                        msg.Text = "Data Update!";
                        txtfirstName.ReadOnly = false;
                        txtlastName.ReadOnly = false;
                        txtPassword.ReadOnly = false;
                        txtPassword.Text = string.Empty;
                        txtfirstName.Text = string.Empty;
                        txtlastName.Text = string.Empty;
                        txtEmail.Text = string.Empty;
                        txtPhone.Text = string.Empty;
                        txtRole.SelectedIndex = 0;
                        txtAddress.Text = string.Empty;
                        hiddenItemId.Value = string.Empty;
                    }
                    else
                    {
                        msg.Text = "Data not Update!";
                        conn.Close();
                    }
                    fungrid();
                }
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string itemId = btn.CommandArgument;

            //msg.Text = itemId + " is clicked";
            try
            {
                funcon();
                string qry = "SELECT FirstName, LastName, Email, PhoneNumber, Role, Address FROM Users WHERE UserId=@id";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@id", itemId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtfirstName.Text = dr["FirstName"].ToString();
                    txtlastName.Text = dr["LastName"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["PhoneNumber"].ToString();
                    txtRole.SelectedValue = dr["Role"].ToString();
                    txtAddress.Text = dr["Address"].ToString();

                    hiddenItemId.Value = itemId.ToString();

                    txtfirstName.ReadOnly = true;
                    txtlastName.ReadOnly = true;
                    txtPassword.Text = "●●●●●●●●";
                    txtPassword.ReadOnly = true;
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
            //msg.Text = "Delete button is clicked!";
            LinkButton btn = (LinkButton)sender;
            string itemId = btn.CommandArgument;

            try
            {
                funcon();
                String qry = "DELETE FROM Users WHERE UserId=@id";
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

        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TableCell addressCell = e.Row.Cells[6];
                string address = addressCell.Text;
                if (address.Length > 10)
                {
                    addressCell.Text = address.Substring(0, 10) + "......";
                }

                TableCell phoneCell = e.Row.Cells[4];
                string phoneNumber = phoneCell.Text;
                if (phoneNumber.Length > 4)
                {
                    phoneCell.Text = phoneNumber.Substring(0, 4) + "********";
                }

                TableCell emailCell = e.Row.Cells[3];
                string email = emailCell.Text;
                if (email.Length > 7)
                {
                    emailCell.Text = email.Substring(0, 7) + "*****" + "@gmail.com";
                }
            }
        }

        protected void searchInput_TextChanged(object sender, EventArgs e)
        {
            try
            {
                string search = searchInput.Text;

                funcon();
                String qry = "SELECT * from Users WHERE FIrstName LIKE @search + '%'";
                cmd = new SqlCommand(qry, conn);
                cmd.Parameters.AddWithValue("@search", search);
                sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                UserGV.DataSource = ds;
                UserGV.DataBind();
                conn.Close();
            }
            catch (Exception ex)
            {
                //Response.Write("Error");
                msg.Text = ex.ToString();
            }
        }

        protected void btnAddUser_Click1(object sender, EventArgs e)
        {
            Response.Redirect("~/FOS/Register.aspx");
        }
    }
}