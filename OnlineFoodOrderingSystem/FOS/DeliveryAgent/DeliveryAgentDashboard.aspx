<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeliveryAgentDashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.DeliveryAgentDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Delivery Agent Dashboard</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#4B5563" },
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
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        body {
            font-family: 'Inter', sans-serif;
        }

        .custom-checkbox {
            appearance: none;
            width: 1.25rem;
            height: 1.25rem;
            border: 2px solid #d1d5db;
            border-radius: 4px;
            cursor: pointer;
            position: relative;
            transition: all 0.2s ease;
        }

        .custom-checkbox:checked {
            background-color: #FEA116;
            border-color: #FEA116;
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

        .custom-checkbox:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(254, 161, 22, 0.3);
        }

        @media (max-width: 768px) {
            .table-container {
                overflow-x: auto;
            }
        }

        .hs {
            margin-left: 100px;
        }

        .chk {
            margin-left: 15px;
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="min-h-screen flex flex-col">
        <header class="bg-white shadow-sm">
            <div class="flex items-center justify-between px-6 py-4">
                <div class="flex items-center gap-2">
                    <div class="w-10 h-10 flex items-center justify-center bg-primary rounded-full text-white">
                        <i class="ri-truck-line ri-lg"></i>
                    </div>
                    <h1 class="font-['Pacifico'] text-2xl text-gray-800">Kastabhanjan</h1>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative">
                        <div
                            class="w-10 h-10 flex items-center justify-center text-gray-500 hover:text-primary cursor-pointer">
                            <i class="ri-notification-3-line ri-lg"></i>
                        </div>
                        <span class="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full"></span>
                    </div>
                    <div class="relative" id="status-dropdown-container">
                        <button id="status-toggle"
                            class="px-3 py-1 rounded-full bg-green-100 text-green-600 text-sm font-medium flex items-center gap-1">
                            <span class="w-2 h-2 bg-green-500 rounded-full"></span>
                            <span id="current-status">Active</span>
                            <i class="ri-arrow-down-s-line ml-1"></i>
                        </button>
                        <div id="status-menu"
                            class="hidden absolute right-0 mt-2 w-40 bg-white rounded shadow-lg border border-gray-100 py-1 z-50">
                            <button class="w-full px-4 py-2 text-sm text-left hover:bg-gray-50 flex items-center gap-2"
                                data-status="active" data-color="green">
                                <span class="w-2 h-2 bg-green-500 rounded-full"></span>
                                <span>Active</span>
                            </button>
                            <button class="w-full px-4 py-2 text-sm text-left hover:bg-gray-50 flex items-center gap-2"
                                data-status="offline" data-color="gray">
                                <span class="w-2 h-2 bg-gray-500 rounded-full"></span>
                                <span>Offline</span>
                            </button>
                            <button class="w-full px-4 py-2 text-sm text-left hover:bg-gray-50 flex items-center gap-2"
                                data-status="busy" data-color="red">
                                <span class="w-2 h-2 bg-red-500 rounded-full"></span>
                                <span>Inactive</span>
                            </button>
                        </div>
                    </div>
                    <div class="relative" id="profile-dropdown-container">
                        <div class="flex items-center gap-2 cursor-pointer" id="profile-toggle">
                            <div class="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center">
                                <i class="ri-user-line ri-lg text-gray-600"></i>
                            </div>
                            <span class="text-sm font-medium text-gray-700 hidden md:block">
                                <asp:Label ID="txtName" runat="server" Text="***"></asp:Label>
                            </span>
                            <i class="ri-arrow-down-s-line ml-1 hidden md:block text-gray-500"></i>
                        </div>
                        <div id="profile-menu"
                            class="hidden absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-100 py-2 z-50">
                            <a href="AgentProfile.aspx"
                                data-readdy="true"
                                class="flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                    <i class="ri-user-line"></i>
                                </div>
                                <span>My Profile</span>
                            </a>
                            <%--<a href="#"
                                class="flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                    <i class="ri-settings-3-line"></i>
                                </div>
                                <span>Account Settings</span>
                            </a>
                            <a href="#"
                                class="flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                    <i class="ri-equalizer-line"></i>
                                </div>
                                <span>Preferences</span>
                            </a>
                            <a href="#"
                                class="flex items-center gap-3 px-4 py-2.5 text-sm text-gray-700 hover:bg-gray-50">
                                <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                    <i class="ri-question-line"></i>
                                </div>
                                <span>Help & Support</span>
                            </a>--%>
                            <div class="h-px bg-gray-200 my-2"></div>
                            <a href="AgentLogin.aspx"
                                class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-600 hover:bg-gray-50">
                                <div class="w-5 h-5 flex items-center justify-center text-red-600">
                                    <i class="ri-logout-box-line"></i>
                                </div>
                                <span>Logout</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <main class="flex-1 p-6">
            <div class="max-w-7xl mx-auto">
                <div class="flex items-center justify-between mb-6">
                    <h1 class="text-2xl font-bold text-gray-800">
                        Your Assigned Orders
                    </h1>
                    <div class="flex items-center gap-2">
                        <div class="relative">
                            <input type="text" placeholder="Search orders..."
                                class="pl-10 pr-4 py-2 rounded border-none bg-white shadow-sm focus:ring-2 focus:ring-primary/20 focus:outline-none w-full md:w-64 text-sm" />
                            <div
                                class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>
                        <button class="bg-primary text-white px-4 py-2 rounded-button whitespace-nowrap flex items-center gap-2 hover:bg-primary/90 transition-colors">
                            <i class="ri-filter-3-line"></i>
                            <span class="hidden md:inline">Filter</span>
                        </button>
                    </div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <div class="bg-white rounded shadow-sm p-4">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-500">Today's Orders</p>
                                <p class="text-2xl font-bold text-gray-800">
                                    <asp:Label ID="lblTodayOrder" runat="server" Text="****"></asp:Label>
                                </p>
                            </div>
                            <div class="w-12 h-12 flex items-center justify-center bg-blue-50 text-blue-500 rounded-full">
                                <i class="ri-shopping-bag-3-line ri-lg"></i>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded shadow-sm p-4">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-500">Out For Delivery</p>
                                <p class="text-2xl font-bold text-gray-800">
                                    <asp:Label ID="lblOntheway" runat="server" Text="****"></asp:Label>
                                </p>
                            </div>
                            <div
                                class="w-12 h-12 flex items-center justify-center bg-primary/10 text-primary rounded-full">
                                <i class="ri-truck-line ri-lg"></i>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded shadow-sm p-4">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-500">Delivered</p>
                                <p class="text-2xl font-bold text-gray-800">
                                    <asp:Label ID="lblCompleted" runat="server" Text="****"></asp:Label>
                                </p>
                            </div>
                            <div
                                class="w-12 h-12 flex items-center justify-center bg-green-50 text-green-500 rounded-full">
                                <i class="ri-check-double-line ri-lg"></i>
                            </div>
                        </div>
                    </div>
                    <div class="bg-white rounded shadow-sm p-4">
                        <div class="flex items-center justify-between">
                            <div>
                                <p class="text-sm text-gray-500">Cancelled</p>
                                <p class="text-2xl font-bold text-gray-800">
                                    <asp:Label ID="lblCancel" runat="server" Text="****"></asp:Label>
                                </p>
                            </div>
                            <div class="w-12 h-12 flex items-center justify-center bg-red-50 text-red-500 rounded-full">
                                <i class="ri-close-circle-line ri-lg"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <%--OnRowDataBound="gvOrders_RowDataBound"--%>
                <form runat="server">
                    <asp:HiddenField ID="hiddenStatus" runat="server" />
                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="min-w-full divide-y divide-gray-200"
                        GridLines="None" ShowHeader="true">
                        <HeaderStyle CssClass="bg-white text-center" />
                        <RowStyle CssClass="hover:bg-white" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <input type="checkbox" class="chk custom-checkbox" id="select-all" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input type="checkbox" class="chk custom-checkbox row-checkbox" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="OrderId" HeaderText="Order ID"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" />

                            <asp:TemplateField HeaderText="Customer"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                <ItemTemplate>
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 flex items-center justify-center bg-blue-100 rounded-full bg-black-100 text-black-600">
                                            <span class="text-xs font-medium">
                                                <%# Eval("UserId") %>
                                            </span>
                                        </div>
                                        <div class="ml-3">
                                            <p class="text-sm font-medium text-gray-900"><%# Eval("CustomerName") %></p>
                                            <p class="text-xs text-gray-500"><%# Eval("PhoneNumber") %></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                </asp:TemplateField>

                            <asp:BoundField DataField="TotalAmount" HeaderText="Amount"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                                DataFormatString="{0:C}" HtmlEncode="false" />

                            <asp:TemplateField HeaderText="Status" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                <ItemTemplate>
                                    <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                        <%# Eval("OrderStatus").ToString() == "Delivered" ? "bg-green-100 text-green-800" : 
                                            Eval("OrderStatus").ToString() == "Preparing" ? "bg-blue-100 text-blue-800" : 
                                            Eval("OrderStatus").ToString() == "Out for delivery" ? "bg-orange-100 text-orange-800" : 
                                            "bg-red-100 text-red-800" %>'>
                                        <%# Eval("OrderStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Ordered On"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy - hh:mm tt") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned At"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("AssignedAt")).ToString("MMM dd, yyyy - hh:mm tt") %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Action"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <ItemTemplate>
                                    <div class="flex space-x-2">
                                        <a href='UpdateStatus.aspx?OrderId=<%# Eval("OrderId") %>' class="text-primary hover:text-primary/80 flex items-center gap-1">
                                            <i class="ri-edit-line"></i>
                                            <span>Update Status</span>
                                        </a>
                                        <%--<a href='TrackOrder.aspx?OrderId=<%# Eval("OrderId") %>' class="text-gray-600 hover:text-gray-900 flex items-center gap-1">
                                            <i class="ri-map-pin-line"></i> 
                                            <span>Track</span>
                                        </a>--%>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </form>
            </div>
        </main>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const profileToggle = document.getElementById("profile-toggle");
            const profileMenu = document.getElementById("profile-menu");
            profileToggle.addEventListener("click", (e) => {
                e.stopPropagation();
                profileMenu.classList.toggle("hidden");
            });
            document.addEventListener("click", (e) => {
                if (!profileMenu.contains(e.target) && !profileToggle.contains(e.target)) {
                    profileMenu.classList.add("hidden");
                }
            });
            const statusToggle = document.getElementById("status-toggle");
            const statusMenu = document.getElementById("status-menu");
            const currentStatus = document.getElementById("current-status");
            function updateStatus(status, color) {
                statusToggle.className = `px-3 py-1 rounded-full bg-${color}-100 text-${color}-600 text-sm font-medium flex items-center gap-1`;
                statusToggle.querySelector("span:first-child").className =
                    `w-2 h-2 bg-${color}-500 rounded-full`;
                currentStatus.textContent = status;
            }
            statusToggle.addEventListener("click", (e) => {
                e.stopPropagation();
                statusMenu.classList.toggle("hidden");
            });
            document.addEventListener("click", (e) => {
                if (!statusMenu.contains(e.target) && !statusToggle.contains(e.target)) {
                    statusMenu.classList.add("hidden");
                }
            });

            statusMenu.querySelectorAll("button").forEach((button) => {
                button.addEventListener("click", () => {
                    const newStatus = button.querySelector("span:last-child").textContent;
                    const agentId = '<%= Session["DeliveryAgentId"] %>';

                    fetch('DeliveryAgentDashboard.aspx/UpdateAgentStatus', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json; charset=utf-8' },
                        body: JSON.stringify({ agentId: agentId, newStatus: newStatus })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.d === "success") {
                            const color = button.dataset.color;
                            updateStatus(newStatus, color);
                            alert("Status updated successfully!");
                        } else {
                            alert("Failed to update status.");
                        }
                        statusMenu.classList.add("hidden");
                    })
                    .catch(error => console.error('Error:', error));
                });
            });


            const selectAllCheckbox = document.getElementById("select-all");
            const rowCheckboxes = document.querySelectorAll(".row-checkbox");
            selectAllCheckbox.addEventListener("change", function () {
                const isChecked = this.checked;
                rowCheckboxes.forEach((checkbox) => {
                    checkbox.checked = isChecked;
                });
            });
            rowCheckboxes.forEach((checkbox) => {
                checkbox.addEventListener("change", function () {
                    const allChecked = [...rowCheckboxes].every((cb) => cb.checked);
                    const someChecked = [...rowCheckboxes].some((cb) => cb.checked);
                    selectAllCheckbox.checked = allChecked;
                    selectAllCheckbox.indeterminate = someChecked && !allChecked;
                });
            });
        });
    </script>
</body>
</html>
