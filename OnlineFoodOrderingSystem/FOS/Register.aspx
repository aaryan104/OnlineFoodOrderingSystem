<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Register" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        .error-message {
            display: none;
        }

        input:invalid+.error-message {
            display: block;
        }

        input:focus {
            outline: none;
        }

        #btnRegi, #verifyEmail, #regiDone {
            background-color: #FEA116;
            border-radius: 10px;
            cursor: pointer;
        }

        img {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>

<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-white p-8 rounded-lg shadow-lg">
        <div class="text-center">
            <img src="../Asset/Library/img/logo.jpg" alt="" height="60px" width="60px">
            <h2 class="mt-6 text-3xl font-extrabold text-gray-900">Create Account</h2>
            <p class="mt-2 text-sm text-gray-600">Join us today and start your journey</p>
        </div>
        <form class="mt-8 space-y-6" id="registrationForm" novalidate runat="server">
            <div class="message text-center flex flex-col items-center">
                <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
            <div class="space-y-4">
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700">First Name</label>
                        <asp:TextBox ID="txtfirstName" runat="server" 
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-button text-sm" placeholder="John"></asp:TextBox>
                        <span class="error-message text-red-500 text-xs mt-1">First name is required</span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700">Last Name</label>
                        <asp:TextBox ID="txtlastName" runat="server" 
                            class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-button text-sm"
                            placeholder="Doe"></asp:TextBox>
                        <span class="error-message text-red-500 text-xs mt-1">Last name is required</span>
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Email</label>
                    <div class="mt-1 flex">
                        <asp:TextBox ID="txtEmail" runat="server" 
                            class="block w-full px-3 py-2 bg-white border border-gray-300 rounded-l-button text-sm"
                            placeholder="you@example.com"></asp:TextBox>
                        <asp:Button ID="verifyEmail" runat="server" Text="Send Code"
                            class="ml-2 px-4 py-2 border border-transparent text-sm font-medium rounded-button text-white bg-primary hover:bg-primary/90 whitespace-nowrap" OnClick="verifyEmail_Click"/>
                    </div>
                    <span class="error-message text-red-500 text-xs mt-1">Please enter a valid email</span>
                </div>
                <div id="verificationCodeSection" class="hidden">
                    <label class="block text-sm font-medium text-gray-700">Verification Code</label>
                    <asp:TextBox ID="txtOtp" runat="server" maxlength="6"
                        class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-button text-sm"
                        placeholder="Enter 6-digit code" OnTextChanged="txtOtp_TextChanged"></asp:TextBox>
                    <span class="error-message text-red-500 text-xs mt-1">Please enter the verification code</span>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="mt-1 relative">
                        <asp:TextBox ID="txtPassword" runat="server"
                            class="block w-full px-3 py-2 bg-white border border-gray-300 rounded-button text-sm"
                            placeholder="••••••••"></asp:TextBox>
                        <button type="button" id="togglePassword"
                            class="absolute inset-y-0 right-0 px-3 flex items-center">
                            <i class="ri-eye-line text-gray-400"></i>
                        </button>
                    </div>
                    <div class="mt-1 text-xs text-gray-500">
                        Password must contain at least 8 characters, including uppercase, lowercase letters and numbers
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Phone Number</label>
                    <div class="mt-1 flex">
                        <select class="px-3 py-2 bg-white border border-gray-300 rounded-l-button text-sm">
                            <option>+91</option>
                            <option>+1</option>
                            <option>+92</option>
                            <option>+62</option>
                            <option>+76</option>
                            <option>+69</option>
                            <option>+86</option>
                        </select>
                        <asp:TextBox ID="txtMobile" runat="server"
                            class="block w-full px-3 py-2 bg-white border border-gray-300 rounded-r-button text-sm"
                            placeholder="(555) 000-0000"></asp:TextBox>
                    </div>
                    <span class="error-message text-red-500 text-xs mt-1">Please enter a valid phone number</span>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" 
                        class="mt-1 block w-full px-3 py-2 bg-white border border-gray-300 rounded-button text-sm"
                        placeholder="Start typing your address"></asp:TextBox>
                    <span class="error-message text-red-500 text-xs mt-1">Please enter your address</span>
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Profile Photo</label>
                    <div class="flex items-center space-x-4">
                        <label
                            class="flex items-center justify-center px-4 py-2 border border-gray-300 rounded-button cursor-pointer hover:bg-gray-50 !rounded-button">
                            <i class="ri-upload-2-line mr-2"></i>
                            <span class="text-sm">Upload Image</span>
                            <asp:FileUpload ID="txtUpload" runat="server" class="hidden" onchange="previewImage(event)" />
                        </label>
                        <div id="imagePreview" class="hidden w-16 h-16 rounded overflow-hidden">
                            <img src="" alt="Preview" class="w-full h-full object-cover" />
                        </div>
                    </div>
                </div>

                <div class="flex items-start">
                    <div class="flex items-center h-5">
                        <input type="checkbox" class="h-4 w-4 text-primary border-gray-300 rounded">
                    </div>
                    <div class="ml-3 text-sm">
                        <label class="font-medium text-gray-700">I agree to the <a href="#"
                                class="text-primary hover:text-primary/90">Terms of Service</a> and <a href="#"
                                class="text-primary hover:text-primary/90">Privacy Policy</a></label>
                    </div>
                </div>
            </div>
            <div class="flex gap-4">
                <asp:Button ID="btnRegi" runat="server" Text="Create Account" 
                    class="flex-1 flex justify-center py-2 px-4 border border-transparent rounded-button text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary whitespace-nowrap" OnClick="btnRegi_Click"/>
                <asp:Button ID="btnReset" runat="server" Text="Reset" 
                    class="flex-1 flex justify-center py-2 px-4 border border-gray-300 rounded-button text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 whitespace-nowrap" OnClick="btnReset_Click"/>
            </div>
        </form>
        <div class="text-center">
            <p class="text-sm text-gray-600">
                Already have an account?
                <a href="Login.aspx" class="font-medium text-primary hover:text-primary/90">Sign in</a>
            </p>
        </div>
    </div>
    <div id="successModal" class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg max-w-sm w-full mx-4">
            <div class="text-center">
                <i class="ri-checkbox-circle-line text-green-500 text-5xl"></i>
                <h3 class="mt-4 text-lg font-medium text-gray-900">Registration Successful!</h3>
                <p class="mt-2 text-sm text-gray-500">Your account has been created successfully.</p>
                <button id="regiDone" onclick="closeModal()"
                    class="mt-4 w-full inline-flex justify-center py-2 px-4 border border-transparent rounded-button text-sm font-medium text-white bg-primary hover:bg-primary/90 whitespace-nowrap">
                    Continue
                </button>
            </div>
        </div>
    </div>
    <script>
        function previewImage(event) {
            const preview = document.getElementById("imagePreview");
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.querySelector("img").src = e.target.result;
                    preview.classList.remove("hidden");
                };
                reader.readAsDataURL(file);
            }
        }

        const form = document.getElementById('registrationForm');
        const togglePasswordBtn = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('txtPassword');
        const successModal = document.getElementById('successModal');
        const submitForm = document.getElementById('btnRegi');

        togglePasswordBtn.addEventListener('click', () => {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            togglePasswordBtn.innerHTML = type === 'password' ?
                '<i class="ri-eye-line text-gray-400"></i>' :
                '<i class="ri-eye-off-line text-gray-400"></i>';
        });
        submitForm.addEventListener('click', () => {
            e.preventDefault();
            if (form.checkValidity()) {
                successModal.classList.remove('hidden');
            } else {
                form.reportValidity();
            }
        });
        function closeModal() {
            successModal.classList.add('hidden');
            window.location.href = '#';
        }

        const addressInput = document.getElementById('address');
        let timeout = null;
        addressInput.addEventListener('input', (e) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                if (e.target.value.length > 2) {
                    console.log('Searching address:', e.target.value);
                }
            }, 500);
        });
    </script>
</body>

</html>