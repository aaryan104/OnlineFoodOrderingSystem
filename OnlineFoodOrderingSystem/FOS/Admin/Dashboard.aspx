<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body class="bg-gray-100">
        <%--<main class="flex-1 md:ml-64 ml-0 p-8">--%>
        <%--<div class="max-w-[1600px] mx-auto">--%>
        <div class="flex items-center justify-between mb-8">
            <h1 class="text-2xl font-semibold text-gray-900">Dashboard Overview
            </h1>
            <div class="flex items-center gap-4">
                <div class="relative">
                    <input type="text" placeholder="Search..."
                        class="pl-10 pr-4 py-2 rounded-button bg-white border-none text-sm w-64" />
                    <div
                        class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400">
                        <i class="ri-search-line"></i>
                    </div>
                </div>
                <button
                    class="flex items-center gap-2 px-4 py-2 rounded-button bg-primary text-white text-sm !rounded-button whitespace-nowrap">
                    <div class="w-4 h-4 flex items-center justify-center">
                        <i class="ri-add-line"></i>
                    </div>
                    Add New
                </button>
            </div>
        </div>
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-shopping-bag-line text-xl text-primary"></i>
                    </div>
                    <span class="text-sm text-green-500 flex items-center">
                        <i class="ri-arrow-up-line mr-1"></i>
                        12.5%
                    </span>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblOrder" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Total Orders</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-money-rupee-circle-fill text-xl text-primary"></i>
                    </div>
                    <span class="text-sm text-green-500 flex items-center">
                        <i class="ri-arrow-up-line mr-1"></i>
                        8.2%
                    </span>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblRevenue" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Total Revenue</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-user-line text-xl text-primary"></i>
                    </div>
                    <span class="text-sm text-green-500 flex items-center">
                        <i class="ri-arrow-up-line mr-1"></i>
                        5.7%
                    </span>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblUser" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Active Users</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-calendar-line text-xl text-primary"></i>
                    </div>
                    <span class="text-sm text-red-500 flex items-center">
                        <i class="ri-arrow-down-line mr-1"></i>
                        3.2%
                    </span>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblTodayOrder" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Today's Orders</p>
            </div>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 gap-6 mb-8">
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-restaurant-line text-xl text-primary"></i>
                    </div>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblFood" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Total Food Items</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-truck-line text-xl text-primary"></i>
                    </div>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblAgents" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Total Delivery Agents</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-store-3-line text-xl text-primary"></i>
                    </div>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblPending" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Pending Orders</p>
            </div>
            <div class="bg-white rounded p-6 shadow-sm">
                <div class="flex items-center justify-between mb-4">
                    <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                        <i class="ri-bank-card-2-fill text-xl text-primary"></i>
                    </div>
                </div>
                <h3 class="text-3xl font-bold text-gray-900 mb-1">
                    <asp:Label ID="lblPayment" runat="server" Text="****"></asp:Label>
                </h3>
                <p class="text-sm text-gray-500">Sucess Payments</p>
            </div>
        </div>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-8">
            <div class="bg-white p-6 rounded shadow-sm">
                <h3 class="text-lg font-semibold mb-4">Quick Actions</h3>
                <div class="grid grid-cols-2 gap-4">
                    <a href="FoodItems.aspx" class="flex flex-col items-center justify-center p-4 bg-primary bg-opacity-10 rounded-lg hover:bg-opacity-20 transition-all !rounded-button">
                        <div class="w-12 h-12 flex items-center justify-center bg-primary bg-opacity-20 rounded-full mb-2">
                            <i class="ri-add-line text-primary text-xl"></i>
                        </div>
                        <span class="text-sm font-medium">Add New Product</span>
                    </a>
                    <a href="userManage.aspx" class="flex flex-col items-center justify-center p-4 bg-red-50 rounded-lg hover:bg-red-100 transition-all !rounded-button">
                        <div class="w-12 h-12 flex items-center justify-center bg-red-100 rounded-full mb-2">
                            <i class="ri-user-add-line text-red-600 text-xl"></i>
                        </div>
                        <span class="text-sm font-medium">Add New User</span>
                    </a>
                    <a href="Orders.aspx" class="flex flex-col items-center justify-center p-4 bg-green-50 rounded-lg hover:bg-green-100 transition-all !rounded-button">
                        <div class="w-12 h-12 flex items-center justify-center bg-green-100 rounded-full mb-2">
                            <i class="ri-shopping-bag-line text-green-600 text-xl"></i>
                        </div>
                        <span class="text-sm font-medium">Orders</span>
                    </a>
                    <a href="DeliveryBoy.aspx" class="flex flex-col items-center justify-center p-4 bg-purple-50 rounded-lg hover:bg-purple-100 transition-all !rounded-button">
                        <div class="w-12 h-12 flex items-center justify-center bg-purple-100 rounded-full mb-2">
                            <i class="ri-bike-line text-purple-600 text-xl"></i>
                        </div>
                        <span class="text-sm font-medium">Delivery Boy</span>
                    </a>
                </div>
            </div>
            <div class="bg-white p-6 rounded shadow-sm">
                <h3 class="text-lg font-semibold mb-4">Delivery Status</h3>
                <div class="space-y-4">
                    <div class="flex items-center justify-between p-4 bg-yellow-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="w-10 h-10 flex items-center justify-center bg-yellow-100 rounded-full mr-3">
                                <i class="ri-time-line text-yellow-600"></i>
                            </div>
                            <div>
                                <p class="font-medium">Pending Deliveries</p>
                                <p class="text-sm text-gray-500">
                                    <asp:Label ID="lblWaiting" runat="server" Text="*"></asp:Label> orders waiting</p>
                            </div>
                        </div>
                        <button class="px-3 py-1 bg-yellow-100 text-yellow-800 rounded-full text-sm !rounded-button">
                            View All
                        </button>
                    </div>
                    <div class="flex items-center justify-between p-4 bg-red-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="w-10 h-10 flex items-center justify-center bg-red-100 rounded-full mr-3">
                                <i class="ri-truck-line text-red-600"></i>
                            </div>
                            <div>
                                <p class="font-medium">In Transit</p>
                                <p class="text-sm text-gray-500">
                                    <asp:Label ID="lblOntheway" runat="server" Text="*"></asp:Label> orders on the way</p>
                            </div>
                        </div>
                        <button class="px-3 py-1 bg-red-100 text-red-800 rounded-full text-sm !rounded-button">
                            View All
                        </button>
                    </div>
                    <div class="flex items-center justify-between p-4 bg-green-50 rounded-lg">
                        <div class="flex items-center">
                            <div class="w-10 h-10 flex items-center justify-center bg-green-100 rounded-full mr-3">
                                <i class="ri-checkbox-circle-line text-green-600"></i>
                            </div>
                            <div>
                                <p class="font-medium">Delivered Today</p>
                                <p class="text-sm text-gray-500">
                                    <asp:Label ID="lblCompleted" runat="server" Text="*"></asp:Label> orders completed</p>
                            </div>
                        </div>
                        <button class="px-3 py-1 bg-green-100 text-green-800 rounded-full text-sm !rounded-button">
                            View All    
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="bg-white rounded shadow-sm mb-8">
            <div class="p-6 border-b">
                <div class="flex items-center justify-between">
                    <h3 class="text-lg font-semibold text-gray-900">Recent Orders
                    </h3>
                    <div class="flex items-center gap-4">
                        <div class="relative">
                            <input type="text" placeholder="Search orders..."
                                class="pl-10 pr-4 py-2 rounded-button bg-gray-50 border-none text-sm w-64" />
                            <div
                                class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400">
                                <i class="ri-search-line"></i>
                            </div>
                        </div>
                        <button
                            class="flex items-center gap-2 px-4 py-2 text-sm text-gray-500 hover:bg-gray-100 rounded-button">
                            <i class="ri-filter-line"></i>
                            Filter
                        </button>
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
                                <span class="px-2 py-1 text-xs rounded-full bg-orange-100 text-orange-700">
                                    <asp:Label ID="lblStatus" runat="server" Text="***"></asp:Label>
                                </span>
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
        <%--</div>--%>
        <%--</main>
    </div>--%>
        <script>
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
        </script>
    </body>

</asp:Content>
