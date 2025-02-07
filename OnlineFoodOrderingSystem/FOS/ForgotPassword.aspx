<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.ForgotPassword" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <style>
        #send, #verify, #resetPassword {
            background-color: #FEA116;
        }

        #send:hover, #verify:hover, #resetPassword:hover {
            background-color: #e39115;
        }

        #Atag {
            text-decoration: none;
            display: inline-block;
            padding: 0.5rem 1.5rem;
            background-color: #FEA116;
            color: white;
            border-radius: 20px;
            font-size: 1.1rem;
            transition: background 0.3s ease;
        }

        #Atag:hover {
            background-color: #e39115;
        }

        #Atag .arrow {
            transition: font-size 0.3s ease;
        }
    </style>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex items-center justify-center h-screen bg-gray-100">
    <form runat="server">
        <div class="bg-white p-6 rounded-lg shadow-md w-96" id="forgotPasswordForm">
            <h2 class="text-xl font-semibold mb-4 text-center">Forgot Password</h2>
            <div id="step1">
                <label class="block mb-2 text-sm font-medium text-gray-700">Enter Mobile Number</label>
                <asp:TextBox type="text" ID="mobileNumber" runat="server" class="w-full p-2 border rounded mb-4" placeholder="Enter your mobile number"></asp:TextBox>
                <button id="send" type="button" onclick="sendOTP()" class="w-full text-white p-2 rounded">Send OTP</button>
                <%--<asp:Button ID="sendOTP" OnClientClick="return sendOTP();" runat="server" Text="Send OTP" class="w-full text-white p-2 rounded" />--%>
                <div class="text-center mt-4">
                    <a href="Login.aspx" id="Atag" class="next round inline-block">
                        <span class="arrow">&#8249;</span> GoBack
                    </a>
                </div>
            </div>

            <div id="step2" class="hidden">
                <label class="block mb-2 text-sm font-medium text-gray-700">Enter OTP</label>
                <asp:TextBox type="text" ID="otp" runat="server" class="w-full p-2 border rounded mb-4" placeholder="Enter OTP"></asp:TextBox>
                <button id="verify" type="button" onclick="verifyOTP()" class="w-full text-white p-2 rounded">Verify OTP</button>
                <%--<asp:Button ID="verifyOTP" OnClientClick="return verifyOTP();" runat="server" Text="Verify OTP" class="w-full text-white p-2 rounded" />--%>
                <div class="text-center mt-4">
                    <a href="login.html" id="Atag" class="next round inline-block">
                        <span class="arrow">&#8249;</span> GoBack
                    </a>
                </div>
            </div>

            <div id="step3" class="hidden">
                <label class="block mb-2 text-sm font-medium text-gray-700">New Password</label>
                <asp:TextBox type="password" ID="newPassword" runat="server" class="w-full p-2 border rounded mb-4" placeholder="Enter new password"></asp:TextBox>
                <label class="block mb-2 text-sm font-medium text-gray-700">Confirm Password</label>
                <asp:TextBox type="password" ID="confirmPassword" runat="server" class="w-full p-2 border rounded mb-4" placeholder="Confirm new password"></asp:TextBox>
                <asp:Button ID="resetPassword" runat="server" Text="Reset Password" class="w-full text-white p-2 rounded" />
                <div class="text-center mt-4">
                    <a href="login.html" id="Atag" class="next round inline-block">
                        <span class="arrow">&#8249;</span> GoBack
                    </a>
                </div>
            </div>  
        </div>
    </form>
    <script>
        function sendOTP() {
            document.getElementById('step1').classList.add('hidden');
            document.getElementById('step2').classList.remove('hidden');
        }

        function verifyOTP() {
            document.getElementById('step2').classList.add('hidden');
            document.getElementById('step3').classList.remove('hidden');
        }
    </script>
</body>
</html>