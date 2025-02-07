<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Register" %>

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

        #Register form {
            max-width: 400px;
            margin: auto;
            padding: 2rem;
            background: #fff;
            border-radius: 2vmin;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        #Register form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        #Register form input {
            width: 100%;
            font-family: Cambria, Cochin, Georgia, Times, 'Times New Roman', serif;
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        #Register form #btn {
            width: 100%;
            margin-top: 5px;
            padding: 0.7rem;
            background-color: #FEA116;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background 0.3s;
        }

        #Register form #btn:hover {
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

        #chk {
            text-align: left;
        }

        @media (max-width: 768px) {
            #Register form {
                padding: 1.5rem;
                max-width: 90%;
            }

            h1 {
                font-size: 1.8rem;
            }

            h4 {
                font-size: 0.85rem;
            }
        }

        @media (max-width: 480px) {
            #Register form {
                padding: 1rem;
                max-width: 95%;
            }

            h1 {
                font-size: 1.5rem;
            }

            #Register form input {
                padding: 0.6rem;
                font-size: 0.9rem;
            }

            #Register form #btn {
                padding: 0.6rem;
                font-size: 0.9rem;
            }
            h4 {
                font-size: 0.8rem;
            }

        }
    </style>
</head>

<body>
    <section id="Register">
        <form id="RegisterForm" runat="server">
            <h1>Register</h1>
            <hr>
            <label for="username"></label>
            <asp:TextBox type="text" ID="username" runat="server" name="username" placeholder="USERNAME"></asp:TextBox>
            
            <label for="email"></label>
            <asp:TextBox type="email" ID="email" runat="server" name="email" placeholder="EMAIL"></asp:TextBox>
            
            <label for="mobile"></label>
            <asp:TextBox type="number" ID="mobile" runat="server" name="mobile" placeholder="MOBILE"></asp:TextBox>

            <label for="password"></label>
            <asp:TextBox type="password" ID="password" runat="server" name="password" placeholder="PASSWORD"></asp:TextBox>

            <label for="conPassword"></label>
            <asp:TextBox type="text" ID="conPassword" runat="server" name="conPassword" placeholder="CONFORM PASSWORD"></asp:TextBox>

            <asp:Button ID="btn" runat="server" Text="Register" OnClick="btn_Click" />
            <h4>You have an account? <a href="Login.aspx" class="Regi">Login</a></h4>
        </form>
    </section>
</body>

</html>
