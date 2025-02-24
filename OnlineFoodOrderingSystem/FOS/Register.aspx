<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Register" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Create Account</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        .password-strength-meter {
            height: 4px;
            transition: all 0.3s ease;
        }

        .strength-weak {
            width: 33.33%;
            background-color: #EF4444;
        }

        .strength-medium {
            width: 66.66%;
            background-color: #F59E0B;
        }

        .strength-strong {
            width: 100%;
            background-color: #10B981;
        }
        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        #btnSignin {
            background-color: #FEA116;
            cursor: pointer;
        }
    </style>
</head>

<body class="min-h-screen bg-gray-50">
    <div class="flex flex-col min-h-screen">
        <main class="flex-grow flex items-center justify-center px-4 py-12">
            <div class="w-full max-w-[480px] bg-white rounded-lg shadow-lg p-8">
                <div class="text-center mb-8">
                    <h1 class="font-['Pacifico'] text-3xl mb-2 text-primary"><img src="../Asset/Library/img/logo.jpg" height="60px" width="60px" alt=""></h1>
                    <h2 class="text-2xl font-semibold text-gray-800 mb-2">
                        Create Account
                    </h2>
                    <p class="text-gray-600">Join us today and start your journey</p>
                </div>

                <form id="registrationForm" class="space-y-6" runat="server">
                    <div class="message text-center flex flex-col items-center">
                        <asp:Label ID="msg" runat="server" ForeColor="red"></asp:Label>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                            <div class="relative">
                                <asp:TextBox ID="txtfirstName" runat="server" 
                                    class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                    placeholder="Enter first name" required></asp:TextBox>
                                <div class="hidden absolute right-3 top-1/2 -translate-y-1/2 text-green-500">
                                    <i class="ri-check-line"></i>
                                </div>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                            <div class="relative">
                                <asp:TextBox ID="txtlastName" runat="server"
                                    class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                    placeholder="Enter last name" required></asp:TextBox>
                                <div class="hidden absolute right-3 top-1/2 -translate-y-1/2 text-green-500">
                                    <i class="ri-check-line"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                        <div class="relative">
                            <asp:TextBox ID="txtEmail" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                placeholder="name@example.com" required TextMode="Email"></asp:TextBox>
                            <div class="hidden absolute right-3 top-1/2 -translate-y-1/2 text-green-500">
                                <i class="ri-check-line"></i>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                        <div class="relative">
                            <asp:TextBox ID="txtPassword" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                placeholder="Create a strong password" required></asp:TextBox>
                            <button type="button" id="togglePassword"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500">
                                <i class="ri-eye-line"></i>
                            </button>
                        </div>
                        <div class="mt-2">
                            <div class="password-strength-meter bg-gray-200 rounded-full"></div>
                            <div class="mt-2 text-xs text-gray-500">
                                Password must contain:
                                <ul class="mt-1 space-y-1">
                                    <li id="lengthCheck">
                                        <i class="ri-checkbox-blank-circle-line mr-1"></i>At least
                                        8 characters
                                    </li>
                                    <li id="upperCheck">
                                        <i class="ri-checkbox-blank-circle-line mr-1"></i>One
                                        uppercase letter
                                    </li>
                                    <li id="numberCheck">
                                        <i class="ri-checkbox-blank-circle-line mr-1"></i>One
                                        number
                                    </li>
                                    <li id="specialCheck">
                                        <i class="ri-checkbox-blank-circle-line mr-1"></i>One
                                        special character
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Mobile Number</label>
                        <div class="relative">
                            <asp:TextBox ID="txtMobile" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                placeholder="+1 (555) 000-0000" required></asp:TextBox>
                            <div class="hidden absolute right-3 top-1/2 -translate-y-1/2 text-green-500">
                                <i class="ri-check-line"></i>
                            </div>
                        </div>
                    </div>

                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" rows="3"
                            class="w-full px-4 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                            placeholder="Enter your full address" required TextMode="MultiLine"></asp:TextBox>
                    </div>

                    <div class="flex items-start">
                        <div class="flex items-center h-5">
                            <input id="txtTerms" type="checkbox"
                                class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary"
                                required />
                            <%--<asp:CheckBox ID="txtTerms" runat="server" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary" required />--%>
                        </div>
                        <label for="terms" class="ml-2 text-sm text-gray-600">
                            I agree to the
                            <a href="#" class="text-primary hover:underline">Terms of Service</a>
                            and
                            <a href="Privacy_Policy.aspx" class="text-primary hover:underline">Privacy Policy</a>
                        </label>
                    </div>

                    <asp:Button ID="btnSignin" runat="server" Text="Create Account" OnClick="btnSignin_Click"
                        class="w-full bg-primary text-white py-3 px-4 !rounded-button hover:bg-primary/90 transition-colors font-medium" />
                </form>

                <p class="mt-6 text-center text-sm text-gray-600">
                    Already have an account?
                    <a href="Login.aspx" class="text-primary hover:underline font-medium">Sign in</a>
                </p>
            </div>
        </main>

        <footer class="py-6 bg-gray-50">
            <div class="text-center text-sm text-gray-600">
                <p>&copy; 2025 logo. All rights reserved.</p>
                <div class="mt-2 space-x-4">
                    <a href="#" class="hover:text-primary">Terms of Service</a>
                    <a href="Privacy_Policy.aspx" class="hover:text-primary">Privacy Policy</a>
                    <a href="Contact.aspx" class="hover:text-primary">Contact Us</a>
                </div>
            </div>
        </footer>
    </div>
    
    <script>
        const form = document.getElementById("registrationForm");
        const passwordInput = document.getElementById("txtPassword");
        const togglePassword = document.getElementById("togglePassword");
        const strengthMeter = document.querySelector(".password-strength-meter");
        const successModal = document.getElementById("successModal");

        const validatePassword = (password) => {
            const checks = {
                length: password.length >= 8,
                upper: /[A-Z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[^A-Za-z0-9]/.test(password),
            };

            document.getElementById("lengthCheck").firstElementChild.className =
                checks.length
                    ? "ri-checkbox-circle-fill text-green-500"
                    : "ri-checkbox-blank-circle-line";
            document.getElementById("upperCheck").firstElementChild.className =
                checks.upper
                    ? "ri-checkbox-circle-fill text-green-500"
                    : "ri-checkbox-blank-circle-line";
            document.getElementById("numberCheck").firstElementChild.className =
                checks.number
                    ? "ri-checkbox-circle-fill text-green-500"
                    : "ri-checkbox-blank-circle-line";
            document.getElementById("specialCheck").firstElementChild.className =
                checks.special
                    ? "ri-checkbox-circle-fill text-green-500"
                    : "ri-checkbox-blank-circle-line";

            const strength = Object.values(checks).filter(Boolean).length;
            strengthMeter.className =
                "password-strength-meter " +
                (strength <= 2
                    ? "strength-weak"
                    : strength === 3
                        ? "strength-medium"
                        : "strength-strong");
        };

        passwordInput.addEventListener("input", (e) =>
            validatePassword(e.target.value),
        );

        togglePassword.addEventListener("click", () => {
            const type = passwordInput.type === "password" ? "text" : "password";
            passwordInput.type = type;
            togglePassword.innerHTML = `<i class="ri-eye${type === "password" ? "-line" : "-off-line"}"></i>`;
        });

        document
            .querySelectorAll('input:not([type="checkbox"])')
            .forEach((input) => {
                input.addEventListener("input", function () {
                    const checkIcon = this.parentElement.querySelector(".text-green-500");
                    if (this.value.length > 0) {
                        checkIcon?.classList.remove("hidden");
                    } else {
                        checkIcon?.classList.add("hidden");
                    }
                });
            });
    </script>
</body>

</html>