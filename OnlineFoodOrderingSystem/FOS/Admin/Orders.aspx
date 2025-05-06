<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Orders Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FFA116",
                        secondary: "#1E1E1E",
                    },
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
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        body {
            font-family: 'Inter', sans-serif;
        }

        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .filter-button {
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            letter-spacing: 0.025em;
            background-color: white;
            color: black;
        }

        .filter-button.active {
            background-color: rgba(254, 161, 22, 0.1); /* primary-100 equivalent */
            color: #FEA116; /* primary-600 equivalent */
            font-weight: 600;
        }

        .filter-button:not(.active):hover {
            background-color: #FEA116; /* primary color */
            color: white;
        }

        /* Remove default button styles */
        button {
            border: none;
            outline: none;
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body class="bg-gray-100">
        <div class="max-w-[1600px] mx-auto">
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center gap-4">
                    <h1 class="text-2xl font-semibold text-gray-900">Orders Management
                    </h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="flex items-center space-x-2">
                            <li>
                                <a href="Dashboard.aspx"
                                    data-readdy="true"
                                    class="text-sm text-gray-500 hover:text-gray-700">Dashboard</a>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <i class="ri-arrow-right-s-line text-gray-400"></i>
                                    <span class="ml-2 text-sm text-gray-700">Orders</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative">
                        <input type="text" placeholder="Search orders..."
                            class="pl-10 pr-4 py-2 rounded-button bg-white border-none text-sm w-64" />
                        <div
                            class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400">
                            <i class="ri-search-line"></i>
                        </div>
                    </div>
                    <a href="newOrder.aspx"
                        data-readdy="true"
                        class="flex items-center gap-2 px-4 py-2 rounded-button bg-primary text-white text-sm !rounded-button whitespace-nowrap">
                        <div class="w-4 h-4 flex items-center justify-center">
                            <i class="ri-add-line"></i>
                        </div>
                        Add New Order
                    </a>
                </div>
            </div>
            <div class="grid grid-cols-4 gap-6 mb-8">
                <div class="bg-white rounded p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                            <i class="ri-shopping-bag-line text-xl text-primary"></i>
                        </div>
                        <span class="text-sm text-green-500 flex items-center">
                            <i class="ri-arrow-up-line mr-1"></i>
                            15.2%
                        </span>
                    </div>
                    <h3 class="text-3xl font-bold text-gray-900 mb-1">
                        <asp:Label ID="lblOrder" runat="server" Text="****"></asp:Label>
                    </h3>
                    <p class="text-sm text-gray-500">Total Orders</p>
                </div>
                <div class="bg-white rounded p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 rounded-full bg-yellow-100 flex items-center justify-center">
                            <i class="ri-time-line text-xl text-yellow-600"></i>
                        </div>
                        <span class="text-sm text-yellow-600 flex items-center">
                            <i class="ri-arrow-up-line mr-1"></i>
                            8.7%
                        </span>
                    </div>
                    <h3 class="text-3xl font-bold text-gray-900 mb-1">
                        <asp:Label ID="lblPending" runat="server" Text="****"></asp:Label>
                    </h3>
                    <p class="text-sm text-gray-500">Pending Orders</p>
                </div>
                <div class="bg-white rounded p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center">
                            <i class="ri-check-line text-xl text-green-600"></i>
                        </div>
                        <span class="text-sm text-green-500 flex items-center">
                            <i class="ri-arrow-up-line mr-1"></i>
                            12.3%
                        </span>
                    </div>
                    <h3 class="text-3xl font-bold text-gray-900 mb-1">
                        <asp:Label ID="lblComplete" runat="server" Text="****"></asp:Label>
                    </h3>
                    <p class="text-sm text-gray-500">Completed Orders</p>
                </div>
                <div class="bg-white rounded p-6 shadow-sm">
                    <div class="flex items-center justify-between mb-4">
                        <div class="w-12 h-12 rounded-full bg-red-100 flex items-center justify-center">
                            <i class="ri-close-line text-xl text-red-600"></i>
                        </div>
                        <span class="text-sm text-red-500 flex items-center">
                            <i class="ri-arrow-down-line mr-1"></i>
                            2.8%
                        </span>
                    </div>
                    <h3 class="text-3xl font-bold text-gray-900 mb-1">
                        <asp:Label ID="lblCancel" runat="server" Text="****"></asp:Label>
                    </h3>
                    <p class="text-sm text-gray-500">Cancelled Orders</p>
                </div>
            </div>
            <form runat="server">
            <div class="message text-center flex flex-col items-center">
                <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
                <asp:HiddenField ID="hiddenOrderId" runat="server" ClientIDMode="Static" />
                <asp:HiddenField ID="hiddenAgentId" runat="server" ClientIDMode="Static" />
                    <div class="bg-white rounded shadow-sm mb-8">
                        <div class="p-6 border-b bg-gray-100">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-4">
                                    <button class="px-4 py-2 text-sm filter-button rounded-button active" 
                                            onclick="filterOrders('All', this)" data-filter="All">
                                        All Orders
                                    </button>
                                    <button class="px-4 py-2 text-sm filter-button rounded-button" 
                                            onclick="filterOrders('Preparing', this)" data-filter="Preparing">
                                        Preparing
                                    </button>
                                    <button class="px-4 py-2 text-sm filter-button rounded-button" 
                                            onclick="filterOrders('Delivered', this)" data-filter="Delivered">
                                        Delivered
                                    </button>
                                    <button class="px-4 py-2 text-sm filter-button rounded-button" 
                                            onclick="filterOrders('Out for Delivery', this)" data-filter="Out for Delivery">
                                        Out for Delivery
                                    </button>
                                    <button class="px-4 py-2 text-sm filter-button rounded-button" 
                                            onclick="filterOrders('Pending', this)" data-filter="Pending">
                                        Pending
                                    </button>
                                    <button class="px-4 py-2 text-sm filter-button rounded-button" 
                                            onclick="filterOrders('Cancelled', this)" data-filter="Cancelled">
                                        Cancelled
                                    </button>
                                </div>
                                <div class="flex items-center gap-4">
                                    <div class="relative">
                                        <input type="text" placeholder="Filter by date..."
                                            class="pl-10 pr-4 py-2 rounded-button bg-gray-50 border-none text-sm w-48" />
                                        <div
                                            class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400">
                                            <i class="ri-calendar-line"></i>
                                        </div>
                                    </div>
                                    <div class="relative" id="exportDropdown">
                                        <button onclick="toggleExportMenu()"
                                            class="flex items-center gap-2 px-4 py-2 text-sm text-gray-500 hover:bg-gray-100 rounded-button">
                                            <i class="ri-download-line"></i>
                                            Export
                                        </button>
                                        <div class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-10"
                                            id="exportMenu">
                                            <div class="py-1">
                                                <button
                                                    class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 flex items-center gap-2"
                                                    onclick="exportData('csv')">
                                                    <i class="ri-file-text-line"></i>
                                                    Export as CSV
                                                </button>
                                                <button
                                                    class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 flex items-center gap-2"
                                                    onclick="exportData('excel')">
                                                    <i class="ri-file-excel-line"></i>
                                                    Export as Excel
                                                </button>
                                                <button
                                                    class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 flex items-center gap-2"
                                                    onclick="exportData('pdf')">
                                                    <i class="ri-file-pdf-line"></i>
                                                    Export as PDF
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="exportNotification"
                                        class="hidden fixed bottom-4 right-4 bg-white rounded-lg shadow-lg p-4 z-50">
                                        <div id="exportLoading" class="hidden flex items-center gap-3">
                                            <div
                                                class="animate-spin rounded-full h-5 w-5 border-2 border-primary border-t-transparent">
                                            </div>
                                            <p class="text-sm text-gray-600">Exporting data...</p>
                                        </div>
                                        <div id="exportSuccess" class="hidden flex items-center gap-3 text-green-600">
                                            <i class="ri-checkbox-circle-line"></i>
                                            <p class="text-sm text-gray-600">Export completed successfully!</p>
                                        </div>
                                    </div>
                                    <div class="relative inline-block text-left" id="assignDropdown">
                                        <asp:Button ID="btnAssignOrder" runat="server" 
                                            CssClass="inline-flex justify-center items-center bg-primary text-white px-4 py-2 rounded-button text-sm hover:bg-opacity-90 transition-colors"
                                            Text="Assign Order" 
                                            OnClientClick="toggleAssignDropdown(); return false;" />
    
                                        <div id="assignMenu" class="hidden absolute right-0 mt-2 w-56 origin-top-right bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none z-50 divide-y divide-gray-100">
                                            <div class="py-1">
                                                <asp:Repeater ID="rptAgents" runat="server">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkAssignAgent" runat="server"
                                                            CssClass="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 w-full text-left"
                                                            OnClientClick='<%# "return assignOrderToAgent(\"" + Eval("DeliveryAgentId") + "\");" %>'>
                                                            <div class="flex items-center">
                                                                <span class="mr-3">
                                                                    <i class="ri-user-line"></i>
                                                                </span>
                                                                <span><%# Eval("FirstName") + " " + Eval("LastName") %></span>
                                                            </div>
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </div>
                                            <div class="py-1">
                                                <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900" onclick="toggleAssignDropdown(); return false;">
                                                    <i class="ri-close-line mr-2"></i> Cancel
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="overflow-x-auto">
                                <asp:Label ID="lblNoData" runat="server" Text="No orders found." Visible="false" CssClass="text-gray-500"></asp:Label>
                                <asp:GridView ID="gvDashboard" runat="server" AutoGenerateColumns="False"   
                                    CssClass="min-w-full divide-y divide-gray-200 shadow-sm rounded-lg overflow-hidden">
                                    <HeaderStyle CssClass="bg-gray-50" />
                                    <RowStyle CssClass="hover:bg-gray-50" />
                                    <AlternatingRowStyle CssClass="bg-white" />
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                            <HeaderTemplate>
                                                <input type="checkbox" id="chkSelectAll" onclick="toggleAllCheckboxes(this)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <input type="checkbox" class="order-checkbox" value='<%# Eval("OrderID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Order ID" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                            <ItemTemplate>
                                                <div class="text-sm font-semibold text-gray-900">#<%# Eval("OrderID") %></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Customer" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4">
                                            <ItemTemplate>
                                                <div class="text-sm font-semibold text-gray-900"><%# Eval("FirstName") %> <%# Eval("LastName") %></div>
                                                <div class="text-sm text-gray-500"><%# Eval("Email") %></div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="OrderDate" HeaderText="Date"
                                            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                            DataFormatString="{0:MMM dd, yyyy}" />

                                        <asp:BoundField DataField="Amount" HeaderText="Amount"
                                            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                                            DataFormatString="₹{0:N2}" />

                                        <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                            <ItemTemplate>
                                                <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                                    <%# Eval("Status").ToString() == "Delivered" ? "bg-green-100 text-green-800" : 
                                                       Eval("Status").ToString() == "Pending" ? "bg-yellow-100 text-yellow-800" : 
                                                       Eval("Status").ToString() == "Preparing" ? "bg-blue-100 text-blue-800" : 
                                                       Eval("Status").ToString() == "Out for Delivery" ? "bg-purple-100 text-purple-800" : 
                                                       "bg-red-100 text-red-800" %>'>
                                                    <%# Eval("Status") %>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnShow" runat="server" CommandName="Show" CommandArgument='<%# Eval("OrderId") %>' OnClick="btnShow_Click"
                                                    CssClass="text-indigo-600 hover:text-indigo-900 mr-3" style="font-size: larger"
                                                    OnClientClick='<%# "viewOrderDetails(\"" + Eval("OrderID") + "\"); return true;" %>'>
                                                    <i class="ri-eye-fill" style="color: black;"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("OrderId") %>' style="font-size: larger"
                                                    OnClientClick="return confirm('Are you sure you want to delete this Order?');" CssClass="text-red-600 hover:text-red-900 mr-3">
                                                    <i class="ri-delete-bin-line"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                </form>
            <div id="orderDetailsModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" runat="server" style="display: none">
                <div class="bg-white rounded-lg w-[800px] max-h-[90vh] overflow-y-auto">
                    <div class="p-6 border-b flex items-center justify-between">
                        <h3 class="text-xl font-semibold text-gray-900">Order Details
                                            </h3>
                        <button onclick="closeOrderDetails()" class="text-gray-400 hover:text-gray-500">
                            <i class="ri-close-line text-xl"></i>
                        </button>
                    </div>
                    <div class="grid grid-cols-2 gap-6 p-6">
                        <div>
                            <h4 class="text-sm font-medium text-gray-900 mb-4">Customer Information</h4>
                            <div class="space-y-2">
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Name:</span> <asp:Label ID="lblFirstname" runat="server" Text="***"></asp:Label> <asp:Label ID="lblLastname" runat="server" Text="***"></asp:Label></p>
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Email:</span> <asp:Label ID="lblEmail" runat="server" Text="***"></asp:Label></p>
                            </div>
                        </div>
                        <div>
                            <h4 class="text-sm font-medium text-gray-900 mb-4">Order Information</h4>
                            <div class="space-y-2">
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Order ID:</span> <asp:Label ID="lblId" runat="server" Text="***"></asp:Label></p>
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Date:</span> <asp:Label ID="lblDate" runat="server" Text="***"></asp:Label></p>
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Amount:</span> <asp:Label ID="lblAmount" runat="server" Text="***"></asp:Label></p>
                                <p class="text-sm text-gray-700"><span class="text-gray-500">Status:</span> 
                                    <span class="px-2 py-1 text-xs rounded-full bg-purple-100 text-purple-800"><asp:Label ID="lblStatus" runat="server" Text="***"></asp:Label></span>
                                </p>
                            </div>
                        </div>
                        <div class="col-span-2">
                            <h4 class="text-sm font-medium text-gray-900 mb-4">Products</h4>
                            <div class="border border-gray-200 rounded-lg overflow-hidden">
                                <asp:Repeater ID="rptProducts" runat="server">
                                    <HeaderTemplate>
                                        <table class="w-full">
                                            <thead>
                                                <tr class="bg-gray-50">
                                                    <th class="py-3 px-4 text-left text-sm font-medium text-gray-900">Product</th>
                                                    <th class="py-3 px-4 text-left text-sm font-medium text-gray-900">Quantity</th>
                                                    <th class="py-3 px-4 text-left text-sm font-medium text-gray-900">Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-b border-gray-200">
                                            <td class="py-3 px-4 text-sm text-gray-700"><%# Eval("ProductName") %></td>
                                            <td class="py-3 px-4 text-sm text-gray-700"><%# Eval("Quantity") %></td>
                                            <td class="py-3 px-4 text-sm text-gray-700"><%# Eval("Price") %></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                            </tbody>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function filterOrders(filter, buttonElement) {

                    //console.log("Activating button for filter:", filter, buttonElement);

                    const buttons = document.querySelectorAll('.filter-button');
                    buttons.forEach(btn => {
                        btn.classList.remove('bg-primary/10', 'text-primary');

                        if (!btn.classList.contains('text-gray-500')) {
                            btn.classList.add('text-gray-500', 'hover:bg-gray-100');
                        }
                    });

                    buttonElement.classList.remove('text-gray-500', 'hover:bg-gray-100');
                    buttonElement.classList.add('bg-primary/10', 'text-primary');

                    __doPostBack('FilterOrders', filter);
                }

                function toggleAssignDropdown() {
                    const menu = document.getElementById("assignMenu");
                    menu.classList.toggle("hidden");

                    if (!menu.classList.contains("hidden")) {
                        document.addEventListener('click', function outsideClick(e) {
                            if (!e.target.closest('#assignDropdown')) {
                                menu.classList.add("hidden");
                                document.removeEventListener('click', outsideClick);
                            }
                        });
                    }
                }

                document.addEventListener('DOMContentLoaded', function () {
                    const currentFilter = '<%= ViewState["CurrentFilter"] %>' || 'All';

                    const activeButton = document.querySelector(`.filter-button[data-filter="${currentFilter}"]`);
                    if (activeButton) {
                        activeButton.classList.remove('text-gray-500', 'hover:bg-gray-100');
                        activeButton.classList.add('bg-primary/10', 'text-primary');
                    }
                });

                function assignOrderToAgent(agentId) {
                    const selected = document.querySelectorAll(".order-checkbox:checked");
                    if (selected.length !== 1) {
                        alert("Please select exactly one order.");
                        return false;
                    }

                    const orderId = selected[0].value;
                    document.getElementById("hiddenOrderId").value = orderId;
                    document.getElementById("hiddenAgentId").value = agentId;

                    __doPostBack('AssignAgentPostback', '');
                    return false;
                }

                function toggleAssignDropdown() {
                    document.getElementById("assignMenu").classList.toggle("hidden");
                }

                function getSelectedOrderId() {
                    const selected = [...document.querySelectorAll(".order-checkbox:checked")];
                    if (selected.length !== 1) {
                        alert("Please select exactly one order to assign.");
                        return null;
                    }
                    return selected[0].value;
                }

                document.querySelectorAll("[id$='lnkAssignAgent']").forEach(link => {
                    link.addEventListener("click", function (e) {
                        const orderId = getSelectedOrderId();
                        if (!orderId) {
                            e.preventDefault();
                        } else {
                            const hiddenField = document.getElementById("hiddenOrderId");
                            hiddenField.value = orderId;
                        }
                    });
                });

                
                function toggleAllCheckboxes(mainCheckbox) {
                    const checkboxes = document.querySelectorAll(".order-checkbox");
                    checkboxes.forEach((checkbox) => (checkbox.checked = mainCheckbox.checked));
                }

                function viewOrderDetails(orderId) {
                    const modal = document.getElementById("<%= orderDetailsModal.ClientID %>");
                    modal.classList.remove("hidden");
                    modal.style.display = "block";
                    return false;
                }

                function closeOrderDetails() {
                    const modal = document.getElementById("<%= orderDetailsModal.ClientID %>");
                    modal.style.display = "none";
                    modal.classList.add("hidden");
                }

                function editOrder(orderId) {
                    console.log("Edit order:", orderId);
                }
                function deleteOrder(orderId) {
                    if (confirm("Are you sure you want to delete this order?")) {
                        console.log("Delete order:", orderId);
                    }
                }
                document.addEventListener("click", function (event) {
                    const bulkDropdown = document.getElementById("bulkActionDropdown");
                    const bulkMenu = document.getElementById("bulkActionMenu");
                    const exportDropdown = document.getElementById("exportDropdown");
                    const exportMenu = document.getElementById("exportMenu");
                    if (!bulkDropdown.contains(event.target)) {
                        bulkMenu.classList.add("hidden");
                    }
                    if (!exportDropdown.contains(event.target)) {
                        exportMenu.classList.add("hidden");
                    }
                });
                function toggleExportMenu() {
                    const menu = document.getElementById("exportMenu");
                    menu.classList.toggle("hidden");
                }
                function exportData(format) {
                    const notification = document.getElementById("exportNotification");
                    const loading = document.getElementById("exportLoading");
                    const success = document.getElementById("exportSuccess");

                    document.getElementById("exportMenu").classList.add("hidden");

                    notification.classList.remove("hidden");
                    loading.classList.remove("hidden");
                    success.classList.add("hidden");

                    setTimeout(() => {
                        loading.classList.add("hidden");
                        success.classList.remove("hidden");

                        setTimeout(() => {
                            notification.classList.add("hidden");
                        }, 3000);

                        const fileName = `orders_${new Date().toISOString().split("T")[0]}.${format}`;
                        console.log(`Downloading ${fileName}`);
                    }, 2000);
                }
                renderOrders();
            </script>
        </div>
    </body>
</asp:Content>
