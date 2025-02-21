﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
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
            height: 35%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 10px;
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

        #btnSend {
            width: 90%;
            padding: 10px;
            background-color: #FEA116;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin: 12px 0px;
        }

        #btnSend:hover {
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

        label, #lblMessage {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
            <label id="msg" runat="server"></label>
        <form runat="server">
            <h2>Forgot Password</h2>
            <asp:TextBox type="email" ID="txtEmail" runat="server" placeholder="Enter your email"></asp:TextBox>
            <asp:Button ID="btnSend" runat="server" Text="Send OTP" OnClick="btnSend_Click" />
            <a class="back-btn" href="Login.aspx">Back to Login?</a>
                <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </form>
    </div>
</body>
</html>
