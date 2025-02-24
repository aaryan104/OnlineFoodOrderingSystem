<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Order delicious food from your favorite restaurants online.">
    <meta property="og:title" content="Foodie Haven - Your Favorite Food, Delivered Fast!">
    <meta property="og:description" content="Order delicious food from your favorite restaurants online.">
    <meta property="og:image" content="/path/to/your/og-image.jpg">
    <title>Foodie Haven</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { 
            font-family: 'Inter', sans-serif; 
        }
        .logo { 
            font-family: 'Pacifico', cursive; 
        }
        .rounded-button { 
            @apply bg-orange-500 text-white px-6 py-2 rounded-full shadow-md hover:bg-orange-600 transition; 
        }
        h1 {
            text-align: left;
        }
    </style>
</head>
<body class="bg-gray-100">
    <nav class="bg-white shadow-md p-4 flex items-center justify-between z-50">
        <!-- Logo and Name container aligned to the left -->
        <div class="flex items-center space-x-2">
            <img src="../../Asset/Library/img/logo.jpg" height="50px" width="50px" alt="">
            <h1 class="text-2xl logo text-orange-500">Kashtabhanjan</h1>
        </div>
    
        <!-- Search bar centered with the remaining space -->
        <input type="text" placeholder="Search for restaurants..." class="border p-2 rounded-md w-1/3 focus:ring-2 focus:ring-orange-500">

        <!-- Buttons aligned to the right -->
        <div class="flex space-x-4">
            <button class="text-gray-600 hover:text-orange-500">🔔</button>
            <button class="text-gray-600 hover:text-orange-500">🛒</button>
        </div>
    </nav>

    
    <section class="p-6">
        <h2 class="text-3xl font-semibold mb-4">Popular Restaurants</h2>
        <div id="restaurant-list" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            <!-- Restaurants dynamically injected here -->
            <asp:Repeater ID="MenuItemsRepeater" runat="server">
                <ItemTemplate>
                    <div class="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition">
                        <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="rounded-lg w-full h-40 object-cover" loading="lazy">
                        <h3 class="text-xl font-semibold mt-2"><%# Eval("Name") %></h3>
                        <p class="text-gray-600"><%# Eval("Category") %></p>
                        <p class="text-gray-800 font-semibold mt-1"><%# Eval("Price", "{0:C}") %></p>
                        <p class="text-gray-500 mt-2"><%# Eval("Description") %></p>
                        <button class="bg-orange-500 text-white px-6 py-2 rounded-full shadow-md mt-3 hover:bg-orange-600">Add to Cart</button>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</body>
</html>


