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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<main class="flex-1 ml-64 p-8">--%>
    <body class="bg-gray-100">
        <div class="max-w-[1600px] mx-auto">
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center gap-4">
                    <h1 class="text-2xl font-semibold text-gray-900">Orders Management
                    </h1>
                    <nav class="flex" aria-label="Breadcrumb">
                        <ol class="flex items-center space-x-2">
                            <li>
                                <%--<!-- https://readdy.ai/home/15001af8-6742-4526-b709-111685bc59a5/266cf3f9-faba-4994-887b-84e82c842178 -->--%>
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
                    <%--<!-- https://readdy.ai/home/15001af8-6742-4526-b709-111685bc59a5/35a3eebd-84ed-4de5-8dab-3dc3d7e0dd86 -->--%>
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
            <div class="bg-white rounded shadow-sm mb-8">
                <div class="p-6 border-b">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center gap-4">
                            <button class="px-4 py-2 text-sm filter-button bg-primary/10 text-primary rounded-button" onclick="filterOrders('All')">
                                All Orders
                            </button>
                            <button class="px-4 py-2 text-sm filter-button text-gray-500 hover:bg-gray-100 rounded-button" onclick="filterOrders('Preparing')">
                                Preparing
                            </button>
                            <button class="px-4 py-2 text-sm filter-button text-gray-500 hover:bg-gray-100 rounded-button" onclick="filterOrders('Delivered')">
                                Delivered
                            </button>
                            <button class="px-4 py-2 text-sm filter-button text-gray-500 hover:bg-gray-100 rounded-button" onclick="filterOrders('Out for Delivery')">
                                Out for Delivery
                            </button>
                            <button class="px-4 py-2 text-sm filter-button text-gray-500 hover:bg-gray-100 rounded-button" onclick="filterOrders('Pending')">
                                Pending
                            </button>
                            <button class="px-4 py-2 text-sm filter-button text-gray-500 hover:bg-gray-100 rounded-button" onclick="filterOrders('Cancelled')">
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
                                    <p class="text-sm">Export completed successfully!</p>
                                </div>
                            </div>
                            <div class="relative" id="bulkActionDropdown">
                                <button onclick="toggleBulkActions()"
                                    class="flex items-center gap-2 px-4 py-2 text-sm text-gray-500 hover:bg-gray-100 rounded-button">
                                    <i class="ri-more-2-fill"></i>
                                    Bulk Actions
                                </button>
                                <div class="hidden absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-10"
                                    id="bulkActionMenu">
                                    <div class="py-1">
                                        <button
                                            class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                            onclick="bulkAction('delete')">
                                            Delete Selected
                                        </button>
                                        <button
                                            class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                            onclick="bulkAction('markComplete')">
                                            Mark as Complete
                                        </button>
                                        <button
                                            class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                            onclick="bulkAction('markPending')">
                                            Mark as Pending
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <form runat="server">
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
                                               Eval("Status").ToString() == "Out for Delivery" ? "bg-gray-100 text-gray-800" : 
                                               "bg-red-100 text-red-800" %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnShow" runat="server" CommandName="Show" CommandArgument='<%# Eval("OrderId") %>' OnClick="btnShow_Click"
                                            CssClass="text-indigo-600 hover:text-indigo-900 mr-3"
                                            OnClientClick='<%# "viewOrderDetails(\"" + Eval("OrderID") + "\"); return true;" %>'>
                                            <i class="ri-eye-fill" style="color: black;"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" CommandArgument='<%# Eval("OrderId") %>'
                                            CssClass="text-yellow-600 hover:text-yellow-900 mr-3">
                                            <i class="ri-edit-fill" style="color: black;"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("OrderId") %>'
                                            CssClass="text-red-600 hover:text-red-900">
                                            <i class="ri-delete-bin-fill" style="color: red;"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </form>
                </div>
            </div>
            <div class="message text-center flex flex-col items-center">
                <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
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
                function filterOrders(status) {
                    document.querySelectorAll('.filter-button').forEach(button => {
                        button.classList.remove('bg-primary/10', 'text-primary');
                        button.classList.add('text-gray-500', 'hover:bg-gray-100');
                    });

                    const activeButton = document.querySelector(`[onclick="filterOrders('${status}')"]`);
                    activeButton.classList.remove('text-gray-500', 'hover:bg-gray-100');
                    activeButton.classList.add('bg-primary/10', 'text-primary');

                    __doPostBack('FilterOrders', status);
                }

                
                function toggleBulkActions() {
                    const menu = document.getElementById("bulkActionMenu");
                    menu.classList.toggle("hidden");
                }
                function bulkAction(action) {
                    const selectedOrders = Array.from(
                        document.querySelectorAll(".order-checkbox:checked"),
                    );
                    if (selectedOrders.length === 0) {
                        alert("Please select at least one order");
                        return;
                    }
                    switch (action) {
                        case "delete":
                            if (confirm(`Delete ${selectedOrders.length} selected orders?`)) {
                                console.log("Deleting orders...");
                            }
                            break;
                        case "markComplete":
                            console.log("Marking orders as complete...");
                            break;
                        case "markPending":
                            console.log("Marking orders as pending...");
                            break;
                    }
                    toggleBulkActions();
                }
                function toggleAllCheckboxes(mainCheckbox) {
                    const checkboxes = document.querySelectorAll(".order-checkbox");
                    checkboxes.forEach((checkbox) => (checkbox.checked = mainCheckbox.checked));
                }

                function viewOrderDetails(orderId) {
                    const modal = document.getElementById("<%= orderDetailsModal.ClientID %>");
                    modal.classList.remove("hidden");
                    modal.style.display = "block"; // Show the modal
                    return false; // Prevent server-side postback
                }

                function closeOrderDetails() {
                    const modal = document.getElementById("<%= orderDetailsModal.ClientID %>");
                    modal.style.display = "none";
                    modal.classList.add("hidden"); // Add hidden class to ensure it is not visible
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
                    // Hide export menu
                    document.getElementById("exportMenu").classList.add("hidden");
                    // Show loading notification
                    notification.classList.remove("hidden");
                    loading.classList.remove("hidden");
                    success.classList.add("hidden");
                    // Simulate export process
                    setTimeout(() => {
                        // Hide loading and show success
                        loading.classList.add("hidden");
                        success.classList.remove("hidden");
                        // Hide notification after 3 seconds
                        setTimeout(() => {
                            notification.classList.add("hidden");
                        }, 3000);
                        // Mock download file based on format
                        const fileName = `orders_${new Date().toISOString().split("T")[0]}.${format}`;
                        console.log(`Downloading ${fileName}`);
                    }, 2000);
                }
                renderOrders();
            </script>
        </div>
    </body>
    <%--</main>--%>
</asp:Content>
