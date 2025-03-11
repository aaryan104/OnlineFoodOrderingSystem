﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Dashboard" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Food Delivery Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FEA116",
                        secondary: "#4ECDC4",
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
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        .category-scroll::-webkit-scrollbar {
            display: none;
        }

        .cart-panel {
            transform: translateX(100%);
            transition: transform 0.3s ease-in-out;
        }

        .cart-panel.active {
            transform: translateX(0);
        }

        .modal {
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }

        .modal.active {
            opacity: 1;
            visibility: visible;
        }
        .card {
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .card-content {
            flex-grow: 1; /* Ensures content takes all space */
        }

        /*.card-footer {
            margin-top: auto;*/ /* Pushes the button to the bottom */
        /*}*/
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="container mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <img src="../../Asset/Library/img/logo.jpg" height="60px" width="60px" alt="Logo" />
                <h1 class="font-['Pacifico'] text-2xl text-primary m-0">Kashtabhanjan</h1>
            </div>

            <div class="flex-1 max-w-xl mx-8">
                <div class="relative">
                    <form runat="server">
                        <asp:TextBox ID="searchInput" placeholder="Search for food, cuisines, restaurants..."
                            class="w-full h-10 pl-10 pr-4 rounded-full bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary/20 text-sm"  
                            runat="server" OnTextChanged="searchInput_TextChanged" AutoPostBack="True"></asp:TextBox>
                        <div class="absolute left-3 top-0 h-10 w-5 flex items-center justify-center">
                            <i class="ri-search-line text-gray-400"></i>
                        </div>
                </div>
            </div>
            <div class="flex items-center gap-4">
                <button class="relative w-10 h-10 flex items-center justify-center hover:bg-gray-100 rounded-full">
                    <i class="ri-notification-3-line text-gray-600"></i>
                    <span
                        class="absolute top-1 right-1 w-4 h-4 bg-primary text-white text-xs flex items-center justify-center rounded-full">3</span>
                </button>
                <button id="cartBtn"
                    class="relative w-10 h-10 flex items-center justify-center hover:bg-gray-100 rounded-full">
                    <i class="ri-shopping-cart-line text-gray-600"></i>
                    <span
                        class="absolute top-1 right-1 w-4 h-4 bg-primary text-white text-xs flex items-center justify-center rounded-full">2</span>
                </button>
                <button class="w-10 h-10 rounded-full bg-gray-200 flex items-center justify-center" id="profileBtn">
                    <i class="ri-user-line text-gray-600"></i>
                </button>
            </div>
        </div>
    </header>
    <div class="container mx-auto px-4 pt-20">
        <div class="sticky top-16 bg-white shadow-sm z-40">
            <div class="container mx-auto px-4">
                <div class="category-scroll flex gap-4 py-4 overflow-x-auto whitespace-nowrap">
                    
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="category-scroll flex gap-2">
                                    <asp:LinkButton ID="btnAll" runat="server" class="px-6 py-2 bg-primary text-white rounded-full flex items-center gap-2" OnClick="btnAll_Click">
                                        <i class="ri-apps-line"></i>
                                        <span>All</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDinner" runat="server" class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2" OnClick="btnDinner_Click">
                                        <i class="ri-restaurant-line"></i>
                                        <span>Dinner</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnBreakfast" runat="server" class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2" OnClick="btnBreakfast_Click">
                                        <i class="ri-bowl-line"></i>
                                        <span>Breakfast</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnFastFood" runat="server" class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2" OnClick="btnFastFood_Click">
                                        <i class="ri-burger-line"></i>
                                        <span>Fast Food</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDrinks" runat="server" class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2" OnClick="btnDrinks_Click">
                                        <i class="ri-cake-3-line"></i>
                                        <span>Drinks</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLunch" runat="server" class="px-6 py-2 bg-gray-100 hover:bg-gray-200 rounded-full flex items-center gap-2" OnClick="btnLunch_Click">
                                        <i class="ri-plant-line"></i>
                                        <span>Lunch</span>
                                    </asp:LinkButton>
                                </div>
                    </div>
                </div>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 py-6">
                <asp:Repeater ID="MenuItemsRepeater" runat="server">
                    <ItemTemplate>
                        <div class="bg-white rounded-lg shadow-sm overflow-hidden hover:shadow-md transition-shadow card">
                            <div class="relative h-48">
                                <img src='<%# Eval("ImageUrl") %>' class="w-full h-full object-cover" alt='<%# Eval("Name") %>' />
                                <div class="absolute top-3 right-3 bg-white rounded-full p-2 shadow-md">
                                    <i class="ri-heart-line text-gray-400 hover:text-primary cursor-pointer"></i>
                                </div>
                            </div>
                            <div class="p-4 card-content">
                                <div class="flex items-center justify-between mb-2">
                                    <h3 class="font-semibold text-gray-800"><%# Eval("Name") %></h3>
                                    <span class="text-primary font-bold">₹<%# Eval("Price") %></span></div>
                                <p class="text-sm text-gray-600 mb-3">
                                    <%# Eval("Description") %>
                                </p>
                            </div>
                            <div class="p-4 flex items-center justify-between card-footer">
                                <div class="flex items-center gap-1">
                                    <i class="ri-star-fill text-yellow-400"></i>
                                    <span class="text-sm text-gray-600"><%# Eval("Category") %></span>
                                </div>
                                <button class="px-4 py-2 bg-primary text-white rounded !rounded-button hover:bg-opacity-90">
                                    Add to Cart
                                </button>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </form>
            </div>
        </div>
   
        <div id="userPanel"
            class="fixed top-0 right-0 bottom-0 w-80 bg-white shadow-lg transform translate-x-full transition-transform duration-300 z-50">
            <div class="p-6">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-semibold">Profiletext-xl font-semibold">Profile</h2>
                    <button class="w-8 h-8 flex items-center justify-center" id="closeProfileBtn">
                        <i class="ri-close-line text-xl"></i>
                    </button>
                </div>
                <div class="flex items-center gap-4 mb-6">
                    <div class="w-16 h-16 rounded-full bg-gray-200 flex items-center justify-center">
                        <i class="ri-user-line text-gray-600 text-2xl"></i>
                    </div>
                    <div>
                        <h3 class="font-semibold">Emma Wilson</h3>
                        <p class="text-sm text-gray-600">emma.wilson@email.com</p>
                    </div>
                </div>
                <div class="space-y-4">
                    <button class="w-full px-4 py-2 text-left flex items-center gap-3">
                        <i class="ri-history-line"></i>
                        <span>Order History</span>
                    </button>
                    <button class="w-full px-4 py-2 text-left flex items-center gap-3">
                        <i class="ri-map-pin-line"></i>
                        <span>Saved Addresses</span>
                    </button>
                    <button class="w-full px-4 py-2 text-left flex items-center gap-3">
                        <i class="ri-heart-line"></i>
                        <span>Favorites</span>
                    </button>
                    <button class="w-full px-4 py-2 text-left flex items-center gap-3">
                        <i class="ri-settings-3-line"></i>
                        <span>Settings</span>
                    </button>
                    <button class="w-full px-4 py-2 text-left flex items-center gap-3 text-red-500">
                        <i class="ri-logout-box-line"></i>
                        <span>Logout</span>
                    </button>
                </div>
            </div>
        </div>
    <button id="supportBtn"
        class="fixed bottom-6 right-6 w-14 h-14 bg-primary text-white rounded-full shadow-lg flex items-center justify-center hover:bg-primary/90">
        <i class="ri-customer-service-2-line text-xl"></i>
    </button>
    <script>
        document.querySelectorAll('.category-scroll a').forEach(button => {
            button.addEventListener('click', (e) => {
                // Remove active class from all buttons
                document.querySelectorAll('.category-scroll a').forEach(btn => {
                    btn.classList.remove('bg-primary', 'text-white');
                    btn.classList.add('bg-gray-100', 'hover:bg-gray-200');
                });
                // Add active class to clicked button
                button.classList.remove('bg-gray-100', 'hover:bg-gray-200');
                button.classList.add('bg-primary', 'text-white');
                // Update food grid based on category
                const category = button.textContent.trim().toLowerCase().replace(/\s+/g, '');
                updateFoodGrid(category);
            });
        });

        const cartBtn = document.getElementById("cartBtn");
        const closeCartBtn = document.getElementById("closeCartBtn");
        const userPanel = document.getElementById("userPanel");
        const profileBtn = document.getElementById("profileBtn");
        const closeProfileBtn = document.getElementById("closeProfileBtn");
        const cartPanel = document.getElementById("cartPanel");
        const orderTrackingModal = document.getElementById("orderTrackingModal");
        const closeTrackingBtn = document.getElementById("closeTrackingBtn");
        const supportBtn = document.getElementById("supportBtn");

        cartBtn.addEventListener("click", () => {
            cartPanel.classList.add("active");
        });
        closeCartBtn.addEventListener("click", () => {
            cartPanel.classList.remove("active");
        });
        profileBtn.addEventListener("click", () => {
            userPanel.classList.remove("translate-x-full");
        });
        closeProfileBtn.addEventListener("click", () => {
            userPanel.classList.add("translate-x-full");
        });
        supportBtn.addEventListener("click", () => {
            orderTrackingModal.classList.add("active");
        });
        closeTrackingBtn.addEventListener("click", () => {
            orderTrackingModal.classList.remove("active");
        });
        document.addEventListener("click", (e) => {
            if (!userPanel.contains(e.target) && e.target !== profileBtn) {
                userPanel.classList.add("translate-x-full");
            }

            if (e.target === orderTrackingModal) {
                orderTrackingModal.classList.remove("active");
            }
        });


    </script>
</body>
</html>