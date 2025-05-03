<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateStatus.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.updateStatus" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Update Delivery Status</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        .custom-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236b7280'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 1rem;
        }

        .hidden {
            display: none;
        }

        .transition-all {
            transition: all 0.3s ease;
        }
    </style>
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
</head>

<body class="bg-gray-50 min-h-screen">
    <div class="max-w-3xl mx-auto px-4 py-8">
        <header class="mb-8">
            <div class="flex items-center justify-between">
                <h1 class="text-3xl font-bold text-gray-900">
                    Update Delivery Status
                </h1>
                <div class="font-['Pacifico'] text-primary text-2xl">
                    <img src="../../Asset/Library/img/logo.jpg" class="h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14" alt="Logo" /></span>
                </div>
            </div>
            <div class="h-0.5 bg-gray-100 mt-4"></div>
        </header>

        <main>
            <div class="bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                <form id="updateStatusForm" runat="server">
                    <!-- Order ID Input -->
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                     <div class="mb-6">
                        <a href="DeliveryAgentDashboard.aspx" class="inline-flex items-center text-gray-600 hover:text-gray-900">
                            <i class="ri-arrow-left-line w-5 h-5"></i>
                            <span class="ml-2">Back</span>
                        </a>
                    </div>
                    <div class="mb-6">
                        <label for="orderId" class="block text-sm font-medium text-gray-700 mb-2">Order ID</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                    <i class="ri-shopping-bag-line"></i>
                                </div>
                            </div>
                            <asp:TextBox ID="orderNumber" runat="server"
                                class="block w-full pl-10 pr-4 py-3 border-gray-200 border rounded focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition" placeholder="Enter order ID"></asp:TextBox>
                        </div>
                        <p id="orderIdValidation" class="mt-1 text-sm text-gray-500">
                            Please enter a valid order ID
                        </p>
                    </div>

                    <!-- Status Selection -->
                    <div class="mb-6">
                        <label for="status" class="block text-sm font-medium text-gray-700 mb-2">Current Status</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                    <i class="ri-truck-line"></i>
                                </div>
                            </div>

                            <asp:DropDownList ID="status" runat="server"
                                class="custom-select block w-full pl-10 pr-10 py-3 border-gray-200 border rounded focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition">
                                <asp:ListItem>-- Select Status --</asp:ListItem>
                                <asp:ListItem>Cancelled</asp:ListItem>
                                <asp:ListItem>Delay</asp:ListItem>
                                <asp:ListItem>Out for Delivery</asp:ListItem>
                                <asp:ListItem>Delivered</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Conditional Fields Based on Status -->
                    <div id="deliveredFields" class="mb-6 hidden transition-all">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="receiverName" class="block text-sm font-medium text-gray-700 mb-2">Receiver
                                    Name</label>
                                <asp:TextBox ID="receiverName" runat="server"
                                    class="block w-full px-4 py-3 border-gray-200 border rounded focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition" placeholder="Who received the package"></asp:TextBox>
                            </div>
                            <div>
                                <label for="deliveryTime" class="block text-sm font-medium text-gray-700 mb-2">Delivery
                                    Time</label>
                                <asp:TextBox ID="deliveryTime" runat="server" class="block w-full px-4 py-3 border-gray-200 border rounded focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition" TextMode="Time"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div id="delayedFields" class="mb-6 hidden transition-all">
                        <div>
                            <label for="delayReason" class="block text-sm font-medium text-gray-700 mb-2">Reason for
                                Delay</label>
                            <asp:DropDownList ID="delayReason" runat="server"
                                class="custom-select block w-full px-4 py-3 border-gray-200 border rounded focus:ring-2 focus:ring-primary/20 focus:border-primary outline-none transition">
                                <asp:ListItem>Select Reason</asp:ListItem>
                                <asp:ListItem>Weather Conditions</asp:ListItem>
                                <asp:ListItem>Heavy Traffic</asp:ListItem>
                                <asp:ListItem>Vehicle Issues</asp:ListItem>
                                <asp:ListItem>High Delivery Volume</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                                
                        </div>
                    </div>

                    <!-- Photo Evidence (for Delivered status) -->
                    <div id="photoEvidenceField" class="mb-6 hidden transition-all">
                        <%--<label class="block text-sm font-medium text-gray-700 mb-2">Photo Evidence (Optional)</label>
                        <div class="border-2 border-dashed border-gray-200 rounded-lg p-6 text-center">
                            <div
                                class="w-12 h-12 mx-auto mb-4 flex items-center justify-center bg-gray-100 rounded-full">
                                <i class="ri-camera-line text-gray-400 ri-xl"></i>
                            </div>
                            <p class="text-sm text-gray-500 mb-2">
                                Drag and drop a photo here, or click to select
                            </p>
                            <button type="button" class="text-primary text-sm font-medium !rounded-button">
                                Upload Photo
                            </button>
                            <asp:FileUpload ID="photoUpload" runat="server" accept="image/*" class="hidden" />
                        </div>--%>
                    </div>

                    <!-- Location Confirmation -->
                    <div class="mb-6">
                        <div class="flex items-center">
                            <div class="w-5 h-5 flex items-center justify-center">
                                <input type="checkbox" id="confirmLocation" name="confirmLocation"
                                    class="w-4 h-4 text-primary border-gray-300 rounded focus:ring-primary" />
                            </div>
                            <label for="confirmLocation" class="ml-2 text-sm text-gray-700">
                                I confirm that I am at the correct delivery location
                            </label>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="mt-8">
                        <asp:Button ID="updateButton" runat="server" Text="Update Delivery Status" 
                            class="w-full bg-primary text-white py-3 px-6 rounded-button font-medium transition hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-primary/50 disabled:opacity-50 disabled:cursor-not-allowed whitespace-nowrap flex items-center justify-center" OnClick="updateButton_Click"/>
                    </div>
            </div>
            <div class="message text-center flex flex-col items-center  ">
                <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
            <!-- Status Update History -->
            <div class="mt-8 bg-white rounded-lg shadow-sm border border-gray-100 p-6">
                <h2 class="text-lg font-semibold text-gray-800 mb-4">
                    Recent Status Updates
                </h2>
                <div class="overflow-x-auto">
                    <asp:GridView ID="gvStatusUpdates" runat="server" AutoGenerateColumns="false"
                        CssClass="min-w-full divide-y divide-gray-200" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="OrderID" HeaderText="Order ID" 
                                HeaderStyle-CssClass="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-4 py-3 whitespace-nowrap text-sm text-gray-900" />
                    
                            <asp:TemplateField HeaderText="Status" 
                                HeaderStyle-CssClass="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-4 py-3 whitespace-nowrap">
                                <ItemTemplate>
                                    <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                        <%# Eval("Status").ToString() == "Delivered" ? "bg-green-100 text-green-800" : 
                                            Eval("Status").ToString() == "Delay" ? "bg-yellow-100 text-yellow-800" : 
                                            Eval("Status").ToString() == "Out for delivery" ? "bg-blue-100 text-blue-800" : 
                                            "bg-red-100 text-red-800" %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                    
                            <asp:BoundField DataField="Updated" HeaderText="Updated" 
                                HeaderStyle-CssClass="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-4 py-3 whitespace-nowrap text-sm text-gray-500" DataFormatString="{0:MMM dd, yyyy - hh:mm tt}" />

                            <asp:TemplateField HeaderText="Actions"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <ItemTemplate>
                                    <div class="flex justify-end space-x-2">
                                        <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("LogId") %>' 
                                            OnClientClick="return confirm('Are you sure you want to delete this Log?');" CssClass="text-red-500 hover:text-red-700 w-8 h-8 flex items-center justify-center">
                                            <i class="ri-delete-bin-line"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="bg-gray-50" />
                        <RowStyle CssClass="bg-white hover:bg-gray-50" />
                    </asp:GridView>
                </form>
                </div>
            </div>
        </main>

        <!-- Success Message Toast (Hidden by default) -->
        <div id="successToast"
            class="fixed bottom-4 right-4 bg-green-50 border-l-4 border-green-500 text-green-700 p-4 rounded shadow-md hidden transform transition-transform duration-300 ease-in-out">
            <div class="flex items-center">
                <div class="w-5 h-5 mr-2 flex items-center justify-center text-green-500">
                    <i class="ri-check-line"></i>
                </div>
                <p class="text-sm font-medium">Status updated successfully!</p>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const statusDropdown = document.getElementById("<%= status.ClientID %>");
            const deliveredFields = document.getElementById("deliveredFields");
            const delayedFields = document.getElementById("delayedFields");
            //const photoEvidenceField = document.getElementById("photoEvidenceField");
            const submitButton = document.getElementById("submitButton");
            const successToast = document.getElementById("successToast");
            //const uploadButton = document.querySelector("#photoEvidenceField button");
            //const fileUploadInput = document.getElementById("%= photoUpload.ClientID %>");

            deliveredFields.classList.add("hidden");
            delayedFields.classList.add("hidden");
            photoEvidenceField.classList.add("hidden");

            statusDropdown.addEventListener("change", function () {
                const selectedValue = this.value;

                deliveredFields.classList.add("hidden");
                delayedFields.classList.add("hidden");
                photoEvidenceField.classList.add("hidden");

                if (selectedValue === "Delivered")
                {
                    deliveredFields.classList.remove("hidden");
                    photoEvidenceField.classList.remove("hidden");
                }
                else if (selectedValue === "Delay")
                {
                    delayedFields.classList.remove("hidden");
                }
                //else if (selectedValue === "Cancelled") {
                //}
            });

            //if (uploadButton && fileUploadInput) {
            //    uploadButton.addEventListener("click", function () {
            //        fileUploadInput.click();
            //    });
            //}

            //if (fileUploadInput) {
            //    fileUploadInput.addEventListener("change", function () {
            //        if (this.files.length > 0) {
            //            uploadButton.textContent = this.files[0].name;
            //        }
            //    });
            //}

            if (submitButton) {
                submitButton.addEventListener("click", function (e) {
                    e.preventDefault();

                    successToast.classList.remove("hidden");
                    setTimeout(function () {
                        successToast.classList.add("hidden");
                    }, 3000);
                });
            }
        });
    </script>
</body>

</html>
