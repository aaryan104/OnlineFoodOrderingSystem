<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Login" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Adobe Garamon;
        }

        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            background-color: #f9f9f9;
            color: #333;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        section {
            width: 100%;
            padding: 1rem;
            text-align: center;
        }

        #login form {
            max-width: 400px;
            margin: auto;
            padding: 2rem;
            background: #fff;
            border-radius: 2vmin;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        #login form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        #login form input {
            width: 100%;
            font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        #login form #btn {
            width: 100%;
            margin-top: 5px;
            padding: 0.7rem;
            margin-top: 10px;
            background-color: #FEA116;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background 0.3s;
        }

        #login form #btn:hover {
            background-color: #e39115;
        }

        h1 {
            color: #FEA116;
            text-align: center;
            font-size: 2rem;
        }

        hr {
            border: 1px solid #FEA116;
            margin: 2vmin 1vmin;
        }

        h4 {
            margin: 10px;
            font-size: 1.05rem;
            font-weight: 100;
        }

        .Regi {
            text-decoration: none;
            font-size: 1.05rem;
            color: #FEA116;
        }

        .Regi:hover {
            color: #da8b14;
        }

        .FPass {
            text-decoration: none;
            font-size: 1.05rem;
            color: #FEA116;
            position: absolute;
            top: calc(100% - 210px);
            right: 20px;
        }

        .FPass:hover {
            color: #da8b14;
        }

        #Atag {
            text-decoration: none;
            display: inline-block;
            padding: 0.4rem 1.4rem;
            background-color: #FEA116;
            color: white;
            border-radius: 15px;
            font-size: 1rem;
            transition: background 0.3s ease;
        }

        #Atag:hover {
            background-color: #e39115;
        }

        #Atag .arrow {
            transition: font-size 0.3s ease;
        }

        .radio-container {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-bottom: 1rem;
        }

        .radio-container label {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 1rem;
        }

        .radio-container input[type="radio"] {
            transform: scale(1.1);
            transition: 0.8s ease;
        }

        .radio-container input[type="radio"]:hover {
            transform: scale(1.2);
        }

        #Restaurant {
            accent-color: red;
        }

        #Customer {
            accent-color: green;
        }

        #Delivery {
            accent-color: purple;
        }

        @media (max-width: 768px) {
            #login form {
                padding: 1.5rem;
                max-width: 90%;
            }

            h1 {
                font-size: 1.8rem;
            }

            #Atag {
                font-size: 0.8rem;
                padding: 0.4rem 1rem;
            }

            h4 {
                font-size: 0.85rem;
            }

            .FPass {
                font-size: 1.05rem;
                top: calc(100% - 200px);
                right: 15px;
            }

            .radio-container {
                gap: 10px;
            }
        }

        @media (max-width: 480px) {
            #login form {
                padding: 1rem;
                max-width: 95%;
            }

            h1 {
                font-size: 1.5rem;
            }

            #login form input {
                padding: 0.6rem;
                font-size: 0.9rem;
            }

            #login form #btn {
                padding: 0.6rem;
                font-size: 0.9rem;
            }

            #Atag {
                font-size: 0.75rem;
                padding: 0.4rem 0.8rem;
            }

            h4 {
                font-size: 0.8rem;
            }

            .FPass {
                font-size: 1rem;
                top: calc(100% - 180px);
                right: 10px;
            }

            .radio-container {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <section id="login">
        <form id="loginForm" runat="server">
            <h1>Login</h1>
            <hr>
            <asp:Label for="username" runat="server"></asp:Label>
            <asp:TextBox type="text" ID="username" runat="server" name="username" placeholder="USERNAME"></asp:TextBox>

            <asp:Label for="password" runat="server"></asp:Label>
            <asp:TextBox type="password" ID="password" runat="server" name="password" placeholder="PASSWORD"></asp:TextBox>
            
            <div class="radio-container">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" Height="80px" RepeatDirection="Horizontal" Width="400px">
                    <asp:ListItem value="Customer" id="Customer" Selected >Customer</asp:ListItem>
                    <asp:ListItem value="Restaurant" id="Restaurant">Restaurant</asp:ListItem>
                    <asp:ListItem Value="DeliveryAgent" id="Delivery">Delivery Agent</asp:ListItem>
                </asp:RadioButtonList>
            </div>          
            
            <a href="ForgotPassword.aspx" class="FPass">Forgot Password?</a>

            <asp:Button ID="btn" runat="server" Text="Login" OnClick="btn_Click" />
            <h4>Don't have an account? <a href="Register.aspx" class="Regi">Register</a></h4>
            <a href="Index.aspx" id="Atag" class="next round">
                <span class="arrow">&#8249;</span> GoBack
            </a>
        </form>
    </section>
</body>

</html>

