<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Dashboard" %>

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
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="container mx-auto px-4 h-16 flex items-center justify-between">
            <div class="font-['Pacifico'] text-2xl text-primary">logo</div>
            <div class="flex-1 max-w-xl mx-8">
                <div class="relative">
                    <input type="text" placeholder="Search for food, cuisines, restaurants..."
                        class="w-full h-10 pl-10 pr-4 rounded-full bg-gray-100 focus:outline-none focus:ring-2 focus:ring-primary/20 text-sm" />
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
        <div class="category-scroll overflow-x-auto flex gap-4 py-4 -mx-4 px-4">
            <button
                class="flex-shrink-0 px-6 py-2 bg-primary text-white rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-apps-line"></i>
                <span>All</span>
            </button>
            <button
                class="flex-shrink-0 px-6 py-2 bg-white hover:bg-gray-100 rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-restaurant-line"></i>
                <span>Italian</span>
            </button>
            <button
                class="flex-shrink-0 px-6 py-2 bg-white hover:bg-gray-100 rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-bowl-line"></i>
                <span>Asian</span>
            </button>
            <button
                class="flex-shrink-0 px-6 py-2 bg-white hover:bg-gray-100 rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-hamburger-line"></i>
                <span>Fast Food</span>
            </button>
            <button
                class="flex-shrink-0 px-6 py-2 bg-white hover:bg-gray-100 rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-cake-3-line"></i>
                <span>Desserts</span>
            </button>
            <button
                class="flex-shrink-0 px-6 py-2 bg-white hover:bg-gray-100 rounded-full !rounded-button flex items-center gap-2">
                <i class="ri-cup-line"></i>
                <span>Drinks</span>
            </button>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6 py-6">
            <asp:Repeater ID="MenuItemsRepeater" runat="server">
                <ItemTemplate>
                    <div class="bg-white rounded-lg shadow-sm overflow-hidden hover:shadow-md transition-shadow">
                        <div class="relative h-48">
                            <img src='<%# Eval("ImageUrl") %>' class="w-full h-full object-cover" alt='<%# Eval("Name") %>' />
                            <div class="absolute top-3 right-3 bg-white rounded-full p-2 shadow-md">
                                <i class="ri-heart-line text-gray-400 hover:text-primary cursor-pointer"></i>
                            </div>
                        </div>
                        <div class="p-4">
                            <div class="flex items-center justify-between mb-2">
                                <h3 class="font-semibold text-gray-800"><%# Eval("Name") %></h3>
                                <span class="text-primary font-bold">$<%# Eval("Price") %></span>
                            </div>
                            <p class="text-sm text-gray-600 mb-3">
                                <%# Eval("Description") %>
                            </p>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-1">
                                    <i class="ri-star-fill text-yellow-400"></i>
                                    <%--<span class="text-sm text-gray-600"><%# Eval("Rating") %> (<%# Eval("ReviewCount") %>)</span>--%>
                                </div>
                                <button class="px-4 py-2 bg-primary text-white rounded !rounded-button hover:bg-opacity-90">
                                    Add to Cart
                                </button>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <div id="userPanel"
        class="fixed top-0 right-0 bottom-0 w-80 bg-white shadow-lg transform translate-x-full transition-transform duration-300 z-50">
        <div class="p-6">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-semibold">Profile</h2>
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


