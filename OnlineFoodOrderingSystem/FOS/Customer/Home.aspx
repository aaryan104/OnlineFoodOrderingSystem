<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Dashboard" %>

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
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .category-tab:hover {
            background-color: darkgrey;
        }

        .category-tab {
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            letter-spacing: 0.025em;
        }

        .category-tab.active {
            background-color: rgba(254, 161, 22, 0.15) !important;
            color: #FEA116 !important;
            border-bottom: 2px solid #FEA116;
            font-weight: 600;
        }

        .category-tab:not(.active) {
            color: rgb(107, 114, 128);
            background-color: transparent;
        }

        .category-tab:not(.active):hover {
            background-color: #FEA116;
            color: white;
        }
        
        .order {
            color: #FEA116;
            border: 2px solid #FEA116;
            padding: 8px 15px;
            border-radius: 20px;
            transition: 0.3s ease;
        }

        .order:hover {
            background-color: #FEA116;
            color: white;
        }
    </style>
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
</head>

<body class="bg-gray-100 min-h-screen">
<form id="form1" runat="server">
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <span class="text-2xl font-['Pacifico'] text-primary">
                    <img src="../../Asset/Library/img/logo.jpg" class="h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14" alt="Logo" /></span>
                <%--<span class="text-xl font-semibold text-gray-700">Kastabhanjan</span>--%>
                &nbsp;Welcome, <asp:Label ID="txtName" runat="server" Text="" ForeColor="#FEA116"></asp:Label>
            </div>
            <div class="flex-1 max-w-2xl mx-6">
                <div class="relative">
                    <div class="absolute inset-y-0 left-3 flex items-center">
                        <i class="ri-map-pin-line text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="SearchInput" runat="server" ClientIDMode="Static"
                        placeholder="Search for food or restaurants"
                        class="w-full pl-9 pr-9 py-1 rounded-full border border-gray-200 focus:outline-none focus:border-primary" />
                    <div class="absolute inset-y-0 right-3 flex items-center">
                        <i class="ri-search-line text-gray-400"></i>
                    </div>
                </div>
            </div>
            <div class="flex items-center gap-6">
                <div>
                    <a href="trackOrder.aspx" class="order">My Orders</a>
                </div>
                <div>
                    <a href="../Index.aspx"><i class="ri-logout-box-line" style="font-size: 20px; cursor: pointer" title="Logout"></i></a>
                </div>
                <div class="relative cursor-pointer" id="cartButton">
                    <i class="ri-shopping-cart-line text-xl"></i>
                    <span class="absolute -top-2 -right-2 bg-primary text-white text-xs rounded-full w-5 h-5 flex items-center justify-center" id="cartCount">0</span>
                    <div id="cartDropdown" class="absolute right-0 top-full mt-4 w-80 bg-white rounded-lg shadow-lg hidden">
                        <div class="p-4">
                            <div id="cartItems" class="space-y-2">
                                <div class="text-gray-500 text-center py-4">
                                    Your cart is empty
                                </div>
                            </div>
                            <br />
                            <div class="flex justify-between mb-2">
                                <span>Subtotal:</span>
                                <h3 class="font-semibold mb-2">Shopping Cart</h3>
                            </div>
                            <a href="Cart.aspx" class="w-full bg-primary text-white py-2 rounded-button font-semibold hover:bg-opacity-90 block text-center">View Cart</a>
                        </div>
                    </div>
                </div>
                <div class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center cursor-pointer">
                    <a href="UserProfile.aspx"><i class="ri-user-line"></i></a>
                </div>
            </div>
        </div>
    </header>
    <main class="max-w-7xl mx-auto px-4 pt-24 pb-16">
            <input type="hidden" id="hiddenCategory" name="hiddenCategory" />
            <div class="categories mb-8">
                <div class="flex gap-4 overflow-x-auto py-2" id="categoryTabs">
                    <button class="category-tab px-6 py-2 rounded-button active" 
                            data-category="all" onclick="filterItems(this, 'all')">
                        All
                    </button>
                    <button class="category-tab px-6 py-2 rounded-button" 
                            data-category="Breakfast" onclick="filterItems(this, 'Breakfast')">
                        Breakfast
                    </button>
                    <button class="category-tab px-6 py-2 rounded-button" 
                            data-category="Lunch" onclick="filterItems(this, 'Lunch')">
                        Lunch
                    </button>
                    <button class="category-tab px-6 py-2 rounded-button" 
                            data-category="Dinner" onclick="filterItems(this, 'Dinner')">
                        Dinner
                    </button>
                    <button class="category-tab px-6 py-2 rounded-button" 
                            data-category="Drinks" onclick="filterItems(this, 'Drinks')">
                        Drinks
                    </button>
                    <button class="category-tab px-6 py-2 rounded-button" 
                            data-category="Fast-Food" onclick="filterItems(this, 'Fast-Food')">
                        Fast Food
                    </button>
                </div>
            </div>
        <div class="popular-dishes mb-12">
            <h2 class="text-2xl font-semibold mb-6 text-left">
                <div class="message flex flex-col items-start">
                    <asp:Label ID="msg" runat="server" Text="Popular All Dishes"></asp:Label>
                </div>
            </h2>
            <div id="menuContainer">
                <div class="grid gap-4 md:grid-cols-3 lg:grid-cols-4 sm:grid-cols-2" id="foodGrid">
                    <asp:Repeater ID="MenuItemsRepeater" runat="server">
                        <ItemTemplate>
                            <h1 id="noItemsMessage" class="text-center text-primary-500 text-2xl mt-6 hidden"><br /><br />No item found<br /></h1>
                            <div class="menu-item rounded-t-2xl overflow-hidden shadow-md hover:shadow-lg cursor-pointer">
                                <img src='<%# Eval("ImageUrl") %>' class="w-full h-48 object-cover" alt='<%# Eval("Name") %>'>
                                <div class="p-4">
                                    <div class="flex justify-between items-start mb-2">
                                        <h3 class="font-semibold text-lg"><%# Eval("Name") %></h3>
                                        <span class="text-xs px-2 py-1 bg-white-100 rounded-full capitalize"><%# Eval("Category") %></span>
                                    </div>
                                    <p class="text-gray-600 text-sm mb-4 line-clamp-2"><%# Eval("Description") %></p>
                                    <div class="flex items-center justify-between">
                                        <div class="flex flex-col">
                                            <span class="text-primary font-semibold text-lg">₹<%# Eval("Price") %></span>
                                            <span class="text-xs text-gray-500">Inclusive of taxes</span>
                                        </div>
                                        <button class="px-4 py-2 bg-primary text-white rounded-button hover:bg-opacity-90 whitespace-nowrap"
                                            onclick="addToCartDirect(<%# Eval("ItemId") %>, '<%# Eval("Name") %>', <%# Eval("Price") %>, '<%# Eval("ImageUrl") %>')">
                                            Add to Cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </main>

    <div id="foodModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
        <div class="bg-white rounded-lg max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto">
            <div class="p-6">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-2xl font-semibold" id="modalTitle"></h3>
                    <button class="text-gray-500 hover:text-gray-700" onclick="closeModal()">
                        <i class="ri-close-line text-2xl"></i>
                    </button>
                </div>
                <img id="modalImage" class="w-full h-64 object-cover rounded-lg mb-4" src="'<%# Eval("ImageUrl") %>'" alt="Food" />
                <p id="modalDescription" class="text-gray-600 mb-4"></p>
                <div class="flex items-center justify-between mb-6">
                    <div class="text-2xl font-semibold" id="modalPrice"></div>
                    <div class="flex items-center gap-4">
                        <button class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center"
                            onclick="updateQuantity(-1)">
                            <i class="ri-subtract-line"></i>
                        </button>
                        <span id="modalQuantity" class="text-xl">1</span>
                        <button class="w-8 h-8 rounded-full border border-gray-300 flex items-center justify-center"
                            onclick="updateQuantity(1)">
                            <i class="ri-add-line"></i>
                        </button>
                    </div>
                </div>
                <button class="w-full bg-primary text-white py-3 rounded-button font-semibold hover:bg-opacity-90"
                    onclick="addToCart()">
                    Add to Cart
                </button>
            </div>
        </div>
    </div>

    <footer class="bg-gray-200 border-t">
        <div class="max-w-7xl mx-auto px-4 py-12">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <h3 class="text-lg font-semibold mb-4">About Us</h3>
                    <ul class="space-y-2 text-gray-600">
                        <li><a href="#" class="hover:text-primary">Our Story</a></li>
                        <li><a href="#" class="hover:text-primary">Blog</a></li>
                        <li><a href="#" class="hover:text-primary">Careers</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Support</h3>
                    <ul class="space-y-2 text-gray-600">
                        <li><a href="#" class="hover:text-primary">Help Center</a></li>
                        <li><a href="#" class="hover:text-primary">Safety Center</a></li>
                        <li>
                            <a href="#" class="hover:text-primary">Community Guidelines</a>
                        </li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Legal</h3>
                    <ul class="space-y-2 text-gray-600">
                        <li>
                            <a href="#" class="hover:text-primary">Terms of Service</a>
                        </li>
                        <li><a href="../Privacy_Policy.aspx" class="hover:text-primary">Privacy Policy</a></li>
                        <li><a href="#" class="hover:text-primary">Cookie Policy</a></li>
                    </ul>
                </div>
                <div>
                    <h3 class="text-lg font-semibold mb-4">Install App</h3>
                    <div class="flex flex-col gap-4">
                        <a href="#" class="flex items-center gap-2 text-gray-600 hover:text-primary">
                            <i class="ri-apple-fill text-2xl"></i>
                            <span>Download on the<br />
                                App Store</span>
                        </a>
                        <a href="#" class="flex items-center gap-2 text-gray-600 hover:text-primary">
                            <i class="ri-google-play-fill text-2xl"></i>
                            <span>Get it on<br />
                                Google Play</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="mt-12 pt-8 border-t">
                <div class="flex flex-col md:flex-row items-center justify-between gap-4">
                    <p class="text-gray-600">
                        © 2025 Food Delivery. All rights reserved.
                    </p>
                    <div class="flex gap-6">
                        <a href="#" class="text-gray-600 hover:text-primary">
                            <i class="ri-facebook-fill text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-600 hover:text-primary">
                            <i class="ri-twitter-fill text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-600 hover:text-primary">
                            <i class="ri-instagram-fill text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-600 hover:text-primary">
                            <i class="ri-youtube-fill text-xl"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</form>
   <script>
       function filterItems(button, category) {
           document.querySelectorAll('.category-tab').forEach(btn => {
               btn.classList.remove('active');
           });

           button.classList.add('active');

           document.getElementById('hiddenCategory').value = category;
           document.getElementById('form1').submit();
       }

       document.addEventListener('DOMContentLoaded', function () {
            const currentCategory = '<%= Request.Form["hiddenCategory"] ?? "all" %>';
            const activeButton = document.querySelector(`.category-tab[data-category="${currentCategory}"]`);
            if (activeButton) {
                activeButton.classList.add('active');
            }
       });

       document.addEventListener("DOMContentLoaded", function () {
           const searchInput = document.getElementById("SearchInput");
           const noItemsMessage = document.getElementById("noItemsMessage");

           searchInput.addEventListener("input", function () {
               const searchTerm = this.value.toLowerCase();
               const items = document.querySelectorAll(".menu-item");
               let visibleCount = 0;

               items.forEach(item => {
                   const text = item.textContent.toLowerCase();
                   const isVisible = text.includes(searchTerm);
                   item.style.display = isVisible ? "" : "none";
                   if (isVisible) visibleCount++;
               });

               if (visibleCount === 0) {
                   noItemsMessage.classList.remove("hidden");
               } else {
                   noItemsMessage.classList.add("hidden");
               }
           });
       });

       let cart = JSON.parse(localStorage.getItem('cart')) || [];
       let currentQuantity = 1;
       let currentItem = null;

       updateCartCount();

       const cartButton = document.getElementById('cartButton');
       const cartDropdown = document.getElementById('cartDropdown');

       cartButton.addEventListener('click', () => {
           cartDropdown.classList.toggle('hidden');
           updateCartDropdown();
       });

       document.addEventListener('click', (e) => {
           if (!cartButton.contains(e.target) && !cartDropdown.contains(e.target)) {
               cartDropdown.classList.add('hidden');
           }
       });

       function updateCategories(category) {
           currentCategory = category;
           const tabs = document.querySelectorAll("#categoryTabs button");
           tabs.forEach((tab) => {
               if (tab.dataset.category === category) {
                   tab.classList.remove("bg-gray-100", "text-gray-600");
                   tab.classList.add("bg-primary", "text-white");
               } else {
                   tab.classList.remove("bg-primary", "text-white");
                   tab.classList.add("bg-gray-100", "text-gray-600");
               }
           });
           displayFoodItems(category);
       }

       document.querySelectorAll("#categoryTabs button").forEach((button) => {
           button.addEventListener("click", () => {
               updateCategories(button.dataset.category);
           });
       });

       function filterItems(button) {
           var category = button.getAttribute('data-category');
           document.getElementById('hiddenCategory').value = category;
           document.getElementById('form1').submit();
       }

       function openModal(itemId) {
           currentItem = {
               id: itemId,
               name: "Sample Item",
               price: 199,
               image: "https://via.placeholder.com/120",
               description: "Sample description",
               category: "Sample Category"
           };
           currentQuantity = 1;
           document.getElementById("modalTitle").textContent = currentItem.name;
           document.getElementById("modalImage").src = currentItem.image;
           document.getElementById("modalDescription").textContent = currentItem.description;
           document.getElementById("modalPrice").textContent = `₹${currentItem.price}`;
           document.getElementById("modalQuantity").textContent = currentQuantity;

           const modalContent = document.querySelector("#foodModal .p-6");
           const categoryTag = document.createElement("span");
           categoryTag.className = "inline-block px-3 py-1 bg-gray-100 rounded-full text-sm capitalize mb-4";
           categoryTag.textContent = currentItem.category;
           modalContent.insertBefore(
               categoryTag,
               document.getElementById("modalDescription"),
           );
           document.getElementById("foodModal").classList.remove("hidden");
           document.getElementById("foodModal").classList.add("flex");
           document.body.style.overflow = "hidden";
       }

       function closeModal() {
           document.getElementById("foodModal").classList.add("hidden");
           document.getElementById("foodModal").classList.remove("flex");
           document.body.style.overflow = "auto";
       }

       function updateQuantity(change) {
           currentQuantity = Math.max(1, currentQuantity + change);
           document.getElementById("modalQuantity").textContent = currentQuantity;
       }

       function addToCart() {
           if (!currentItem) return;

           const existingItem = cart.find(item => item.id === currentItem.id);

           if (existingItem) {
               existingItem.quantity += currentQuantity;
           } else {
               cart.push({
                   id: currentItem.id,
                   name: currentItem.name,
                   price: currentItem.price,
                   image: currentItem.image,
                   quantity: currentQuantity
               });
           }

           saveCart();
           updateCartCount();
           closeModal();

           alert(`${currentItem.name} added to cart!`);
       }

       function addToCartDirect(itemId, name, price, image) {
           const existingItem = cart.find(item => item.id == itemId);

           if (existingItem) {
               existingItem.quantity += 1;
           } else {
               cart.push({
                   id: itemId,
                   name: name,
                   price: price,
                   image: image,
                   quantity: 1
               });
           }

           saveCart();
           updateCartCount();

           alert(`${name} added to cart!`);
       }

       function updateCartCount() {
           const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
           document.getElementById('cartCount').textContent = totalItems;
       }

       function updateCartDropdown() {
           const cartItemsContainer = document.getElementById('cartItems');
           const subtotalElement = document.querySelector('#cartDropdown .font-semibold');

           if (cart.length === 0) {
               cartItemsContainer.innerHTML = `
                    <div class="text-gray-500 text-center py-4">
                        Your cart is empty
                    </div>
                `;
               subtotalElement.textContent = '₹0';
               return;
           }

           let itemsHTML = '';
           let subtotal = 0;

           cart.forEach(item => {
               const itemTotal = item.price * item.quantity;
               subtotal += itemTotal;

               itemsHTML += `
                    <div class="flex items-center justify-between py-2 border-b">
                        <div class="flex items-center gap-3">
                            <img src="${item.image}" class="w-12 h-12 object-cover rounded" alt="${item.name}">
                            <div>
                                <h4 class="font-medium">${item.name}</h4>
                                <div class="flex items-center gap-2 mt-1">
                                    <button class="text-xs w-5 h-5 flex items-center justify-center border rounded" 
                                        onclick="updateCartItemQuantity(${item.id}, -1, event)">-</button>
                                    <span>${item.quantity}</span>
                                    <button class="text-xs w-5 h-5 flex items-center justify-center border rounded" 
                                        onclick="updateCartItemQuantity(${item.id}, 1, event)">+</button>
                                </div>
                            </div>
                        </div>
                        <div class="font-semibold">₹${itemTotal.toFixed(2)}</div>
                    </div>
                `;
           });

           cartItemsContainer.innerHTML = itemsHTML;
           subtotalElement.textContent = `₹${subtotal.toFixed(2)}`;
       }

       function updateCartItemQuantity(itemId, change, event) {
           event.stopPropagation();
           const item = cart.find(item => item.id == itemId);

           if (item) {
               item.quantity += change;

               if (item.quantity <= 0) {
                   cart = cart.filter(i => i.id != itemId);
               }

               saveCart();
               updateCartCount();
               updateCartDropdown();
           }
       }

       function saveCart() {
           localStorage.setItem('cart', JSON.stringify(cart));
       }
   </script>
</body>
</html>