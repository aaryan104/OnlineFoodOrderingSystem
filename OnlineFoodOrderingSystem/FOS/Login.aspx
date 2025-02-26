<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Login" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        #btn {
            background-color: #FEA116;
            cursor: pointer;
        }

        #btn:hover {
            background-color: #e29013;
        }

        #SignUp {
            color: #0F172B;
            cursor: pointer;
        }

        #SignUp:hover {
            color: #1b2645;
        }

        .fp {
            color: #0F172B;
            cursor: pointer;
        }

        .fp:hover {
            color: #1b2645;
        }
    </style>
</head>

<body class="min-h-screen bg-gray-50 flex items-center justify-center p-4">
    <section class="w-full max-w-md" style="max-width:25rem;">
        <div class="bg-white rounded-lg shadow-lg p-8">
            <div class="mb-8">
                <a href="Index.aspx" class="inline-flex items-center text-gray-600 hover:text-gray-900">
                    <i class="ri-arrow-left-line w-5 h-5"></i>
                    <span class="ml-2">Back</span>
                </a>
                <h1 class="text-2xl font-bold text-gray-900 mt-6" style="color:#0F172B;">Welcome back</h1>
                <p class="text-gray-600 mt-2">Please enter your details to sign in</p>
            </div>

            <form id="loginForm" runat="server" class="space-y-6">
                <asp:Label ID="lblMessage" runat="server" ForeColor="red" Text=""></asp:Label>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                    <div class="relative">
                        <i class="ri-mail-line absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm" placeholder="Enter your email"></asp:TextBox>
                    </div>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
                    <div class="relative">
                        <i class="ri-lock-line absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                        <asp:TextBox ID="txtPass" runat="server" CssClass="block w-full pl-10 pr-10 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm" placeholder="Enter your password"></asp:TextBox>
                        <button type="button" id="togglePassword" class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400">
                            <i class="ri-eye-off-line"></i>
                        </button>
                    </div>
                </div>

                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <input type="checkbox" id="remember" class="h-4 w-4 text-primary focus:ring-primary border-gray-300 rounded">
                        <label for="remember" class="ml-2 block text-sm text-gray-700">Remember me</label>
                    </div>
                    <a href="ForgotPassword.aspx" class="fp text-sm font-medium text-primary hover:text-primary/80">Forgot password?</a>
                </div>

                <asp:Button ID="btn" runat="server" Text="Sign in" CssClass="w-full flex justify-center py-2 px-4 border border-solid rounded text-sm font-medium text-white hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary" OnClick="btn_Click" />

                <div class="text-center">
                    <p class="text-sm text-gray-600">
                        Don't have an account? 
                        <a ID="SignUp" href="Register.aspx" class="font-medium text-primary hover:text-primary/80">Sign up</a>
                    </p>
                </div>
            </form>
        </div>
    </section>

    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('<%= txtPass.ClientID %>');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.querySelector('i').className = type === 'password' ? 'ri-eye-off-line' : 'ri-eye-line';
        });
    </script>
</body>
</html>
