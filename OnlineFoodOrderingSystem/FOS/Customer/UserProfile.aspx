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
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#FF6B6B',
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
    <header class="fixed top-0 left-0 right-0 bg-white shadow-sm z-50">
        <div class="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <a href="/" class="text-2xl font-['Pacifico'] text-primary">logo</a>
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
    <main class="max-w-7xl mx-auto px-4 pt-24 pb-16">
        <div class="flex items-center gap-2 text-sm text-gray-500 mb-8">
            <a href="/" class="hover:text-primary">Home</a>
            <i class="ri-arrow-right-s-line"></i>
            <span>Profile</span>
        </div>
        <div class="grid grid-cols-12 gap-8">
            <div class="col-span-12 lg:col-span-4">
                <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
                    <div class="flex items-start justify-between mb-6">
                        <div class="flex items-center gap-4">
                            <div class="relative">
                                <img src="https://public.readdy.ai/ai/img_res/59ff7ab7db359e1bfd9003b655e35297.jpg"
                                    class="w-20 h-20 rounded-full object-cover" alt="Profile">
                                <button class="absolute bottom-0 right-0 w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center hover:bg-primary/90">
                                    <i class="ri-pencil-line text-sm"></i>
                                </button>
                            </div>
                            <div>
                                <h1 class="text-xl font-semibold text-gray-900">Michael Anderson</h1>
                                <p class="text-gray-500">Premium Member</p>
                            </div>
                        </div>
                        <button class="text-sm text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                            Edit Profile
       
                        </button>
                    </div>
                    <div class="space-y-4">
                        <div>
                            <label class="text-sm text-gray-500">Email</label>
                            <p class="text-gray-900">michael.anderson@example.com</p>
                        </div>
                        <div>
                            <label class="text-sm text-gray-500">Phone</label>
                            <p class="text-gray-900">+1 (555) 123-4567</p>
                        </div>
                        <div>
                            <label class="text-sm text-gray-500">Delivery Address</label>
                            <p class="text-gray-900">789 Oak Street, Apt 12B<br>
                                San Francisco, CA 94105</p>
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
                            <p class="text-2xl font-semibold text-primary">12</p>
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
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Recent Orders</h2>
                        <a href="#" class="text-primary hover:text-primary/90 font-medium">View All</a>
                    </div>
                    <div class="space-y-4">
                        <div class="flex items-center gap-4 p-4 border rounded-lg hover:border-primary/20 transition-colors">
                            <img src="https://public.readdy.ai/ai/img_res/4f0f7aa4003b43f978432b148718d0e8.jpg"
                                class="w-20 h-20 rounded-lg object-cover" alt="Restaurant">
                            <div class="flex-1">
                                <div class="flex items-start justify-between">
                                    <div>
                                        <h3 class="font-medium text-gray-900">Burger & Lobster</h3>
                                        <p class="text-sm text-gray-500">Order #FH8547 • March 9, 2025</p>
                                    </div>
                                    <span class="px-2 py-1 text-xs font-medium text-green-600 bg-green-50 rounded-full">Delivered</span>
                                </div>
                                <div class="flex items-center justify-between mt-4">
                                    <p class="text-gray-900 font-medium">$42.80</p>
                                    <button class="text-sm text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                                        Reorder
   
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="flex items-center gap-4 p-4 border rounded-lg hover:border-primary/20 transition-colors">
                            <img src="https://public.readdy.ai/ai/img_res/c67c0ed397f5b3810686450d0b942b94.jpg"
                                class="w-20 h-20 rounded-lg object-cover" alt="Restaurant">
                            <div class="flex-1">
                                <div class="flex items-start justify-between">
                                    <div>
                                        <h3 class="font-medium text-gray-900">Pizza Express</h3>
                                        <p class="text-sm text-gray-500">Order #FH8546 • March 8, 2025</p>
                                    </div>
                                    <span class="px-2 py-1 text-xs font-medium text-green-600 bg-green-50 rounded-full">Delivered</span>
                                </div>
                                <div class="flex items-center justify-between mt-4">
                                    <p class="text-gray-900 font-medium">$35.50</p>
                                    <button class="text-sm text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                                        Reorder
       
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="flex items-center gap-4 p-4 border rounded-lg hover:border-primary/20 transition-colors">
                            <img src="https://public.readdy.ai/ai/img_res/92f2f83957533a49a31ba392177fba5d.jpg"
                                class="w-20 h-20 rounded-lg object-cover" alt="Restaurant">
                            <div class="flex-1">
                                <div class="flex items-start justify-between">
                                    <div>
                                        <h3 class="font-medium text-gray-900">Sushi Master</h3>
                                        <p class="text-sm text-gray-500">Order #FH8545 • March 7, 2025</p>
                                    </div>
                                    <span class="px-2 py-1 text-xs font-medium text-green-600 bg-green-50 rounded-full">Delivered</span>
                                </div>
                                <div class="flex items-center justify-between mt-4">
                                    <p class="text-gray-900 font-medium">$58.90</p>
                                    <button class="text-sm text-primary hover:text-primary/90 font-medium !rounded-button px-4 py-2 border border-primary">
                                        Reorder
       
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="bg-white rounded-lg shadow-sm p-6 mt-8">
                    <div class="flex items-center justify-between mb-6">
                        <h2 class="text-lg font-semibold text-gray-900">Order Summary</h2>
                    </div>
                    <div class="space-y-4">
                        <div class="flex justify-between text-gray-600">
                            <span>Subtotal</span>
                            <span>$137.20</span>
                        </div>
                        <div class="flex justify-between text-gray-600">
                            <span>Delivery Fee</span>
                            <span>$5.00</span>
                        </div>
                        <div class="h-px bg-gray-200 my-4"></div>
                        <div class="flex justify-between font-semibold text-gray-900">
                            <span>Total</span>
                            <span>$142.20</span>
                        </div>
                        <div class="mt-6">
                            <h3 class="font-medium text-gray-900 mb-4">Payment Method</h3>
                            <div class="space-y-3">
                                <label class="flex items-center gap-3 p-4 border rounded-lg cursor-pointer hover:border-primary/20 transition-colors">
                                    <input type="radio" name="payment" class="w-4 h-4 text-primary" checked>
                                    <div class="flex-1">
                                        <p class="text-gray-900 font-medium">Online Payment</p>
                                        <p class="text-sm text-gray-500">Pay with saved cards</p>
                                    </div>
                                    <i class="ri-bank-card-line text-xl text-gray-400"></i>
                                </label>
                                <label class="flex items-center gap-3 p-4 border rounded-lg cursor-pointer hover:border-primary/20 transition-colors">
                                    <input type="radio" name="payment" class="w-4 h-4 text-primary">
                                    <div class="flex-1">
                                        <p class="text-gray-900 font-medium">Cash on Delivery</p>
                                        <p class="text-sm text-gray-500">Pay when your order arrives</p>
                                    </div>
                                    <i class="ri-money-dollar-box-line text-xl text-gray-400"></i>
                                </label>
                            </div>
                            <button class="w-full bg-primary text-white font-medium !rounded-button px-6 py-3 mt-6 hover:bg-primary/90 flex items-center justify-center gap-2">
                                <i class="ri-secure-payment-line"></i>
                                Proceed to Payment

                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>
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
    </script>
    <script>
        document.querySelectorAll('[class*="ri-heart"]').forEach(btn => {
            btn.addEventListener('click', function () {
                this.classList.toggle('ri-heart-line');
                this.classList.toggle('ri-heart-fill');
            });
        });
</script>
</body>
</html>
