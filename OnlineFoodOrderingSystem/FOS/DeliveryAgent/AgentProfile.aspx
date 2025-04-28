<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentProfile.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.AgentProfile" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Profile - Delivery Agent Dashboard</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#6366f1" },
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
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .custom-checkbox {
            appearance: none;
            width: 1.25rem;
            height: 1.25rem;
            border: 2px solid #d1d5db;
            border-radius: 4px;
            position: relative;
            cursor: pointer;
            transition: all 0.2s;
        }

        .custom-checkbox:checked {
            background-color: #4f46e5;
            border-color: #4f46e5;
        }

        .custom-checkbox:checked::after {
            content: '';
            position: absolute;
            left: 6px;
            top: 2px;
            width: 5px;
            height: 10px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }

        .custom-switch {
            position: relative;
            display: inline-block;
            width: 3rem;
            height: 1.5rem;
        }

        .custom-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .switch-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #e5e7eb;
            transition: .4s;
            border-radius: 34px;
        }

        .switch-slider:before {
            position: absolute;
            content: "";
            height: 1.1rem;
            width: 1.1rem;
            left: 0.2rem;
            bottom: 0.2rem;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .switch-slider {
            background-color: #FEA116;
        }

        input:checked + .switch-slider:before {
            transform: translateX(1.5rem);
        }
    </style>
</head>

<body class="bg-gray-50 min-h-screen">
    <!-- Header -->
    <header class="bg-white shadow-sm py-4 px-6 flex items-center justify-between">
        <div class="flex items-center space-x-4">
            <a href="#" class="flex items-center">
                <span class="text-2xl font-['Pacifico'] text-primary">Kastabhanjan</span>
            </a>
        </div>

    </header>
    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 py-8">
        <!-- Back Button -->
        <div class="mb-6">
            <a href="DeliveryAgentDashboard.aspx" class="inline-flex items-center text-gray-600 hover:text-primary transition-colors">
                <i class="ri-arrow-left-line ri-lg mr-2"></i>
                <span>Back to Dashboard</span>
            </a>
        </div>
        <!-- Profile Header Card -->
        <div class="bg-white rounded shadow-sm p-8 mb-8 relative">
            <button id="editProfileBtn"
                class="absolute top-6 right-6 text-primary hover:text-primary/80 flex items-center space-x-1 !rounded-button">
                <i class="ri-edit-line ri-lg"></i>
                <span class="whitespace-nowrap">Edit Profile</span>
            </button>
            <div class="flex flex-col md:flex-row items-center">
                <div class="flex flex-col items-center mb-6 md:mb-0 md:mr-10">
                    <div class="w-32 h-32 rounded-full overflow-hidden mb-4 border-4 border-primary/10">
                        <asp:Image ID="imgProfile" runat="server" CssClass="rounded-full w-32 h-32" />
                    </div>
                    <h2 class="text-2xl font-bold text-gray-800"><asp:Label ID="lblName" runat="server" CssClass="text-2xl font-bold text-gray-800"></asp:Label></h2>
                    <div class="flex items-center mt-1 mb-2">
                        <span class="w-3 h-3 rounded-full mr-2 
                            <%= lblStatus.Text.ToLower() == "active" ? "bg-green-500" : 
                                (lblStatus.Text.ToLower() == "inactive" ? "bg-red-500" : "bg-gray-500") %>"></span>
                        <span class="font-medium 
                            <%= lblStatus.Text.ToLower() == "active" ? "text-green-600" : 
                                (lblStatus.Text.ToLower() == "inactive" ? "text-red-600" : "text-gray-600") %>">
                            <asp:Label ID="lblStatus" runat="server"></asp:Label>
                        </span>
                    </div>
                    <p class="text-gray-500">ID: #<asp:Label ID="lblID" runat="server" CssClass="text-gray-500"></asp:Label></p>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 flex-1">
                    <div>
                        <h3 class="text-gray-500 mb-1">Email</h3>
                        <p class="text-gray-800 font-medium">
                            <asp:Label ID="lblEmail" runat="server" CssClass="text-gray-800 font-medium"></asp:Label>
                        </p>
                    </div>
                    <div>
                        <h3 class="text-gray-500 mb-1">Phone</h3>
                        <p class="text-gray-800 font-medium"><asp:Label ID="lblPhone" runat="server" CssClass="text-gray-800 font-medium"></asp:Label></p>
                    </div>
                    <div>
                        <h3 class="text-gray-500 mb-1">Address</h3>
                        <p class="text-gray-800 font-medium"><asp:Label ID="lblAddress" runat="server" CssClass="text-gray-800 font-medium"></asp:Label></p>
                    </div>
                    <div>
                        <h3 class="text-gray-500 mb-1">Vehical Number</h3>
                        <p class="text-gray-800 font-medium"><asp:Label ID="lblVehicle" runat="server" CssClass="text-gray-800 font-medium"></asp:Label></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Performance Metrics -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded shadow-sm p-6">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-gray-500">Total Deliveries</h3>
                    <div class="w-10 h-10 flex items-center justify-center text-primary bg-primary/10 rounded-full">
                        <i class="ri-box-3-line ri-lg"></i>
                    </div>
                </div>
                <p class="text-3xl font-bold text-gray-800">1,287</p>
                <p class="text-green-600 text-sm mt-2 flex items-center">
                    <i class="ri-arrow-up-line ri-sm mr-1"></i>
                    <span>12% from last month</span>
                </p>
            </div>
            <div class="bg-white rounded shadow-sm p-6">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-gray-500">On-time Rate</h3>
                    <div class="w-10 h-10 flex items-center justify-center text-primary bg-primary/10 rounded-full">
                        <i class="ri-time-line ri-lg"></i>
                    </div>
                </div>
                <p class="text-3xl font-bold text-gray-800">98.7%</p>
                <p class="text-green-600 text-sm mt-2 flex items-center">
                    <i class="ri-arrow-up-line ri-sm mr-1"></i>
                    <span>1.2% from last month</span>
                </p>
            </div>
            <div class="bg-white rounded shadow-sm p-6">
                <div class="flex items-center justify-between mb-4">
                    <h3 class="text-gray-500">Average Rating</h3>
                    <div class="w-10 h-10 flex items-center justify-center text-primary bg-primary/10 rounded-full">
                        <i class="ri-star-line ri-lg"></i>
                    </div>
                </div>
                <p class="text-3xl font-bold text-gray-800">4.92</p>
                <div class="flex items-center mt-2">
                    <div class="flex">
                        <i class="ri-star-fill text-yellow-400"></i>
                        <i class="ri-star-fill text-yellow-400"></i>
                        <i class="ri-star-fill text-yellow-400"></i>
                        <i class="ri-star-fill text-yellow-400"></i>
                        <i class="ri-star-half-fill text-yellow-400"></i>
                    </div>
                    <span class="text-gray-500 text-sm ml-2">(432 reviews)</span>
                </div>
            </div>
        </div>
        <!-- Account Details -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-8">
            <!-- Personal Information -->
            <div class="bg-white rounded shadow-sm p-6">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold text-gray-800">Personal Information
                    </h2>
                </div>
                <div class="space-y-4">
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Full Name</h3>
                        <asp:Label ID="lblFullname" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Contact Number</h3>
                        <asp:Label ID="lblPhonenumber" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Email Address</h3>
                        <asp:Label ID="lblMail" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Home Address</h3>
                        <asp:Label ID="lblAdd" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Emergency Contact</h3>
                        <asp:Label ID="Label1" runat="server" CssClass="text-gray-800" Text="+91 9601292692"></asp:Label>
                    </div>
                </div>
            </div>
            <!-- Employment Details -->
            <div class="bg-white rounded shadow-sm p-6">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-bold text-gray-800">Employment Details</h2>
                </div>
                <div class="space-y-4">
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Employee ID</h3>
                        #<asp:Label ID="lblIds" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Working Area</h3>
                        <asp:Label ID="lblAddres" runat="server" CssClass="text-gray-800" Text="****"></asp:Label>
                    </div>
                    <div>
                        <h3 class="text-sm text-gray-500 mb-1">Supervisor</h3>
                        <asp:Label ID="Label2" runat="server" CssClass="text-gray-800" Text="Shivam Dholeriya"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <!-- Recent Feedback -->
        <div class="bg-white rounded shadow-sm p-6 mb-8">
            <h2 class="text-xl font-bold text-gray-800 mb-6">Recent Customer Feedback
            </h2>
            <div class="space-y-6">
                <div class="border-b border-gray-100 pb-6">
                    <div class="flex items-center justify-between mb-2">
                        <div class="flex items-center">
                            <div class="flex mr-2">
                                <i class="ri-star-fill text-yellow-400"></i>
                                <i class="ri-star-fill text-yellow-400"></i>
                                <i class="ri-star-fill text-yellow-400"></i>
                                <i class="ri-star-fill text-yellow-400"></i>
                                <i class="ri-star-fill text-yellow-400"></i>
                            </div>
                            <span class="font-medium text-gray-800">Emily Wilson</span>
                        </div>
                        <span class="text-sm text-gray-500">April 14, 2025</span>
                    </div>
                    <p class="text-gray-600">
                        "James was incredibly professional and friendly. He delivered my
                        package ahead of schedule and even helped carry it inside.
                        Exceptional service!"
                    </p>
                </div>
            </div>
        </div>
        <!-- Account Settings -->
        <div class="bg-white rounded shadow-sm p-6">
            <h2 class="text-xl font-bold text-gray-800 mb-6">Account Settings</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                <button id="changePasswordBtn"
                    class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded hover:border-primary hover:bg-primary/5 transition-colors !rounded-button whitespace-nowrap">
                    <div class="w-12 h-12 flex items-center justify-center text-primary mb-2">
                        <i class="ri-lock-password-line ri-xl"></i>
                    </div>
                    <span class="text-gray-800 font-medium">Change Password</span>
                </button>
                <!-- Password Change Modal -->
                <div id="passwordChangeModal"
                    class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
                    <div class="bg-white rounded-lg w-full max-w-md mx-4 relative">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-bold text-gray-800">Change Password</h2>
                            <button id="closePasswordModal"
                                class="absolute top-6 right-6 text-gray-400 hover:text-gray-600">
                                <i class="ri-close-line ri-lg"></i>
                            </button>
                        </div>
                        <form id="passwordChangeForm" class="p-6">
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2"
                                        for="currentPassword">
                                        Current Password</label>
                                    <div class="relative">
                                        <input type="password" id="currentPassword"
                                            class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                                            required />
                                        <button type="button"
                                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 toggle-password">
                                            <i class="ri-eye-line"></i>
                                        </button>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2" for="newPassword">
                                        New
                                        Password</label>
                                    <div class="relative">
                                        <input type="password" id="newPassword"
                                            class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                                            required />
                                        <button type="button"
                                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 toggle-password">
                                            <i class="ri-eye-line"></i>
                                        </button>
                                    </div>
                                    <div class="mt-2 text-sm text-gray-500">
                                        Password must contain:
                                        <ul class="list-disc list-inside space-y-1">
                                            <li id="lengthCheck" class="text-gray-400">At least 8 characters
                                            </li>
                                            <li id="upperCheck" class="text-gray-400">One uppercase letter
                                            </li>
                                            <li id="lowerCheck" class="text-gray-400">One lowercase letter
                                            </li>
                                            <li id="numberCheck" class="text-gray-400">One number
                                            </li>
                                            <li id="specialCheck" class="text-gray-400">One special character
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2"
                                        for="confirmPassword">
                                        Confirm New Password</label>
                                    <div class="relative">
                                        <input type="password" id="confirmPassword"
                                            class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                                            required />
                                        <button type="button"
                                            class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 toggle-password">
                                            <i class="ri-eye-line"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200 mt-6">
                                <button type="button" id="cancelPasswordChange"
                                    class="px-6 py-2 border border-gray-300 text-gray-700 rounded hover:bg-gray-50 !rounded-button">
                                    Cancel
                                </button>
                                <button type="submit"
                                    class="px-6 py-2 bg-primary text-white rounded hover:bg-primary/90 !rounded-button">
                                    Change Password
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <button id="notificationSettingsBtn"
                    class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded hover:border-primary hover:bg-primary/5 transition-colors !rounded-button whitespace-nowrap">
                    <div class="w-12 h-12 flex items-center justify-center text-primary mb-2">
                        <i class="ri-notification-4-line ri-xl"></i>
                    </div>
                    <span class="text-gray-800 font-medium">Notification Settings</span>
                </button>
                <!-- Notification Settings Modal -->
                <div id="notificationSettingsModal"
                    class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
                    <div class="bg-white rounded-lg w-full max-w-2xl mx-4 relative">
                        <div class="p-6 border-b border-gray-200">
                            <h2 class="text-xl font-bold text-gray-800">Notification Settings
                            </h2>
                            <button id="closeNotificationModal"
                                class="absolute top-6 right-6 text-gray-400 hover:text-gray-600">
                                <i class="ri-close-line ri-lg"></i>
                            </button>
                        </div>
                        <form id="notificationSettingsForm" class="p-6">
                            <div class="space-y-6">
                                <div>
                                    <h3 class="text-lg font-medium text-gray-800 mb-4">Notification Types
                                    </h3>
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">New Delivery Assignments
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Get notified when new deliveries are assigned to you
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" checked />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">Customer Feedback
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Receive notifications for new customer ratings and
                                                    reviews
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" checked />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">Payment Updates
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Get notified about earnings and payment transfers
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" checked />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="border-t border-gray-200 pt-6">
                                    <h3 class="text-lg font-medium text-gray-800 mb-4">Notification Channels
                                    </h3>
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">In-App Notifications
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Push notifications in the mobile app
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" checked />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">Email Notifications
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Receive updates via email
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" checked />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">SMS Notifications
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    Get text messages for important updates
                                                </p>
                                            </div>
                                            <label class="custom-switch">
                                                <input type="checkbox" />
                                                <span class="switch-slider"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="border-t border-gray-200 pt-6">
                                    <h3 class="text-lg font-medium text-gray-800 mb-4">Notification Frequency
                                    </h3>
                                    <div class="space-y-4">
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">Delivery Updates
                                                </h4>
                                                <p class="text-sm text-gray-500">
                                                    How often would you like to receive delivery
                                                    updates?
                                                </p>
                                            </div>
                                            <select
                                                class="px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary">
                                                <option value="realtime">Real-time</option>
                                                <option value="hourly">Hourly</option>
                                                <option value="daily">Daily Summary</option>
                                            </select>
                                        </div>
                                        <div class="flex items-center justify-between">
                                            <div>
                                                <h4 class="font-medium text-gray-800">Quiet Hours</h4>
                                                <p class="text-sm text-gray-500">
                                                    Don't send notifications during these hours
                                                </p>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <input type="time"
                                                    class="px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                                                    value="22:00" />
                                                <span class="text-gray-500">to</span>
                                                <input type="time"
                                                    class="px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
                                                    value="07:00" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200 mt-6">
                                <button type="button" id="cancelNotificationSettings"
                                    class="px-6 py-2 border border-gray-300 text-gray-700 rounded hover:bg-gray-50 !rounded-button">
                                    Cancel
                                </button>
                                <button type="submit"
                                    class="px-6 py-2 bg-primary text-white rounded hover:bg-primary/90 !rounded-button">
                                    Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <button
                    class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded hover:border-primary hover:bg-primary/5 transition-colors !rounded-button whitespace-nowrap">
                    <div class="w-12 h-12 flex items-center justify-center text-primary mb-2">
                        <i class="ri-shield-user-line ri-xl"></i>
                    </div>
                    <span class="text-gray-800 font-medium">Privacy Settings</span>
                </button>
                <button
                    class="flex flex-col items-center justify-center p-4 border border-gray-200 rounded hover:border-primary hover:bg-primary/5 transition-colors !rounded-button whitespace-nowrap">
                    <div class="w-12 h-12 flex items-center justify-center text-primary mb-2">
                        <i class="ri-global-line ri-xl"></i>
                    </div>
                    <span class="text-gray-800 font-medium">Language Preferences</span>
                </button>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Monthly Performance Chart
            const monthlyPerformanceChart = echarts.init(
                document.getElementById("monthlyPerformanceChart"),
            );
            const monthlyPerformanceOption = {
                animation: false,
                tooltip: {
                    trigger: "axis",
                    backgroundColor: "rgba(255, 255, 255, 0.8)",
                    textStyle: {
                        color: "#1f2937",
                    },
                },
                grid: {
                    top: 10,
                    right: 10,
                    bottom: 20,
                    left: 50,
                },
                xAxis: {
                    type: "category",
                    data: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
                    axisLine: {
                        lineStyle: {
                            color: "#e5e7eb",
                        },
                    },
                    axisLabel: {
                        color: "#6b7280",
                    },
                },
                yAxis: {
                    type: "value",
                    axisLine: {
                        show: false,
                    },
                    axisLabel: {
                        color: "#6b7280",
                    },
                    splitLine: {
                        lineStyle: {
                            color: "#f3f4f6",
                        },
                    },
                },
                series: [
                    {
                        name: "Deliveries",
                        type: "bar",
                        data: [165, 178, 195, 220, 241, 288],
                        itemStyle: {
                            color: "rgba(87, 181, 231, 1)",
                            borderRadius: 4,
                        },
                    },
                ],
            };
            monthlyPerformanceChart.setOption(monthlyPerformanceOption);
            // Delivery Trends Chart
            const deliveryTrendsChart = echarts.init(
                document.getElementById("deliveryTrendsChart"),
            );
            const deliveryTrendsOption = {
                animation: false,
                tooltip: {
                    trigger: "axis",
                    backgroundColor: "rgba(255, 255, 255, 0.8)",
                    textStyle: {
                        color: "#1f2937",
                    },
                },
                grid: {
                    top: 10,
                    right: 10,
                    bottom: 20,
                    left: 50,
                },
                xAxis: {
                    type: "category",
                    data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                    axisLine: {
                        lineStyle: {
                            color: "#e5e7eb",
                        },
                    },
                    axisLabel: {
                        color: "#6b7280",
                    },
                },
                yAxis: {
                    type: "value",
                    axisLine: {
                        show: false,
                    },
                    axisLabel: {
                        color: "#6b7280",
                    },
                    splitLine: {
                        lineStyle: {
                            color: "#f3f4f6",
                        },
                    },
                },
                series: [
                    {
                        name: "On-time Rate",
                        type: "line",
                        data: [98.2, 97.8, 99.1, 98.5, 99.3, 97.9, 98.7],
                        smooth: true,
                        symbol: "none",
                        lineStyle: {
                            color: "rgba(141, 211, 199, 1)",
                            width: 3,
                        },
                        areaStyle: {
                            color: {
                                type: "linear",
                                x: 0,
                                y: 0,
                                x2: 0,
                                y2: 1,
                                colorStops: [
                                    {
                                        offset: 0,
                                        color: "rgba(141, 211, 199, 0.2)",
                                    },
                                    {
                                        offset: 1,
                                        color: "rgba(141, 211, 199, 0.05)",
                                    },
                                ],
                            },
                        },
                    },
                    {
                        name: "Rating",
                        type: "line",
                        data: [4.8, 4.9, 5.0, 4.9, 4.8, 4.9, 5.0],
                        smooth: true,
                        symbol: "none",
                        lineStyle: {
                            color: "rgba(251, 191, 114, 1)",
                            width: 3,
                        },
                        areaStyle: {
                            color: {
                                type: "linear",
                                x: 0,
                                y: 0,
                                x2: 0,
                                y2: 1,
                                colorStops: [
                                    {
                                        offset: 0,
                                        color: "rgba(251, 191, 114, 0.2)",
                                    },
                                    {
                                        offset: 1,
                                        color: "rgba(251, 191, 114, 0.05)",
                                    },
                                ],
                            },
                        },
                    },
                ],
            };
            deliveryTrendsChart.setOption(deliveryTrendsOption);
            // Resize charts when window resizes
            window.addEventListener("resize", function () {
                monthlyPerformanceChart.resize();
                deliveryTrendsChart.resize();
            });
        });
    </script>
    <!-- Edit Profile Modal -->
    <div id="editProfileModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg w-full max-w-2xl mx-4 relative">
            <div class="p-6 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-800">Edit Profile</h2>
                <button id="closeModal" class="absolute top-6 right-6 text-gray-400 hover:text-gray-600">
                    <i class="ri-close-line ri-lg"></i>
                </button>
            </div>
            <form runat="server" id="editProfileForm" class="p-6">
                <div class="message text-center flex flex-col items-center">
                    <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                </div>
                <div class="mb-6">
                    <div class="flex items-center justify-center mb-4">
                        <div class="relative">
                            <div class="w-32 h-32 rounded-full overflow-hidden border-4 border-primary/10">
                                <asp:Image ID="profilePreview" runat="server" CssClass="w-full h-full object-cover" />
                            </div>
                            <label for="profilePicture"
                                class="absolute bottom-0 right-0 w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center cursor-pointer">
                                <i class="ri-camera-line"></i>
                            </label>
                            <asp:FileUpload ID="profilePicture" runat="server" class="hidden" accept="image/*" />
                        </div>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2" for="fullName">First Name</label>
                            <asp:TextBox ID="firstName" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2" for="fullName">Last Name</label>
                            <asp:TextBox ID="lastName" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2" for="email">
                                Email Address</label>
                            <asp:TextBox ID="email" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2" for="phone">Phone Number</label>
                            <asp:TextBox ID="phone" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2" for="workingArea">
                                Working
                                Area Address</label>
                            <asp:DropDownList ID="workingArea" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary">
                                <asp:ListItem>-- Select area --</asp:ListItem>
                                <asp:ListItem>Katargam. Surat</asp:ListItem>
                                <asp:ListItem>Adajan, Surat</asp:ListItem>
                                <asp:ListItem>Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Nana Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Mota Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Kamrej, Surat</asp:ListItem>
                                <asp:ListItem>Vesu, Surat</asp:ListItem>
                                <asp:ListItem>New Katargam, Surat</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="flex justify-end space-x-4 pt-4 border-t border-gray-200">
                    <button type="button" id="cancelEdit"
                        class="px-6 py-2 border border-gray-300 text-gray-700 rounded hover:bg-gray-50 !rounded-button">
                        Cancel
                    </button>
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" 
                        class="px-6 py-2 bg-primary text-white rounded hover:bg-primary/90 !rounded-button" OnClick="btnSave_Click"/>
                </div>
            </form>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const changePasswordBtn = document.getElementById("changePasswordBtn");
            const passwordChangeModal = document.getElementById("passwordChangeModal");
            const closePasswordModal = document.getElementById("closePasswordModal");
            const cancelPasswordChange = document.getElementById("cancelPasswordChange");
            const passwordChangeForm = document.getElementById("passwordChangeForm");
            const newPasswordInput = document.getElementById("newPassword");
            const confirmPasswordInput = document.getElementById("confirmPassword");
            // Password validation checks
            const lengthCheck = document.getElementById("lengthCheck");
            const upperCheck = document.getElementById("upperCheck");
            const lowerCheck = document.getElementById("lowerCheck");
            const numberCheck = document.getElementById("numberCheck");
            const specialCheck = document.getElementById("specialCheck");
            function showPasswordModal() {
                passwordChangeModal.classList.remove("hidden");
                passwordChangeModal.classList.add("flex");
                document.body.style.overflow = "hidden";
            }
            function hidePasswordModal() {
                passwordChangeModal.classList.add("hidden");
                passwordChangeModal.classList.remove("flex");
                document.body.style.overflow = "";
                passwordChangeForm.reset();
                resetValidationChecks();
            }
            function resetValidationChecks() {
                [lengthCheck, upperCheck, lowerCheck, numberCheck, specialCheck].forEach(
                    (check) => {
                        check.classList.remove("text-green-500");
                        check.classList.add("text-gray-400");
                    },
                );
            }
            function validatePassword(password) {
                const checks = {
                    length: password.length >= 8,
                    upper: /[A-Z]/.test(password),
                    lower: /[a-z]/.test(password),
                    number: /[0-9]/.test(password),
                    special: /[!@#$%^&*(),.?":{}|<>]/.test(password),
                };
                lengthCheck.classList.toggle("text-green-500", checks.length);
                lengthCheck.classList.toggle("text-gray-400", !checks.length);

                upperCheck.classList.toggle("text-green-500", checks.upper);
                upperCheck.classList.toggle("text-gray-400", !checks.upper);

                lowerCheck.classList.toggle("text-green-500", checks.lower);
                lowerCheck.classList.toggle("text-gray-400", !checks.lower);

                numberCheck.classList.toggle("text-green-500", checks.number);
                numberCheck.classList.toggle("text-gray-400", !checks.number);

                specialCheck.classList.toggle("text-green-500", checks.special);
                specialCheck.classList.toggle("text-gray-400", !checks.special);
                return Object.values(checks).every((check) => check);
            }
            newPasswordInput.addEventListener("input", () => {
                validatePassword(newPasswordInput.value);
            });
            // Toggle password visibility
            document.querySelectorAll(".toggle-password").forEach((button) => {
                button.addEventListener("click", function () {
                    const input = this.parentElement.querySelector("input");
                    const icon = this.querySelector("i");

                    if (input.type === "password") {
                        input.type = "text";
                        icon.classList.remove("ri-eye-line");
                        icon.classList.add("ri-eye-off-line");
                    } else {
                        input.type = "password";
                        icon.classList.remove("ri-eye-off-line");
                        icon.classList.add("ri-eye-line");
                    }
                });
            });
            changePasswordBtn.addEventListener("click", showPasswordModal);
            closePasswordModal.addEventListener("click", hidePasswordModal);
            cancelPasswordChange.addEventListener("click", hidePasswordModal);
            passwordChangeModal.addEventListener("click", (e) => {
                if (e.target === passwordChangeModal) {
                    hidePasswordModal();
                }
            });
           
            const notificationSettingsBtn = document.getElementById(
                "notificationSettingsBtn",
            );
            const notificationSettingsModal = document.getElementById(
                "notificationSettingsModal",
            );
            const closeNotificationModal = document.getElementById(
                "closeNotificationModal",
            );
            const cancelNotificationSettings = document.getElementById(
                "cancelNotificationSettings",
            );
            const notificationSettingsForm = document.getElementById(
                "notificationSettingsForm",
            );
            function showNotificationModal() {
                notificationSettingsModal.classList.remove("hidden");
                notificationSettingsModal.classList.add("flex");
                document.body.style.overflow = "hidden";
            }
            function hideNotificationModal() {
                notificationSettingsModal.classList.add("hidden");
                notificationSettingsModal.classList.remove("flex");
                document.body.style.overflow = "";
            }
            notificationSettingsBtn.addEventListener("click", showNotificationModal);
            closeNotificationModal.addEventListener("click", hideNotificationModal);
            cancelNotificationSettings.addEventListener("click", hideNotificationModal);
            notificationSettingsModal.addEventListener("click", (e) => {
                if (e.target === notificationSettingsModal) {
                    hideNotificationModal();
                }
            });
            notificationSettingsForm.addEventListener("submit", (e) => {
                e.preventDefault();
                const successModal = document.createElement("div");
                successModal.className =
                    "fixed inset-0 flex items-center justify-center z-50";
                successModal.innerHTML = `
                    <div class="bg-white rounded-lg p-6 shadow-xl max-w-sm mx-4">
                    <div class="text-green-500 mb-4">
                    <i class="ri-checkbox-circle-line ri-2x"></i>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">Success!</h3>
                    <p class="text-gray-600 mb-4">Your notification preferences have been updated successfully.</p>
                    <button class="w-full px-4 py-2 bg-primary text-white rounded hover:bg-primary/90 !rounded-button">OK</button>
                    </div>
                `;
                document.body.appendChild(successModal);
                successModal.querySelector("button").onclick = () => {
                    successModal.remove();
                    hideNotificationModal();
                };
            });
            const editProfileBtn = document.getElementById("editProfileBtn");
            const editProfileModal = document.getElementById("editProfileModal");
            const closeModal = document.getElementById("closeModal");
            const cancelEdit = document.getElementById("cancelEdit");
            const editProfileForm = document.getElementById("editProfileForm");
            const profilePicture = document.getElementById("profilePicture");
            const profilePreview = document.getElementById("profilePreview");
            function showModal() {
                editProfileModal.classList.remove("hidden");
                editProfileModal.classList.add("flex");
                document.body.style.overflow = "hidden";
            }
            function hideModal() {
                editProfileModal.classList.add("hidden");
                editProfileModal.classList.remove("flex");
                document.body.style.overflow = "";
            }
            editProfileBtn.addEventListener("click", showModal);
            closeModal.addEventListener("click", hideModal);
            cancelEdit.addEventListener("click", hideModal);
            editProfileModal.addEventListener("click", (e) => {
                if (e.target === editProfileModal) {
                    hideModal();
                }
            });
            profilePicture.addEventListener("change", (e) => {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        profilePreview.src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        });
    </script>
</body>

</html>
