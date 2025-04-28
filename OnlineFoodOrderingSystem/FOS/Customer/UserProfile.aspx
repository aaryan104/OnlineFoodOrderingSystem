<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.UserProfile" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }
        #formModal {
            z-index: 60; /* Higher than header's z-50 */
        }
        .product-section {
            flex: 2;
            background: var(--white);
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#FEA116',
                        secondary: '#4ECDC4'
                    },
                    borderRadius: {
                        'none': '0px',
                        'sm': '4px',
                        DEFAULT: '8px',
                        'md': '12px',
                        'lg': '16px',
                        'xl': '20px',
                        '2xl': '24px',
                        '3xl': '32px',
                        'full': '9999px',
                        'button': '8px'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen">
    <header class="sticky top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <span class="text-2xl font-['Pacifico'] text-primary"><img src="../../Asset/Library/img/logo.jpg" class="h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14" alt="" /></span>
            </div>
            <div class="flex items-center gap-4">
                <button class="flex items-center gap-2 text-gray-600 hover:text-primary">
                    <i class="ri-notification-3-line text-xl"></i>
                </button>
                <button class="flex items-center gap-2 text-gray-600 hover:text-primary">
                    <i class="ri-settings-3-line text-xl"></i>
                </button>
            </div>
        </div>
    </header>
    <main class="max-w-7xl mx-auto px-4 pt-8 pb-16">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-8">
            <a href="Home.aspx" class="hover:text-primary">Home</a>
            <i class="ri-arrow-right-s-line"></i>
            <span>Profile</span>
        </div>
        <div class="message text-center flex flex-col items-center">
            <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
        </div>
        <div class="grid grid-cols-12 gap-8">
            <div class="col-span-12 lg:col-span-4">
                <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
                    <div class="flex items-start justify-between mb-6">
                        <div class="flex items-center gap-4">
                            <div class="relative">
                                <asp:Image ID="imgProfile" runat="server" class="w-20 h-20 rounded-full object-cover" alt="Profile" />
                                <button class="absolute bottom-0 right-0 w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center hover:bg-primary/90">
                                    <i class="ri-pencil-line text-sm"></i>
                                </button>
                            </div>
                            <div>
                                <h1 class="text-xl font-semibold text-gray-900"><asp:Label ID="lblFullName" runat="server" Text="..."></asp:Label></h1>
                                <p class="text-gray-500">Premium Member</p>
                            </div>
                        </div>
                        <button id="openFormBtn" class="text-sm text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                            Edit Profile
                        </button>
                        <div id="formModal" class="modal hidden fixed inset-0 bg-black/50 flex items-center justify-center">
                            <div class="flex items-center justify-center min-h-screen p-4">
                                <div class="modal-content bg-white rounded-lg shadow-xl w-full max-w-xl p-6 relative">
                                    <button id="closeFormBtn"
                                        class="absolute right-4 top-4 text-gray-500 hover:text-gray-700 cursor-pointer">
                                        <i class="ri-close-line w-6 h-6 flex items-center justify-center"></i>
                                    </button>

                                    <h2 class="text-2xl font-semibold text-gray-800 mb-6">
                                        Profile Information
                                    </h2>

                                    <div class="message text-center flex flex-col items-center">
                                        <asp:Label ID="msg1" runat="server" ForeColor="red" Text=""></asp:Label>
                                    </div>

                                    <form id="profileForm" class="space-y-6" runat="server">
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                            <div>
                                                <label class="block text-sm font-medium text-gray-700 mb-1">First Name *</label>
                                                <asp:TextBox ID="txtFirstname" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:border-primary"></asp:TextBox>
                                            </div>
                                            <div>
                                                <label class="block text-sm font-medium text-gray-700 mb-1">Last Name *</label>
                                                <asp:TextBox ID="txtLastname" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:border-primary"></asp:TextBox>
                                            </div>
                                        </div>

<%--                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
                                            <asp:TextBox ID="txtEmail" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:border-primary"></asp:TextBox>
                                        </div>--%>

                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Phone Number *</label>
                                            <asp:TextBox ID="txtPhone" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:border-primary" pattern="[0-9]{10}"></asp:TextBox>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Address *</label>
                                            <asp:TextBox ID="txtAddress" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:border-primary" rows="3"></asp:TextBox>
                                        </div>

                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Profile Photo</label>
                                            <div class="flex items-center space-x-4">
                                                <div id="imagePreview"
                                                    class="w-20 h-20 bg-gray-100 rounded flex items-center justify-center">
                                                    <i class="ri-image-line text-gray-400 text-2xl"></i>
                                                </div>
                                                <div class="flex-1">
                                                    <asp:FileUpload ID="photoInput" runat="server" class="hidden" accept="image/*" />
                                                    <button type="button" onclick="document.getElementById('photoInput').click()"
                                                        class="bg-gray-100 text-gray-700 px-4 py-2 !rounded-button hover:bg-gray-200 transition-colors cursor-pointer flex items-center gap-2">
                                                        <i class="ri-upload-line w-5 h-5 flex items-center justify-center"></i>
                                                        Upload Photo
                                                    </button>
                                                    <p class="text-xs text-gray-500 mt-1">
                                                        Supported formats: JPG, PNG. Max size: 5MB
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                            <%--<i class="ri-check-line w-5 h-5 flex items-center justify-center"></i>--%>
                                        <asp:Button ID="btnEdit" runat="server" Text="Submit" 
                                            class="w-full bg-primary text-white py-3 !rounded-button hover:bg-primary/90 transition-colors cursor-pointer flex items-center justify-center gap-2" OnClick="btnEdit_Click" />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <asp:Label class="text-sm text-gray-500" ID="lblEmail" runat="server" Text="..."></asp:Label>
                        </div>
                        <div>
                            <asp:Label class="text-sm text-gray-500" ID="lblPhone" runat="server"></asp:Label>
                        </div>
                        <div>
                            <asp:Label class="text-sm text-gray-500" ID="lblAddress" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="grid grid-cols-3 gap-4 mt-8 pt-8 border-t">
                        <div class="text-center">
                            <p class="text-2xl font-semibold text-primary">47</p>
                            <p class="text-sm text-gray-500">Orders</p>
                        </div>
                        <div class="text-center">
                            <p class="text-2xl font-semibold text-primary">1250</p>
                            <p class="text-sm text-gray-500">Points</p>
                        </div>
                        <div class="text-center">
                            <p class="text-2xl font-semibold text-primary">0</p>
                            <p class="text-sm text-gray-500">Favorites</p>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-sm p-6">
                    <h2 class="text-lg font-semibold text-gray-900 mb-4">Payment Methods</h2>
                    <div class="space-y-4">
                        <div class="flex items-center justify-between p-4 border rounded-lg">
                            <div class="flex items-center gap-3">
                                <i class="ri-visa-fill text-2xl text-blue-600"></i>
                                <div>
                                    <p class="text-gray-900">•••• 4589</p>
                                    <p class="text-sm text-gray-500">Expires 08/2025</p>
                                </div>
                            </div>
                            <span class="px-2 py-1 text-xs font-medium text-primary bg-primary/10 rounded">Default</span>
                        </div>
                        <div class="flex items-center justify-between p-4 border rounded-lg">
                            <div class="flex items-center gap-3">
                                <i class="ri-mastercard-fill text-2xl text-orange-600"></i>
                                <div>
                                    <p class="text-gray-900">•••• 7852</p>
                                    <p class="text-sm text-gray-500">Expires 11/2024</p>
                                </div>
                            </div>
                        </div>
                        <button class="w-full flex items-center justify-center gap-2 text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                            <i class="ri-add-line"></i>
                            Add New Card
                        </button>
                    </div>
                </div>
            </div>
           
            <div class="col-span-12 lg:col-span-8 space-y-8">

                <div class="bg-white rounded-lg shadow-sm p-6">
                    <a href="trackOrder.aspx" class="inline-block bg-primary text-white font-medium py-2 px-4 rounded hover:bg-primary/90 transition">
                        Track Orders
                    </a>
                    <br /><br />
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Recent Orders</h2>
                        <a href="#" class="text-primary hover:text-primary/90 font-medium">View All</a>
                    </div>
                    <div class="space-y-4">
                        <div class="product-section" id="cartItemsContainer">
                            <!-- Cart items will be loaded here -->
                            <div class="text-gray-500 text-center py-10">
                                Loading your cart...
                            </div>
                        </div>
                    </div>
                </div>

              
                <button class="w-full bg-primary text-white font-medium !rounded-button px-6 py-3 mt-6 hover:bg-primary/90 flex items-center justify-center gap-2">
                    <i class="ri-secure-payment-line"></i>
                    Proceed to Payment
                </button>
            </div>
        </div>
    </main>
    <script>
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

            // Apply coupon if exists
            if (appliedCoupon) {
                applyCoupon(appliedCoupon.code, appliedCoupon.discount);
            }
        }

        const openFormBtn = document.getElementById('openFormBtn');
        const closeFormBtn = document.getElementById('closeFormBtn');
        const formModal = document.getElementById('formModal');

        openFormBtn.addEventListener('click', () => {
            formModal.classList.remove('hidden');
            document.body.style.overflow = 'hidden'; // Prevent scrolling when modal is open
        });

        closeFormBtn.addEventListener('click', () => {
            formModal.classList.add('hidden');
            document.body.style.overflow = ''; // Restore scrolling
        });

        window.addEventListener('click', (event) => {
            if (event.target === formModal) {
                formModal.classList.add('hidden');
                document.body.style.overflow = ''; // Restore scrolling
            }
        });

        document.querySelectorAll('[class*="ri-heart"]').forEach(btn => {
            btn.addEventListener('click', function () {
                this.classList.toggle('ri-heart-line');
                this.classList.toggle('ri-heart-fill');
            });
        });
        document.querySelector('button:contains("Proceed to Payment")').addEventListener('click', function () {
            const selectedPayment = document.querySelector('input[name="payment"]:checked').closest('label').querySelector('.text-gray-900').textContent;
            const total = document.querySelector('.font-semibold.text-gray-900 span:last-child').textContent;
            const paymentModal = document.createElement('div');
            paymentModal.className = 'fixed inset-0 bg-black/50 flex items-center justify-center z-50';
            paymentModal.innerHTML = `
                <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-semibold text-gray-900">Confirm Payment</h3>
                        <button class="text-gray-400 hover:text-gray-600" onclick="this.closest('.fixed').remove()">
                            <i class="ri-close-line text-xl"></i>
                        </button>
                    </div>
                    <p class="text-gray-600 mb-4">You are about to pay ${total} using ${selectedPayment}</p>
                    <div class="flex gap-3">
                        <button class="flex-1 bg-gray-100 text-gray-600 font-medium !rounded-button px-4 py-2 hover:bg-gray-200"
                        onclick="this.closest('.fixed').remove()">Cancel</button>
                        <button class="flex-1 bg-primary text-white font-medium !rounded-button px-4 py-2 hover:bg-primary/90">Confirm</button>
                    </div>
                </div>
            `;
            document.body.appendChild(paymentModal);
        });

        document.querySelectorAll('[class*="ri-heart"]').forEach(btn => {
            btn.addEventListener('click', function () {
                this.classList.toggle('ri-heart-line');
                this.classList.toggle('ri-heart-fill');
            });
        });
    </script>
</body>
</html>
