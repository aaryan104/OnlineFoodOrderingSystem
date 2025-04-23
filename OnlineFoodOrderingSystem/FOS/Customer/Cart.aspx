<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Cart" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart | Food Delivery</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <style>
        :root {
            --primary: #FEA116;
            --primary-light: #FF9842;
            --primary-dark: #CC5600;
            --text: #333333;
            --light-gray: #F5F5F5;
            --medium-gray: #E0E0E0;
            --dark-gray: #757575;
            --white: #FFFFFF;
        }
        
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .cart-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .cart-header h1 {
            color: var(--primary);
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .cart-content {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .product-section {
            flex: 2;
            background: var(--white);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .cart-summary {
            flex: 1;
            background: var(--white);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .cart-item {
            display: flex;
            gap: 20px;
            padding: 20px 0;
            border-bottom: 1px solid var(--medium-gray);
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .product-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .product-price {
            color: var(--primary);
            font-weight: 700;
            font-size: 1.1rem;
            margin: 10px 0;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            margin: 15px 0;
        }
        
        .quantity-btn {
            width: 30px;
            height: 30px;
            background: var(--medium-gray);
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }
        
        .quantity-input {
            width: 50px;
            height: 30px;
            text-align: center;
            margin: 0 10px;
            border: 1px solid var(--medium-gray);
            border-radius: 4px;
        }
        
        .remove-btn {
            background: none;
            border: none;
            color: var(--dark-gray);
            cursor: pointer;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .remove-btn:hover {
            color: var(--primary);
        }
        
        .summary-title {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--primary);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin: 15px 0;
        }
        
        .total-row {
            border-top: 1px solid var(--medium-gray);
            padding-top: 15px;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .checkout-btn {
            width: 100%;
            padding: 15px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: background 0.3s;
        }
        
        .checkout-btn:hover {
            background: var(--primary-dark);
        }
        
        .button-container {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }

        .continue-btn {
            padding: 12px 17px;
            background: var(--white);
            color: var(--primary);
            border: 2px solid var(--primary);
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            text-decoration: none;
        }

        .continue-btn:hover {
            background: var(--primary-light);
            color: white;
        }

        
        @media (max-width: 768px) {
            .cart-content {
                flex-direction: column;
            }
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <span class="text-2xl font-['Pacifico'] text-primary">
                    <img src="../../Asset/Library/img/logo.jpg" class="h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14" alt="Logo" /></span>
            </div>
            <div class="flex items-center gap-6">
                <div>
                    <a href="../Index.aspx"><i class="ri-logout-box-line" style="font-size: 20px; cursor: pointer" title="Logout"></i></a>
                </div>
                <div class="relative cursor-pointer" id="cartButton">
                    <i class="ri-shopping-cart-line text-xl"></i>
                    <span class="absolute -top-2 -right-2 bg-primary text-white text-xs rounded-full w-5 h-5 flex items-center justify-center" id="cartCount">0</span>
                </div>
                <div class="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center cursor-pointer">
                    <a href="UserProfile.aspx"><i class="ri-user-line"></i></a>
                </div>
            </div>
        </div>
    </header>

    <div class="cart-container pt-24">
        <div class="cart-header">
            <h1>Your Shopping Cart</h1>
            <p>Review and checkout your items</p>
        </div>
        
        <div class="cart-content">
            <div class="product-section" id="cartItemsContainer">
                <!-- Cart items will be loaded here -->
                <div class="text-gray-500 text-center py-10">
                    Loading your cart...
                </div>
            </div>
            
            <div class="cart-summary">
                <h2 class="summary-title">Order Summary</h2>
                
                <div class="summary-row">
                    <span>Subtotal (<span id="itemCount">0</span> items)</span>
                    <span id="subtotal">₹0</span>
                </div>
                
                <div class="summary-row">
                    <span>Delivery Fee</span>
                    <span id="deliveryFee">FREE</span>
                </div>
                
                <div class="summary-row">
                    <span>Tax (5%)</span>
                    <span id="tax">₹0</span>
                </div>
                
                <div class="summary-row total-row">
                    <span>Total</span>
                    <span id="total">₹0</span>
                </div>

                <div class="button-container">
                    <a href="scratch.aspx" class="continue-btn">Scratch Coupon</a>
                    <a href="Home.aspx" class="continue-btn">Continue Shopping</a>
                </div>

                
                <button class="checkout-btn" id="checkoutBtn">Proceed to Checkout</button>
            </div>
        </div>
    </div>

    <script>
        let cart = JSON.parse(localStorage.getItem('cart')) || [];

        updateCartCount();

        displayCartItems();

        function updateCartCount() {
            const totalItems = cart.reduce((sum, item) => sum + item.quantity, 0);
            document.getElementById('cartCount').textContent = totalItems;
        }

        function displayCartItems() {
            const cartItemsContainer = document.getElementById('cartItemsContainer');

            if (cart.length === 0) {
                cartItemsContainer.innerHTML = `
                    <div class="text-gray-500 text-center py-10">
                        Your cart is empty
                    </div>
                `;
                updateOrderSummary(0);
                document.getElementById('checkoutBtn').disabled = true;
                return;
            }

            let itemsHTML = '';
            let subtotal = 0;

            cart.forEach(item => {
                const price = parseFloat(item.price);
                const itemTotal = price * item.quantity;
                subtotal += itemTotal;

                itemsHTML += `
                    <div class="cart-item" data-id="${item.id}">
                        <img src="${item.image}" alt="${item.name}" class="product-image">
                        <div class="product-details">
                            <h3 class="product-title">${item.name}</h3>
                            <div class="product-price">₹${price.toFixed(2)}</div>
                            <div class="quantity-control">
                                <button class="quantity-btn" onclick="updateQuantity('${item.id}', -1)">-</button>
                                <input type="number" value="${item.quantity}" min="1" class="quantity-input" id="quantity-${item.id}" onchange="updateQuantityInput('${item.id}')">
                                <button class="quantity-btn" onclick="updateQuantity('${item.id}', 1)">+</button>
                            </div>
                            <button class="remove-btn" onclick="removeItem('${item.id}')">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M3 6h18M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                </svg>
                                Remove
                            </button>
                        </div>
                    </div>
                `;
            });

            cartItemsContainer.innerHTML = itemsHTML;
            updateOrderSummary(subtotal);
        }

        function updateQuantity(itemId, change) {
            const item = cart.find(item => item.id == itemId);

            if (item) {
                item.quantity += change;

                if (item.quantity <= 0) {
                    cart = cart.filter(i => i.id != itemId);
                }

                saveCart();
                updateCartCount();
                displayCartItems(); 
            }
        }

        function updateQuantityInput(itemId) {
            const input = document.getElementById(quantity-`${itemId}`);
            const newQuantity = parseInt(input.value) || 1;

            const item = cart.find(item => item.id == itemId);
            if (item) {
                item.quantity = newQuantity;
                saveCart();
                updateCartCount();
                displayCartItems();
            }
        }

        function removeItem(itemId) {
            cart = cart.filter(item => item.id != itemId);
            saveCart();
            updateCartCount();
            displayCartItems(); 
        }

        function updateOrderSummary(subtotal) {
            const itemCount = cart.reduce((sum, item) => sum + item.quantity, 0);
            const tax = subtotal * 0.05; 
            const total = subtotal + tax;

            document.getElementById('itemCount').textContent = itemCount;
            document.getElementById('subtotal').textContent = `₹${subtotal.toFixed(2)}`;
            document.getElementById('tax').textContent = `₹${tax.toFixed(2)}`;
            document.getElementById('total').textContent = `₹${total.toFixed(2)}`;

            document.getElementById('checkoutBtn').disabled = itemCount === 0;
        }

        function saveCart() {
            localStorage.setItem('cart', JSON.stringify(cart));
        }

        document.getElementById('checkoutBtn').addEventListener('click', function () {
            if (cart.length > 0) {
                alert('Proceeding to checkout!');
            }
        });
    </script>
</body>
</html>
