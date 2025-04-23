<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentLogin.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.AgentLogin" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Delivery Agent Login</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input:focus {
            outline: none;
            border-color: #FEA116;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#0F172A" },
                    borderRadius: {
                        none: "0px",
                        sm: "4px",
                        DEFAULT: "8px",
                        md: "12px",
                        lg: "16px",
                        xl: "20px",
                        "2xl": "24px",
                        "3xl": "32px",
                        full: "9999px",
                        button: "8px",
                    },
                },
            },
        };
    </script>
</head>

<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-md">
        <div class="text-center mb-8">
            <h1 class="font-['Pacifico'] text-primary text-4xl mb-2">Delivero</h1>
            <h2 class="text-xl font-semibold text-gray-800">
                Delivery Agent Login
            </h2>
            <div class="h-1 w-24 bg-primary mx-auto mt-3 rounded-full"></div>
        </div>
        <div class="bg-white rounded-lg shadow-lg p-8">
            <form id="loginForm" runat="server" class="space-y-6">
                <asp:Label ID="lblMessage" runat="server" ForeColor="red" Text=""></asp:Label>
                <div class="mb-6">
                    <div class="mb-8">
                        <a href="../Login.aspx" class="inline-flex items-center text-gray-600 hover:text-gray-900">
                            <i class="ri-arrow-left-line w-5 h-5"></i>
                            <span class="ml-2">Back</span>
                        </a>
                        <h1 class="text-2xl font-bold text-gray-900 mt-6" style="color:#0F172B;">Welcome back</h1>
                        <p class="text-gray-600 mt-2">Please enter your details to sign in</p>
                    </div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                    <div class="relative">
                        <div
                            class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                            <i class="ri-mail-line text-gray-400"></i>
                        </div>
                        <asp:TextBox ID="txtEmail" runat="server" 
                            class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter your email"></asp:TextBox>
                    </div>
                </div>
                <div class="mb-6">
                    <div class="flex justify-between mb-2">
                        <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    </div>
                    <div class="relative">
                        <div
                            class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                            <i class="ri-lock-line text-gray-400"></i>
                        </div>
                        <asp:TextBox ID="txtPass" runat="server"
                            class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter your password"></asp:TextBox>
                    </div>
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="Login" 
                    class="w-full bg-primary text-white py-3 rounded-button font-medium hover:bg-primary/90 transition duration-200 whitespace-nowrap flex items-center justify-center" OnClick="btnLogin_Click"/>
                <div class="flex justify-between mt-6 text-sm">
                    <a href="#" class="text-primary hover:text-primary/80 transition">Forgot Password?</a>
                    <a href="addAgent.aspx"
                        data-readdy="true" class="text-primary hover:text-primary/80 transition">Sign Up</a>
                </div>
            </form>
        </div>
        <div class="text-center mt-6 text-gray-600 text-sm">
            <p>© 2025 Delivero. All rights reserved.</p>
        </div>
    </div>
</body>

</html>