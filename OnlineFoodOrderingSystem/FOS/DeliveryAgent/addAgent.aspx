<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addAgent.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.addAgent" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Delivery Agent Sign Up</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input:focus,
        textarea:focus,
        select:focus {
            outline: none;
            border-color: #FEA116;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .file-input-label {
            cursor: pointer;
            overflow: hidden;
            position: relative;
        }

        .file-input {
            position: absolute;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
            width: 100%;
            height: 100%;
        }

        .profile-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            background-color: #f3f4f6;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
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
    <div class="w-full max-w-2xl py-8">
        <div class="text-center mb-8">
            <h1 class="font-['Pacifico'] text-primary text-4xl mb-2">Delivero</h1>
            <h2 class="text-xl font-semibold text-gray-800">
                Delivery Agent Sign Up
            </h2>
            <div class="h-1 w-24 bg-primary mx-auto mt-3 rounded-full"></div>
        </div>
        <div class="bg-white rounded-lg shadow-lg p-8">
            <form runat="server">
                <div class="message text-center flex flex-col items-center">
                    <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                </div>
                <div class="flex flex-col md:flex-row gap-6 mb-6">
                    <div class="flex flex-col items-center">
                        <div class="profile-preview mb-2" id="profilePreview">
                            <i class="ri-user-3-line text-gray-400 ri-3x"></i>
                        </div>
                        <label class="file-input-label px-3 py-2 bg-gray-100 text-gray-700 rounded text-sm font-medium hover:bg-gray-200 transition">
                            Upload Photo
                            <asp:FileUpload ID="profilePhoto" runat="server" class="file-input" accept="image/*" />
                        </label>
                    </div>
                    <div class="flex-1">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="firstName" class="block text-sm font-medium text-gray-700 mb-2">First Name
                                    <span class="text-red-500">*</span></label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                        <i class="ri-user-line text-gray-400"></i>
                                    </div>
                                    <asp:TextBox ID="firstName" runat="server"
                                        class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter first name"></asp:TextBox>
                                </div>
                            </div>
                            <div>
                                <label for="lastName" class="block text-sm font-medium text-gray-700 mb-2">Last Name
                                    <span class="text-red-500">*</span></label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                        <i class="ri-user-line text-gray-400"></i>
                                    </div>
                                    <asp:TextBox ID="lastName" runat="server" 
                                        class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter last name"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mb-5">
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                        Email Address <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                            <i class="ri-mail-line text-gray-400"></i>
                        </div>
                        <asp:TextBox ID="email" runat="server" 
                            class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter your email"></asp:TextBox>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-5">
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700 mb-2">Password <span
                                class="text-red-500">*</span></label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-lock-line text-gray-400"></i>
                            </div>
                            <asp:TextBox ID="password" runat="server"
                                class="w-full pl-10 pr-10 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Create password"></asp:TextBox>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 w-10 h-full flex items-center justify-center cursor-pointer" id="togglePassword">
                                <i class="ri-eye-off-line text-gray-400" id="passwordIcon"></i>
                            </div>
                        </div>
                        <p class="text-xs text-gray-500 mt-1">
                            Must be at least 8 characters with letters and numbers
                        </p>
                    </div>
                    <div>
                        <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">
                            Confirm Password <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-lock-line text-gray-400"></i>
                            </div>
                            <asp:TextBox ID="confirmPassword" runat="server"
                                class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Confirm password"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-5">
                    <div>
                        <label for="phoneNumber" class="block text-sm font-medium text-gray-700 mb-2">
                            Phone Number <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-phone-line text-gray-400"></i>
                            </div>
                            <asp:TextBox ID="phoneNumber" runat="server"
                                class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter phone number"></asp:TextBox>
                        </div>
                    </div>
                    <div>
                        <label for="status" class="block text-sm font-medium text-gray-700 mb-2">
                            Status <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-user-settings-line text-gray-400"></i>
                            </div>
                            <asp:DropDownList ID="status" runat="server" 
                                class="w-full pl-10 pr-8 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary appearance-none bg-white">
                                <asp:ListItem>-- Select --</asp:ListItem>
                                <asp:ListItem>Active</asp:ListItem>
                                <asp:ListItem>Inactive</asp:ListItem>
                            </asp:DropDownList>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-arrow-down-s-line text-gray-400"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-5">
                    <div>
                        <label for="vehicleNumber" class="block text-sm font-medium text-gray-700 mb-2">
                            Vehicle Number <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none w-10 h-full flex items-center justify-center">
                                <i class="ri-car-line text-gray-400"></i>
                            </div>
                            <asp:TextBox ID="vehicleNumber" runat="server"
                                class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter vehicle number"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="mb-6">
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-2">
                        Address <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <div class="absolute top-3 left-0 flex items-start pl-3 pointer-events-none w-10 flex items-center justify-center">
                            <i class="ri-map-pin-line text-gray-400"></i>
                        </div>
                        <asp:TextBox ID="address" runat="server" rows="3"
                            class="w-full pl-10 pr-3 py-3 border border-gray-300 rounded text-gray-700 focus:border-primary" placeholder="Enter your full address"></asp:TextBox>
                    </div>
                </div>
                <div class="mb-6">
                    <label class="flex items-center">
                        <div class="relative h-5 w-5 mr-2">
                            <input type="checkbox" id="termsCheckbox" class="opacity-0 absolute h-5 w-5 cursor-pointer" required />
                            <div class="bg-white border border-gray-300 rounded h-5 w-5 flex flex-shrink-0 justify-center items-center focus-within:border-primary">
                                <svg class="fill-current hidden w-3 h-3 text-primary pointer-events-none" viewBox="0 0 20 20">
                                    <path d="M0 11l2-2 5 5L18 3l2 2L7 18z" />
                                </svg>
                            </div>
                        </div>
                        <span class="text-sm text-gray-700">I agree to the
                            <a href="#" class="text-primary hover:underline">Terms of Service</a>
                            and
                            <a href="../Privacy_Policy.aspx" class="text-primary hover:underline">Privacy Policy</a>
                        </span>
                    </label>
                </div>
                <asp:Button ID="signupButton" runat="server" Text="Create Account"
                    class="w-full bg-primary text-white py-3 rounded-button font-medium hover:bg-primary/90 transition duration-200 whitespace-nowrap flex items-center justify-center" OnClick="signupButton_Click" />
                <div class="text-center mt-6 text-sm">
                    <p class="text-gray-700">
                        Already have an account?
                        <a href="AgentLogin.aspx" data-readdy="true" class="text-primary hover:text-primary/80 transition">Login</a>
                    </p>
                </div>
            </form>
        </div>
        <div class="text-center mt-6 text-gray-600 text-sm">
            <p>© 2025 Delivero. All rights reserved.</p>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const signupForm = document.getElementById("signupForm");
            const signupButton = document.getElementById("signupButton");
            const profilePhotoInput = document.getElementById("profilePhoto");
            const profilePreview = document.getElementById("profilePreview");
            const passwordInput = document.getElementById("password");
            const togglePassword = document.getElementById("togglePassword");
            const passwordIcon = document.getElementById("passwordIcon");
            const termsCheckbox = document.getElementById("termsCheckbox");

            profilePhotoInput.addEventListener("change", function (e) {
                if (e.target.files.length > 0) {
                    const file = e.target.files[0];
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        profilePreview.innerHTML = `<img src="${e.target.result}" alt="Profile Preview" class="w-full h-full object-cover">`;
                    };
                    reader.readAsDataURL(file);
                }
            });

            togglePassword.addEventListener("click", function () {
                const type =
                    passwordInput.getAttribute("type") === "password" ? "text" : "password";
                passwordInput.setAttribute("type", type);
                if (type === "password") {
                    passwordIcon.className = "ri-eye-off-line text-gray-400";
                } else {
                    passwordIcon.className = "ri-eye-line text-gray-400";
                }
            });

            termsCheckbox.addEventListener("change", function () {
                const checkmark = this.nextElementSibling.querySelector("svg");
                if (this.checked) {
                    checkmark.classList.remove("hidden");
                } else {
                    checkmark.classList.add("hidden");
                }
            });
        });
    </script>
</body>

</html>