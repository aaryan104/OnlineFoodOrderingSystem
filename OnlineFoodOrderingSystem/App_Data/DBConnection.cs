using System.Data;
using System.Data.SqlClient;

public class DBConnection
{
    private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConn"].ConnectionString;

    public DataTable ExecuteQuery(string query)
    {
        SqlDataAdapter da = new SqlDataAdapter(query, connectionString);
        DataTable dt = new DataTable();
        da.Fill(dt);
        return dt;
    }

    public void ExecuteNonQuery(string query)
    {
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(query, con);
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
}