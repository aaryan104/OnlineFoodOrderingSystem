<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.VerifyOTP" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        .otp-input::-webkit-outer-spin-button,
        .otp-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        #btnVerify {
            background-color: #FEA116;
            cursor: pointer;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4 sm:p-6">
    <form runat="server">
        <div class="max-w-md w-full bg-white rounded-lg shadow-lg p-4 sm:p-8">
            <div class="text-center mb-6 sm:mb-8">
                <h1 class="text-xl sm:text-2xl font-bold text-gray-900 mb-2">Enter OTP</h1>
                <p class="text-gray-600">
                    Please enter the 6-digit code sent to
                    <asp:Label ID="userEmail" runat="server"></asp:Label>
                    <%--<span id="userEmail">john.smith@example.com</span>--%>
                    <a href="ForgotPassword.aspx" class="text-primary hover:text-primary/80 ml-1 font-medium">Change</a>
                </p>
            </div>
            <div class="message text-center flex flex-col items-center" style="margin-bottom: 20px;">
                <asp:Label ID="lblMessage" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
            <div class="flex justify-center gap-1 sm:gap-2 mb-6 sm:mb-8">
                <asp:TextBox ID="input1" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
                <asp:TextBox ID="input2" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
                <asp:TextBox ID="input3" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
                <asp:TextBox ID="input4" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
                <asp:TextBox ID="input5" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
                <asp:TextBox ID="input6" runat="server" CssClass="otp-input w-12 h-12 text-center border-2 border-gray-300 rounded focus:border-primary focus:outline-none text-xl" MaxLength="1" />
            </div>
            <%--<asp:Button ID="btnVerify" runat="server" CssClass="/>--%>
            <asp:Button ID="btnVerify" runat="server" CssClass="w-full text-white py-3 rounded font-medium mb-4 hover:bg-primary/90 transition-colors disabled:opacity-50 disabled:cursor-not-allowed" Text="Verify" OnClick="btnVerify_Click1" />

            <div class="text-center">
                <asp:Button ID="resendBtn" runat="server" CssClass="text-primary hover:text-primary/80 font-medium disabled:opacity-50 disabled:cursor-not-allowed" Text="Resend OTP" Enabled="false" OnClick="resendBtn_Click" />
                <span id="timer" class="text-gray-500 ml-2">in 60s</span>
            </div>
        </div>
    </form>

    <script>
        const inputs = document.querySelectorAll(".otp-input");
        const verifyBtn = document.getElementById("verifyBtn");
        const resendBtn = document.getElementById("resendBtn");
        const timerSpan = document.getElementById("timer");
        let timerInterval;
        let timeLeft = 60;

        inputs.forEach((input, index) => {
            input.addEventListener("input", (e) => {
                if (e.target.value.length > 1) {
                    e.target.value = e.target.value.slice(0, 1);
                }
                if (e.target.value && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
                verifyBtn.disabled = !isOTPComplete();
            });
            input.addEventListener("keydown", (e) => {
                if (e.key === "Backspace" && !e.target.value && index > 0) {
                    inputs[index - 1].focus();
                }
            });
        });

        function isOTPComplete() {
            return Array.from(inputs).every((input) => input.value.length === 1);
        }

        function startTimer() {
            timeLeft = 60;
            resendBtn.disabled = true;
            timerInterval = setInterval(() => {
                timeLeft--;
                timerSpan.textContent = `in ${timeLeft}s`;
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    resendBtn.disabled = false;
                    timerSpan.textContent = "";
                }
            }, 1000);
        }

        startTimer();
    </script>
</body>
</html>
