<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Checkout" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - Food Delivery</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <span class="text-2xl font-['Pacifico'] text-primary">
                    <img src="../../Asset/Library/img/logo.jpg" class="h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14" alt="Logo" />
                </span>
            </div>
            <div class="flex items-center gap-6">
                <div>
                    <a href="../Index.aspx"><i class="ri-logout-box-line" style="font-size: 20px; cursor: pointer" title="Logout"></i></a>
                </div>
                <div class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center cursor-pointer">
                    <a href="UserProfile.aspx"><i class="ri-user-line"></i></a>
                </div>
            </div>
        </div>
    </header>

    <main class="max-w-7xl mx-auto px-4 pt-24 pb-16">
        <div class="bg-white rounded-lg shadow-md p-6">
            <h1 class="text-2xl font-bold mb-6">Checkout</h1>
            
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <!-- Order Summary -->
                <div class="md:col-span-2">
                    <h2 class="text-xl font-semibold mb-4">Order Summary</h2>
                    <div id="orderItems" class="space-y-4">
                        <!-- Items will be populated from server-side -->
                        <asp:Repeater ID="rptOrderItems" runat="server">
                            <ItemTemplate>
                                <div class="flex items-center justify-between border-b pb-4">
                                    <div class="flex items-center gap-4">
                                        <img src='<%# Eval("ImageUrl") %>' class="w-16 h-16 object-cover rounded-lg" alt='<%# Eval("Name") %>' />
                                        <div>
                                            <h3 class="font-medium"><%# Eval("Name") %></h3>
                                            <p class="text-gray-600 text-sm">₹<%# Eval("Price") %> x <%# Eval("Quantity") %></p>
                                        </div>
                                    </div>
                                    <span class="font-medium">₹<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="mt-6 border-t pt-4">
                        <div class="flex justify-between mb-2">
                            <span>Subtotal:</span>
                            <span class="font-medium" id="subtotal" runat="server">₹0</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span>Delivery Fee:</span>
                            <span class="font-medium">₹40</span>
                        </div>
                        <div class="flex justify-between text-lg font-bold mt-4">
                            <span>Total:</span>
                            <span class="text-primary" id="totalAmount" runat="server">₹0</span>
                        </div>
                    </div>
                </div>

                <!-- Payment and Delivery -->
                <div>
                    <h2 class="text-xl font-semibold mb-4">Delivery Information</h2>
                    <div class="bg-gray-50 p-4 rounded-lg mb-6">
                        <div class="flex items-center gap-3 mb-3">
                            <i class="ri-map-pin-line text-primary"></i>
                            <div>
                                <h3 class="font-medium">Delivery Address</h3>
                                <p class="text-gray-600 text-sm" id="deliveryAddress" runat="server">Loading address...</p>
                            </div>
                        </div>
                        <button class="text-primary text-sm font-medium mt-2" onclick="changeAddress()">Change Address</button>
                    </div>

                    <h2 class="text-xl font-semibold mb-4">Payment Method</h2>
                    <div class="space-y-3 mb-6">
                        <div class="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:border-primary">
                            <input type="radio" id="cashOnDelivery" name="paymentMethod" value="COD" checked class="h-4 w-4 text-primary" />
                            <label for="cashOnDelivery" class="flex-1 cursor-pointer">
                                <span class="block font-medium">Cash on Delivery</span>
                                <span class="block text-gray-600 text-sm">Pay when you receive your order</span>
                            </label>
                            <i class="ri-money-dollar-circle-line text-xl text-gray-400"></i>
                        </div>
                        <div class="flex items-center gap-3 p-3 border rounded-lg cursor-pointer hover:border-primary">
                            <input type="radio" id="onlinePayment" name="paymentMethod" value="Online" class="h-4 w-4 text-primary" />
                            <label for="onlinePayment" class="flex-1 cursor-pointer">
                                <span class="block font-medium">Online Payment</span>
                                <span class="block text-gray-600 text-sm">Pay with credit/debit card or UPI</span>
                            </label>
                            <i class="ri-bank-card-line text-xl text-gray-400"></i>
                        </div>
                    </div>

                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                        CssClass="w-full bg-primary text-white py-3 rounded-lg font-semibold hover:bg-opacity-90" 
                        OnClick="btnPlaceOrder_Click" />
                </div>
            </div>
        </div>
    </main>

    <script>
        function changeAddress() {
            // Implement address change functionality
            alert("Address change functionality will be implemented here");
        }
    </script>
</body>
</html>