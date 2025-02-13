<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.ResetPassword" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            height: 40%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
        }

        input {
            width: 95%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        #btnReset {
                width: 90%;
                padding: 10px;
                background-color: #FEA116;
                color: white;
                border: none;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                margin: 10px 0px;
        }

        #btnReset:hover {
            background-color: #e29013;
        }

        .back-btn {
            color: #FEA116;
            text-decoration: none;
            padding-top: 10px;
        }

        .back-btn:hover {
            color: #e29013;
        }
    </style>
</head>
<body>
    <div class="container">
        <form runat="server">
            <h2>Reset Password</h2>
            <asp:TextBox ID="txtPassword" type="password" runat="server" placeholder="New Password"></asp:TextBox>
            <asp:TextBox ID="txtConfirmPassword" type="password" runat="server" placeholder="Confirm Password"></asp:TextBox>
            <asp:Button ID="btnReset" runat="server" Text="Reset Password" OnClick="btnReset_Click1" />
            <a class="back-btn" href="Login.aspx">Back to Login?</a>
                <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="black" Text=""></asp:Label>
        </form>
    </div>
</body>
</html>