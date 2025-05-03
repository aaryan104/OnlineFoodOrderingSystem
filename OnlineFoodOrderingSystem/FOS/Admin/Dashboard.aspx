<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin Dashboard</title>
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
        <div class="message text-center flex flex-col items-center">
            <asp:Label ID="msg" runat="server" ForeColor="red" style="font-size:larger" Text=""></asp:Label>
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

                            <asp:TemplateField HeaderText="Delivery Agent"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                <ItemTemplate>
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 flex items-center justify-center bg-blue-100 rounded-full bg-black-100 text-black-600">
                                            <span class="text-xs font-medium">
                                                <%# Eval("DeliveryAgentId") %>
                                            </span>
                                        </div>
                                        <div class="ml-3">
                                            <p class="text-sm font-medium text-gray-900"><%# Eval("DeliveryAgentName") %></p>
                                            <p class="text-xs text-gray-500"><%# Eval("DeliveryPhone") %></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                </asp:TemplateField>

                            <asp:TemplateField HeaderText="Customer" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4">
                                <ItemTemplate>
                                    <div class="text-sm font-semibold text-gray-900"><%# Eval("CustomerName") %></div>
                                    <div class="text-sm text-gray-500"><%# Eval("CustomerPhone") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Amount" HeaderText="Amount"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                                DataFormatString="₹{0:N2}" />

                            <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                <ItemTemplate>
                                    <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
                                        <%# Eval("AssignmentStatus").ToString() == "Delivered" ? "bg-green-100 text-green-800" : 
                                            Eval("AssignmentStatus").ToString() == "Assigned" ? "bg-blue-100 text-blue-800" : 
                                            Eval("AssignmentStatus").ToString() == "Pending" ? "bg-yellow-100 text-yellow-800" : 
                                            "bg-red-100 text-red-800" %>'>
                                        <%# Eval("AssignmentStatus") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="AssignedAt" HeaderText="Date"
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                                DataFormatString="{0:MMM dd, yyyy}" />

                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center text-sm font-medium">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("AssignmentId") %>' style="font-size: large"
                                        OnClientClick="return confirm('Are you sure you want to delete this Assignment?');" CssClass="text-red-500 hover:text-red-700 w-8 h-8 flex items-center justify-center">
                                        <i class="ri-delete-bin-line"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </form>
            </div>
        </div>
    </body>

</asp:Content>
