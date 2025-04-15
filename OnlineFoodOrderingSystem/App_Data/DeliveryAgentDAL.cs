using System.Data;
using System.Data.SqlClient;

public class DeliveryAgentDAL
{
    DBConnection db = new DBConnection();

    public DataTable GetOrdersByAgent(int agentId)
    {
        return db.ExecuteQuery("SELECT * FROM Orders WHERE AgentId = " + agentId);
    }

    public void UpdateOrderStatus(int orderId, string status)
    {
        db.ExecuteNonQuery("UPDATE Orders SET Status = '" + status + "' WHERE OrderId = " + orderId);
    }

    public string GetOrderStatus(int orderId)
    {
        DataTable dt = db.ExecuteQuery("SELECT Status FROM Orders WHERE OrderId = " + orderId);
        return dt.Rows[0]["Status"].ToString();
    }

    public void AddAgent(string name, string email, string password)
    {
        db.ExecuteNonQuery("INSERT INTO DeliveryAgents (Name, Email, Password) VALUES ('" + name + "', '" + email + "', '" + password + "')");
    }
}