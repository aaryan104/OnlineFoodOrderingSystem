<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="newOrder.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.newOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<main class="flex-1 ml-64 p-8">--%>
    <body class="hover:bg-gray-100">
        <div class="max-w-[1000px] mx-auto">
            <div class="flex items-center justify-between mb-8">
                <div class="flex items-center gap-4">
                    <%--<!-- https://readdy.ai/home/15001af8-6742-4526-b709-111685bc59a5/bcb45689-2a29-4e31-ba03-3306fac49bd7 -->--%>
                    <a href="Orders.aspx"
                        data-readdy="true" class="flex items-center gap-2 text-gray-500 hover:text-gray-700">
                        <i class="ri-arrow-left-line"></i>
                        <span>Back to Orders</span>
                    </a>
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
                                    <%--<!-- https://readdy.ai/home/15001af8-6742-4526-b709-111685bc59a5/bcb45689-2a29-4e31-ba03-3306fac49bd7 -->--%>
                                    <a href="Orders.aspx"
                                        data-readdy="true"
                                        class="ml-2 text-sm text-gray-500 hover:text-gray-700">Orders</a>
                                </div>
                            </li>
                            <li>
                                <div class="flex items-center">
                                    <i class="ri-arrow-right-s-line text-gray-400"></i>
                                    <span class="ml-2 text-sm text-gray-700">Create New Order</span>
                                </div>
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>

            <form id="newOrderForm" class="space-y-8" runat="server">
                <div class="bg-white rounded shadow-sm p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-6">Customer Information
                    </h2>
                    <div class="grid grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">First Name 
                                <span class="text-red-500">*</span>
                            </label>
                            <asp:TextBox ID="txtFirstName" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm" placeholder="Enter First name"></asp:TextBox>
    
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Last Name 
                                <span class="text-red-500">*</span>
                            </label>
                            <asp:TextBox ID="txtLastName" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm" placeholder="Enter Last name"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Email Address 
                                <span class="text-red-500">*</span>
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm" placeholder="Enter email address"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded shadow-sm p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Products</h2>
                        <button type="button" onclick="addProductRow()"
                            class="flex items-center gap-2 px-4 py-2 text-sm text-primary hover:bg-primary/5 rounded-button">
                            <i class="ri-add-line"></i>
                            Add Product
                        </button>
                    </div>
                    <div id="productsList" class="space-y-4">
                        <div class="product-row grid grid-cols-12 gap-4 items-start">
                            <div class="col-span-5">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Product <span
                                        class="text-red-500">*</span></label>
                                <div class="relative">
                                    <select required
                                        class="w-full pl-4 pr-10 py-2 rounded-button bg-gray-50 border-none text-sm appearance-none">
                                        <option value="">Select product</option>
                                        <option value="1">Wireless Headphones - $129.99</option>
                                        <option value="2">Smart Watch - $199.99</option>
                                        <option value="3">Laptop Stand - $45.99</option>
                                        <option value="4">Wireless Mouse - $29.99</option>
                                        <option value="5">Mechanical Keyboard - $159.99</option>
                                    </select>
                                    <div class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none">
                                        <i class="ri-arrow-down-s-line text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Quantity <span
                                        class="text-red-500">*</span></label>
                                <input type="number" required min="1" value="1"
                                    class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm"
                                    onchange="updateSubtotal(this)" />
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Unit Price</label>
                                <input type="text" readonly
                                    class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm"
                                    value="$0.00" />
                            </div>
                            <div class="col-span-2">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Subtotal</label>
                                <input type="text" readonly
                                    class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm"
                                    value="$0.00" />
                            </div>
                            <div class="col-span-1 pt-8">
                                <button type="button" onclick="removeProductRow(this)"
                                    class="w-8 h-8 flex items-center justify-center rounded-full hover:bg-red-50 text-red-500">
                                    <i class="ri-delete-bin-line"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded shadow-sm p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-6">Order Details
                    </h2>
                    <div class="grid grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Order Status</label>
                            <div class="relative">
                                <asp:DropDownList ID="orderStatus" runat="server" class="w-full pl-4 pr-10 py-2 rounded-button bg-gray-50 border-none text-sm appearance-none">
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Delivered</asp:ListItem>
                                    <asp:ListItem>Preparing</asp:ListItem>
                                    <asp:ListItem>Out for Delivery</asp:ListItem>
                                    <asp:ListItem>Cancelled</asp:ListItem>
                                </asp:DropDownList>
                                <div class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none">
                                    <i class="ri-arrow-down-s-line text-gray-400"></i>
                                </div>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Order Date</label>
                            <asp:TextBox ID="txtOrderDate" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm" TextMode="DateTimeLocal"></asp:TextBox>
                        </div>
                        <%--<div class="col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Order Notes</label>
                            <asp:TextBox ID="txtOrderNotes" rows="3" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm resize-none" placeholder="Add any additional notes about the order" TextMode="MultiLine"></asp:TextBox>
                        </div>--%>
                    </div>
                </div>

                <div class="bg-white rounded shadow-sm p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-6">Payment Information
                    </h2>
                    <div class="grid grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-4">Payment Method</label>
                            <div class="space-y-3">
                                <label class="flex items-center gap-3 cursor-pointer">
                                    <input type="radio" name="paymentMethod" value="credit_card" class="w-4 h-4 text-primary" />
                                    <span class="text-sm text-gray-700">Credit Card</span>
                                </label>
                                <label class="flex items-center gap-3 cursor-pointer">
                                    <input type="radio" name="paymentMethod" value="UPI" class="w-4 h-4 text-primary" />
                                    <span class="text-sm text-gray-700">UPI</span>
                                </label>
                                <label class="flex items-center gap-3 cursor-pointer">
                                    <input type="radio" name="paymentMethod" value="bank_transfer" class="w-4 h-4 text-primary" />
                                    <span class="text-sm text-gray-700">Bank Transfer</span>
                                </label>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-4">Payment Status</label>
                            <div class="relative">
                                <asp:DropDownList ID="txtPaymentStatus" runat="server" class="w-full pl-4 pr-10 py-2 rounded-button bg-gray-50 border-none text-sm appearance-none">
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Paid</asp:ListItem>
                                    <asp:ListItem>Failed</asp:ListItem>
                                </asp:DropDownList>
                                <div class="absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none">
                                    <i class="ri-arrow-down-s-line text-gray-400"></i>
                                </div>
                            </div>
                        </div>
                        <div id="transactionIdField" class="hidden">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Transaction ID</label>
                            <asp:TextBox ID="transactionId" runat="server" class="w-full px-4 py-2 rounded-button bg-gray-50 border-none text-sm" placeholder="Enter transaction ID"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded shadow-sm p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-6">Order Summary
                    </h2>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-gray-500">Subtotal</span>
                            <span class="text-sm font-medium text-gray-900" id="summarySubtotal">$0.00</span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-gray-500">Tax (10%)</span>
                            <span class="text-sm font-medium text-gray-900" id="summaryTax">$0.00</span>
                        </div>
                        <div class="flex items-center justify-between">
                            <span class="text-sm text-gray-500">Shipping</span>
                            <input type="number" id="shippingCost"
                                class="w-24 px-4 py-2 rounded-button bg-gray-50 border-none text-sm text-right"
                                value="0" min="0" step="0.01" onchange="updateTotal()" />
                        </div>
                        <div class="border-t pt-4">
                            <div class="flex items-center justify-between">
                                <span class="text-sm font-medium text-gray-900">Total Amount</span>
                                <span class="text-lg font-semibold text-primary" id="summaryTotal">$0.00</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex items-center justify-end gap-4">
                    <button type="button" onclick="saveAsDraft()"
                        class="px-6 py-2 text-sm text-gray-700 hover:bg-gray-100 rounded-button">
                        Save as Draft
                    </button>
                    <button type="submit"
                        class="px-6 py-2 text-sm text-white bg-primary hover:bg-primary/90 rounded-button">
                        Create Order
                    </button>
                </div>
            </form>

            <div id="notification" class="fixed bottom-4 right-4 hidden bg-white rounded-lg shadow-lg p-4 z-50">
                <div class="flex items-center gap-3">
                    <i class="ri-checkbox-circle-line text-green-500"></i>
                    <p class="text-sm text-gray-600" id="notificationMessage"></p>
                </div>
            </div>
        </div>

        <script>
            document.getElementById("<%= txtPaymentStatus.ClientID %>")
                .addEventListener("change", function () {
                    const transactionIdField = document.getElementById("transactionIdField");
                    transactionIdField.classList.toggle("hidden", this.value !== "Paid");
                });
        </script>
    </body>
</asp:Content>
