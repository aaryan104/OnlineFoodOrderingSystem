<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.FP" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        :where([class^="ri-"])::before { content: "\f3c2"; }
        .loading-spinner {
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        #submitButton {
            background-color: #FEA116;
            cursor: pointer;
        }
        #submitButton:hover {
            background-color: #e29013;
        }
    </style>
</head>
<body class="min-h-screen bg-gray-50 flex items-center justify-center p-4">
    <div class="w-full max-w-md">
        <div class="bg-white rounded-lg shadow-lg p-8">
        <div class="text-center mb-8">
            <h1 class="font-['Pacifico'] text-3xl text-primary mb-2"><img src="../Asset/Library/img/logo.jpg" height="60px" width="60px" /></h1>
        </div>
            <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-gray-900 mb-2">Forgot Password?</h2>
                <p class="text-gray-600">No worries! Enter your email and we'll send you reset instructions.</p>
            </div>
            <form id="forgotPasswordForm" class="space-y-6" runat="server">
                <div class="message text-center flex flex-col items-center">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="red" Text=""></asp:Label>
                    <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                </div>
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="ri-mail-line text-gray-400"></i>
                        </div>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-button text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Enter your email address" AutoPostBack="true"></asp:TextBox>
                    </div>
                    <p id="emailError" class="mt-1 text-sm text-red-600 hidden">Please enter a valid email address</p>
                </div>

                <asp:Button ID="submitButton" class="w-full flex items-center justify-center px-4 py-2 border border-transparent text-sm font-medium rounded-button text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary !rounded-button" runat="server" Text="Verify OTP" OnClick="submitButton_Click" />
               
            </form>
            <div id="successMessage" class="mt-4 p-4 bg-green-50 rounded-lg hidden">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <i class="ri-checkbox-circle-line text-green-400 text-xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-green-800">
                            Password reset instructions have been sent to your email.
                        </p>
                    </div>
                </div>
            </div>
            <div class="mt-6 text-center">
                <a href="Login.aspx" class="text-sm font-medium text-primary hover:text-primary/80">
                    Back to Login
                </a>
            </div>
        </div>
    </div>
</body>
</html>