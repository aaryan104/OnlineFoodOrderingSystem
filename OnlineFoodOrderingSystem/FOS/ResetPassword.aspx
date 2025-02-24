<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.ResetPassword" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Reset Password</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" />
        <style>
            :where([class^="ri-"])::before {
                content: "\f3c2";
            }

            .password-input::-ms-reveal,
            .password-input::-ms-clear {
                display: none;
            }

            input[type="password"]::-webkit-contacts-auto-fill-button,
            input[type="password"]::-webkit-credentials-auto-fill-button {
                visibility: hidden;
                display: none !important;
                pointer-events: none;
                height: 0;
                width: 0;
                margin: 0;
            }

            #btnReset,#btnDone {
                background-color: #FEA116;
                cursor: pointer;
            }

            img {
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
        </style>
    </head>

    <body class="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <div class="w-full max-w-md">
            <div class="bg-white rounded-lg shadow-2xl p-8">
                <img src="../Asset/Library/img/logo.jpg" height="60px" width="60px" />
                <div class="text-center mb-8">
                    <h1 class="text-2xl font-bold text-gray-900 mb-2">Reset Password</h1>
                    <p class="text-gray-600">Please enter your new password</p>
                </div>

                <form id="resetForm" class="space-y-6" runat="server">
                    <div class="message text-center flex flex-col items-center">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="red" Text=""></asp:Label>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2" for="password">New Password</label>
                        <div class="relative">
                            <asp:TextBox ID="txtPassword" type="password" runat="server" placeholder="New Password" name="password"
                                class="password-input w-full px-4 py-3 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                required ></asp:TextBox>
                            <button type="button"
                                class="password-toggle absolute right-3 top-1/2 -translate-y-1/2 w-6 h-6 flex items-center justify-center text-gray-500 hover:text-gray-700">
                                <i class="ri-eye-line text-lg"></i>
                            </button>
                        </div>
                        <p class="password-error mt-1 text-sm text-red-600 hidden">
                            Password must be at least 8 characters
                        </p>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2" for="confirmPassword">Confirm
                            Password</label>
                        <div class="relative">
                            <asp:TextBox ID="txtConfirmPassword" type="password" runat="server" placeholder="Confirm Password" name="confirmPassword" 
                                class="password-input w-full px-4 py-3 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm" 
                                required></asp:TextBox>
                            <button type="button"
                                class="password-toggle absolute right-3 top-1/2 -translate-y-1/2 w-6 h-6 flex items-center justify-center text-gray-500 hover:text-gray-700">
                                <i class="ri-eye-line text-lg"></i>
                            </button>
                        </div>
                        <p class="confirm-error mt-1 text-sm text-red-600 hidden">
                            Passwords do not match
                        </p>
                    </div>
                    <asp:Button ID="btnReset" runat="server" Text="Reset Password"
                        class="w-full bg-primary text-white py-3 px-4 !rounded-button hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors whitespace-nowrap flex items-center justify-center" OnClick="btnReset_Click" />
                    <div style="text-align: center">
                        <a href="Login.aspx" class="text-sm text-primary hover:text-primary/80 hover:underline">Back to Login</a>
                    </div>
                </form>
            </div>
            <div id="successModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                <div class="bg-white rounded-lg p-6 max-w-sm mx-4">
                    <div class="text-center">
                        <div class="w-12 h-12 rounded-full bg-green-100 mx-auto mb-4 flex items-center justify-center">
                            <i class="ri-check-line text-2xl text-green-500"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">
                            Password Reset Successful
                        </h3>
                        <p class="text-gray-600 mb-6">
                            Your password has been successfully reset.
                        </p>
                        <a id="btnDone" runat="server" href="Login.aspx"
                            class="w-full bg-primary text-white py-2 px-4 !rounded-button hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors whitespace-nowrap">
                            Go to Login
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const passwordInput = document.getElementById("<%= txtPassword.ClientID %>");
                const confirmInput = document.getElementById("<%= txtConfirmPassword.ClientID %>");
                const passwordError = document.querySelector(".password-error");
                const confirmError = document.querySelector(".confirm-error");
                const successModal = document.getElementById("successModal");

                function validatePassword() {
                    const password = passwordInput.value.trim();
                    const confirm = confirmInput.value.trim();
                    let isValid = true;

                    if (password.length < 8) {
                        passwordError.classList.remove("hidden");
                        passwordInput.classList.add("border-red-500");
                        isValid = false;
                    } else {
                        passwordError.classList.add("hidden");
                        passwordInput.classList.remove("border-red-500");
                    }

                    if (password !== confirm && confirm.length > 0) {
                        confirmError.classList.remove("hidden");
                        confirmInput.classList.add("border-red-500");
                        isValid = false;
                    } else {
                        confirmError.classList.add("hidden");
                        confirmInput.classList.remove("border-red-500");
                    }

                    return isValid;
                }

                passwordInput.addEventListener("input", validatePassword);
                confirmInput.addEventListener("input", validatePassword);

                document.querySelectorAll(".password-toggle").forEach(button => {
                    button.addEventListener("click", function () {
                        let passwordField = this.previousElementSibling;
                        let icon = this.querySelector("i");

                        if (passwordField.type === "password") {
                            passwordField.type = "text";
                            icon.classList.replace("ri-eye-line", "ri-eye-off-line");
                        } else {
                            passwordField.type = "password";
                            icon.classList.replace("ri-eye-off-line", "ri-eye-line");
                        }
                    });
                });
            });
        </script>
    </body>
</html>
