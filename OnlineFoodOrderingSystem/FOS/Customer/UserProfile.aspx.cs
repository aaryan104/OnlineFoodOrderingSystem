using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace OnlineFoodOrderingSystem.FOS.Customer
{
    public partial class UserProfile : System.Web.UI.Page
    {
        SqlConnection conn;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        public static int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserIdFromEmail();
                if (Session["s_eml"] != null)
                {
                    string email = Session["s_eml"].ToString();
                    lblEmail.Text = email;
                    FetchUserData(email);
                    LoadUserData(email);
                    LoadOrders();
                }
                else
                {
                    Response.Redirect("~/FOS/Login.aspx");
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

            string query = @"SELECT 
                                o.OrderId, 
                                o.OrderDate, 
                                o.OrderStatus, 
                                o.TotalAmount,
                                ISNULL(SUM(od.Quantity), 0) AS ItemCount
                            FROM Orders o
                            LEFT JOIN OrderDetails od ON o.OrderId = od.OrderId
                            WHERE o.UserId = @UserId
                            GROUP BY o.OrderId, o.OrderDate, o.OrderStatus, o.TotalAmount
                            ORDER BY o.OrderDate DESC";

            cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }

        private void FetchUserData(string email)
        {
            try
            {
                string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(conStr))
                {
                    conn.Open();
                    string qry = "SELECT UserId, FirstName, PhoneNumber, Address, ImageURL FROM Users WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(qry, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            dt = new DataTable();
                            sda.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                lblId.Text = "UserId : #" + dt.Rows[0]["UserId"].ToString();
                                lblFullName.Text = dt.Rows[0]["FirstName"].ToString();
                                lblPhone.Text = dt.Rows[0]["PhoneNumber"].ToString();
                                lblAddress.Text = dt.Rows[0]["Address"].ToString();

                                string profileImg = dt.Rows[0]["ImageURL"].ToString();
                                if (!string.IsNullOrEmpty(profileImg))
                                {
                                    if (!profileImg.StartsWith("http"))
                                    {
                                        profileImg = "~/StoreImage/UserImage/" + profileImg;
                                    }
                                    imgProfile.ImageUrl = profileImg;
                                }
                                else
                                {
                                    imgProfile.ImageUrl = "~/Asset/Library/img/Default_Photo.jpg";
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        private void LoadUserData(string email)
        {
            string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT FirstName, LastName, PhoneNumber, Address FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtFirstname.Text = reader["FirstName"].ToString();
                    txtLastname.Text = reader["LastName"].ToString();
                    txtPhone.Text = reader["PhoneNumber"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            string email = Session["s_eml"].ToString();

            try
            {
                if (txtFirstname.Text == string.Empty || txtLastname.Text == string.Empty ||
                    txtPhone.Text == string.Empty || txtAddress.Text == string.Empty)
                {
                    msg1.Text = "Fill all items!";
                }
                else
                {
                    funcon();
                    String qry = "UPDATE Users SET FirstName=@firstname, LastName=@lastname, PhoneNumber=@phone, Address=@address WHERE Email=@email";
                    cmd = new SqlCommand(qry, conn);
                    cmd.Parameters.AddWithValue("@firstname", txtFirstname.Text);
                    cmd.Parameters.AddWithValue("@lastname", txtLastname.Text);
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@address", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@email", email);

                    int res = cmd.ExecuteNonQuery();
                    if (res > 0)
                    {
                        //msg.Text = "Data Update!";
                    }
                    else
                    {
                        msg.Text = "Data not Update! Please try again";
                        conn.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                msg.Text = ex.ToString();
            }
        }
    }
}
