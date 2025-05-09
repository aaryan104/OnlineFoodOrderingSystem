﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="trackOrder.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.trackOrder" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bills</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>tailwind.config = { theme: { extend: { colors: { primary: '#FEA116', secondary: '#4B5563' }, borderRadius: { 'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px', 'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px' } } } }</script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f9fafb;
        }

        .order-card {
            transition: all 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .timeline-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .timeline-line {
            height: 2px;
        }

        input[type="search"]::-webkit-search-decoration,
        input[type="search"]::-webkit-search-cancel-button,
        input[type="search"]::-webkit-search-results-button,
        input[type="search"]::-webkit-search-results-decoration {
            display: none;
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .tracking-details {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.5s ease-out;
        }

        .tracking-details.active {
            max-height: 2000px;
            transition: max-height 0.5s ease-in;
        }

        .track-btn {
            border-bottom: 2px solid #FEA116;

        }

        @media (max-width: 768px) {
            .order-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        }

        @media print {
            .no-print {
                display: none !important;
            }
            button {
                display: none;
            }
        }
    </style>
</head>

<body>
    <main class="container mx-auto px-4 py-8">
        <form runat="server">
            <asp:HiddenField ID="hiddenOrderId" runat="server" />
            <div class="text-center mb-8">
                <h2 class="text-3xl font-bold text-gray-800">Track Your Order</h2>
                <p class="text-gray-600 mt-2">View and track all your orders in one place</p>
                <div class="flex items-center gap-2 text-sm text-gray-500 mb-8">
                    <a href="Home.aspx" class="hover:text-primary">Home</a>
                    <i class="ri-arrow-right-s-line"></i>
                    <span>Track Order</span>
                </div>
            </div>
            <div class="flex flex-col md:flex-row gap-8">

                <!-- Left Column - Order History -->
                <div class="w-full md:w-1/2">
                    <div class="bg-white rounded shadow-sm p-6">
                        <div class="flex justify-between items-center mb-6">
                            <h3 class="text-xl font-semibold text-gray-800">Your Orders</h3>
                            <div class="relative">
                                <input type="search" id="searchInput" placeholder="Search orders..."
                                    class="pl-10 pr-4 py-2 rounded-button border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary w-full">
                                <div
                                    class="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 flex items-center justify-center text-gray-400">
                                    <i class="ri-search-line"></i>
                                </div>
                            </div>
                        </div>
                        <div class="flex justify-between items-center mb-4 hidden">
                            <div class="flex space-x-2">
                                <button id="allOrdersBtn"
                                    class="px-3 py-1 text-sm bg-primary text-white rounded-button !rounded-button whitespace-nowrap">
                                    All Orders</button>
                                <button id="processingBtn"
                                    class="px-3 py-1 text-sm bg-gray-100 text-gray-700 rounded-button !rounded-button whitespace-nowrap">
                                    Processing</button>
                                <button id="deliveredBtn"
                                    class="px-3 py-1 text-sm bg-gray-100 text-gray-700 rounded-button !rounded-button whitespace-nowrap">
                                    Delivered</button>
                            </div>
                            <div class="relative">
                                <select
                                    class="appearance-none bg-white border border-gray-300 rounded-button !rounded-button px-3 py-1 pr-8 focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary text-sm">
                                    <option>Recent first</option>
                                    <option>Oldest first</option>
                                    <option>Price: High to Low</option>
                                    <option>Price: Low to High</option>
                                </select>
                                <div
                                    class="absolute right-2 top-1/2 transform -translate-y-1/2 pointer-events-none w-4 h-4 flex items-center justify-center text-gray-500">
                                    <i class="ri-arrow-down-s-line"></i>
                                </div>
                            </div>
                        </div>
                        <button class="track-btn px-5 py-3 text-sm bg-primary text-white rounded-button !rounded-button whitespace-nowrap">
                            Click here for load Data
                        </button>
                        <div class="space-y-4 max-h-[600px] overflow-y-auto pr-2"> 
                            <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                            <asp:Repeater ID="rptOrders" runat="server">
                                <ItemTemplate>
                                    <div id="ordersTable" class="order-card bg-white border border-gray-200 rounded p-4 cursor-pointer" data-order-id='<%# Eval("OrderId") %>'>
                                        <div class="flex justify-between items-start">
                                            <div>
                                                <h4 class="font-semibold text-gray-800">Order #<%# Eval("OrderId") %></h4>
                                                <p class="text-sm text-gray-500"><%# Eval("OrderDate", "{0:MMMM dd, yyyy}") %></p>
                                            </div>
                                            <span class='px-2 py-1 text-xs rounded-full 
                                                <%# Eval("OrderStatus").ToString() == "Delivered" ? "bg-green-100 text-green-700" : 
                                                    Eval("OrderStatus").ToString() == "Preparing" ? "bg-blue-100 text-blue-700" : 
                                                    Eval("OrderStatus").ToString() == "Out for delivery" ? "bg-gray-100 text-gray-700" : 
                                                    Eval("OrderStatus").ToString() == "Delayed" ? "bg-orange-100 text-orange-700" : 
                                                    Eval("OrderStatus").ToString() == "Pending" ? "bg-yellow-100 text-yellow-700" : 
                                                    "bg-red-100 text-red-700" %>'>
                                                <%# Eval("OrderStatus") %>
                                            </span>
                                        </div>
                                        <div class="mt-3 flex justify-between items-center">
                                            <div class="text-sm">
                                                <p class="text-gray-600"><%# Eval("ItemCount") %> items</p>
                                                <p class="font-medium text-gray-800">₹<%# Eval("TotalAmount", "{0:F2}") %></p>
                                            </div>
                                            <span class="track-btn px-4 py-2 text-sm rounded-button !rounded-button whitespace-nowrap">
                                                Note : Click anywhere in this box
                                            </span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>


                <!-- Right Column - Order Tracking Details -->
                <div class="w-full md:w-1/2">
                    <div class="bg-white rounded shadow-sm p-6">
                        <div class="mb-6">
                            <h3 class="text-xl font-semibold text-gray-800 mb-4">Track Your Order</h3>
                            <div class="flex space-x-2">
                                <input type="text" id="orderNumberInput" placeholder="Enter order number"
                                    class="flex-1 px-4 py-3 rounded-button border border-gray-300 focus:outline-none focus:ring-2 focus:ring-primary/30 focus:border-primary">
                                <button id="trackButton"
                                    class="px-6 py-3 bg-primary text-white font-medium rounded-button !rounded-button whitespace-nowrap">
                                    Track</button>
                            </div>
                        </div>
                        <div id="trackingDetails" class="tracking-details">
                            <div class="mb-6">
                                <div class="flex justify-between items-center mb-4">
                                    <h4 class="font-semibold text-gray-800 text-center">Order Details</h4>
                                    <div class="flex space-x-2 no-print">
                                        <button class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100">
                                            <i class="ri-refresh-line text-gray-600"></i>
                                        </button>
                                        <button id="printButton"
                                            class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100">
                                            <i class="ri-printer-line text-gray-600"></i>
                                        </button>
                                    </div>
                                </div>
                                <div id="printSection" class="border border-gray-200 rounded-md overflow-hidden mb-6">
                                    <table class="order-table w-full text-left">
                                        <tbody>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600 w-1/3">Customer
                                                    Name</td>
                                                <td class="px-4 py-3">
                                                    <asp:Label ID="lblCustomerName" runat="server" Text="Loading...."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600 w-1/3">Contact
                                                </td>
                                                <td class="px-4 py-3"><asp:Label ID="lblContact" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600 w-1/3">Order ID</td>
                                                <td class="px-4 py-3" id="orderIdCell"><asp:Label ID="lblOrderId" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600">Order
                                                    Date</td>
                                                <td class="px-4 py-3"><asp:Label ID="lblOrderDate" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600">Estimated
                                                    Delivery</td>
                                                <td class="px-4 py-3"><asp:Label ID="lblEstimatedDelivery" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                            <tr class="border-b border-gray-200">
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600">Shipping
                                                    Address</td>
                                                <td class="address px-4 py-3"><asp:Label ID="lblShippingAddress" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="px-4 py-3 bg-gray-50 font-medium text-gray-600">Payment
                                                    Method</td>
                                                <td class="px-4 py-3"><asp:Label ID="lblPaymentMethod" runat="server" Text="Loading...."></asp:Label></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <br />
                                <h4 class="font-semibold text-gray-800 mb-4 text-center">Order Items</h4>
                                <div class="border border-gray-200 rounded-md mb-6">
                                    <table class="orders order-table w-full text-center">
                                        <thead class="bg-black">
                                            <tr>
                                                <th class="o1 px-4 py-3 font-medium text-white">Product</th>
                                                <th class="o1 px-4 py-3 font-medium text-white">Quantity</th>
                                                <th class="o1 px-4 py-3 font-medium text-white">Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rptOrderItems" runat="server">
                                                <ItemTemplate>
                                                    <tr class="border-b border-gray-200">
                                                        <td class="t1 px-4 py-2">
                                                            <div class="flex items-center">
                                                                <span><%# Eval("ItemName") %></span>
                                                            </div>
                                                        </td>
                                                        <td class="t1 px-4 py-2"><%# Eval("Quantity") %></td>
                                                        <td class="t1 px-4 py-2">₹<%# Eval("Subtotal", "{0:F2}") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                        <tfoot class="bg-gray-50">
                                            <tr>
                                                <td colspan="2" class="t1 px-3 py-1 font-medium text-gray-600 text-right">Total:</td>
                                                <td class="t1 px-4 py-2 font-semibold"><asp:Label ID="lblTotalAmount" runat="server" Text="₹0.00"></asp:Label></td>
                                                <%--<td class="px-4 py-3 font-semibold"><asp:Label ID="lblDebug" runat="server" ForeColor="Red" /></td>--%>
                                            </tr>
                                            <tr class="t2">
                                                <td colspan="2" class="t1 px-3 py-1 font-medium text-gray-600 text-right">Delivery Fees:</td>
                                                <td class="t1 px-4 py-1 font-semibold"><asp:Label ID="lblDfee" runat="server" Text="₹0.00"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="t1 px-3 py-1 font-medium text-gray-600 text-right">Tax:</td>
                                                <td class="t1 px-4 py-1 font-semibold"><asp:Label ID="lblTax" runat="server" Text="₹0.00"></asp:Label></td>
                                            </tr>
                                            <tr class="t2">
                                                <td colspan="2" class="t1 px-3 py-1 font-medium text-gray-600 text-right">Final Amount:</td>
                                                <td class="t1 px-4 py-2 font-semibold"><asp:Label ID="lblFinalAmount" runat="server" Text="₹0.00"></asp:Label></td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div id="emptyState" class="text-center py-10">
                            <div class="w-16 h-16 mx-auto mb-4 flex items-center justify-center rounded-full bg-gray-100">
                                <i class="ri-truck-line text-gray-400 ri-2x"></i>
                            </div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">No Order Selected</h3>
                            <p class="text-gray-500 mb-6">
                                Select an order from the list or enter an order number to track
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </main>
    <script>
        document.getElementById('searchInput').addEventListener('keyup', function () {
            var filter = this.value.toLowerCase();
            var rows = document.querySelectorAll('#ordersTable');

            rows.forEach(function (row) {
                var rowText = row.textContent.toLowerCase();
                if (rowText.indexOf(filter) > -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        document.addEventListener('DOMContentLoaded', function () {
            const trackingDetails = document.getElementById('trackingDetails');
            const emptyState = document.getElementById('emptyState');
            const allOrdersBtn = document.getElementById('allOrdersBtn');
            const processingBtn = document.getElementById('processingBtn');
            const deliveredBtn = document.getElementById('deliveredBtn');
            const orderCards = document.querySelectorAll('.order-card');
            const trackButton = document.getElementById('trackButton');
            const orderNumberInput = document.getElementById('orderNumberInput');
            const orderIdCell = document.getElementById('orderIdCell');
            const printButton = document.getElementById('printButton');

            function updateFilterButtons(activeButton) {
                [allOrdersBtn, processingBtn, deliveredBtn].forEach(btn => {
                    btn.className = 'px-3 py-1 text-sm bg-gray-100 text-gray-700 rounded-button !rounded-button whitespace-nowrap';
                });
                activeButton.className = 'px-3 py-1 text-sm bg-primary text-white rounded-button !rounded-button whitespace-nowrap';
            }

            function filterOrders(status) {
                orderCards.forEach(card => {
                    const orderStatus = card.querySelector('.rounded-full').textContent.trim();
                    if (status === 'all') {
                        card.style.display = 'block';
                    } else {
                        card.style.display = orderStatus.toLowerCase() === status.toLowerCase() ? 'block' : 'none';
                    }
                });
            }

            // Function to show tracking details
            function showTrackingDetails(orderId) {
                trackingDetails.classList.add('active');
                emptyState.style.display = 'none';
                orderIdCell.textContent = orderId;
                orderNumberInput.value = orderId;

                document.getElementById('<%= hiddenOrderId.ClientID %>').value = orderId;
            __doPostBack('', '');
            }

            // Event listeners
            allOrdersBtn.addEventListener('click', function () {
                updateFilterButtons(this);
                filterOrders('all');
            });

            processingBtn.addEventListener('click', function () {
                updateFilterButtons(this);
                filterOrders('Processing');
            });

            deliveredBtn.addEventListener('click', function () {
                updateFilterButtons(this);
                filterOrders('Delivered');
            });

            // Track button in search box
            trackButton.addEventListener('click', function () {
                const orderId = orderNumberInput.value.trim();
                if (orderId) {
                    showTrackingDetails(orderId);
                } else {
                    alert('Please enter a valid order number');
                }
            });

            // Order card click - handles clicks anywhere on the card
            document.querySelectorAll('.order-card').forEach(card => {
                card.addEventListener('click', function () {
                    const orderId = this.getAttribute('data-order-id');
                    showTrackingDetails(orderId);
                });
            });

            // Enter key in input field
            orderNumberInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    trackButton.click();
                }
            });

            printButton.addEventListener('click', function () {
                const printContent = document.getElementById('printSection').parentElement.innerHTML;
                const links = printSection.querySelectorAll('a');
                links.forEach(link => {
                    link.parentNode.removeChild(link);
                });

                // Remove any elements with "Generate Bills" text
                const elements = printSection.querySelectorAll('*');
                elements.forEach(el => {
                    if (el.textContent.includes('Generate Bills')) {
                        el.parentNode.removeChild(el);
                    }
                });
                const originalContent = document.body.innerHTML;
                document.body.innerHTML = `
                    <style>
                        @media print {
                            body {
                                margin: 0 !important;
                                padding: 10px !important;
                                width: 100% !important;
                            }
                            .orders {
                                width: 100% !important;
                                display: table !important;
                                border-collapse: collapse;
                            }
                            .o1,
                            .t1 {
                                white-space: nowrap;
                            }
                            .t2 {
                                border-top: 2px solid #DDD;
                            }
                            .orders thead th {
                                background-color: #000 !important;
                                color: #fff !important;
                                -webkit-print-color-adjust: exact;
                                print-color-adjust: exact;
                            }
                            .no-print {
                                display: none !important;
                            }
                            .address {
                                word-wrap: break-word;
                                white-space: normal;
                                max-width: 100%;
                            }
                            .restaurant-name {
                                display: block !important;
                            }
                            a {
                                text-decoration: none !important;
                                color: inherit !important;
                            }
                        }
                    </style>
                    <div style="max-width: 800px; margin: 0 auto;">
                        <div class="text-center mb-8">
                            <h2 class="text-3xl font-bold text-gray-800">Kashtabhanjan</h2>
                            <p class="text-gray-600 mt-2">Kathiyawadi Food</p>
                        </div>
                        ${printContent}
                    </div>`;
                setTimeout(() => {
                    window.print();
                    document.body.innerHTML = originalContent;
                }, 100);
            });
        });
    </script>
</body>

</html>
