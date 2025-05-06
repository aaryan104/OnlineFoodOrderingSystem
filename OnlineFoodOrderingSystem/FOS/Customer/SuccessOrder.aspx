<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SuccessOrder.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.SuccessOrder" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Success</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#FFC107" },
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
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background-color: #FAFAFA;
        }

        .checkmark {
            stroke-dasharray: 180;
            stroke-dashoffset: 180;
            animation: draw 1s ease-in-out forwards;
            animation-delay: 0.5s;
        }

        @keyframes draw {
            to {
                stroke-dashoffset: 0;
            }
        }

        .circle {
            opacity: 0;
            transform: scale(0.8);
            animation: scale 0.3s ease-in-out forwards;
        }

        @keyframes scale {
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .food-truck {
            animation: drive 8s linear infinite;
            transform: translateX(-150%);
        }

        @keyframes drive {
            0% {
                transform: translateX(-150%);
            }

            100% {
                transform: translateX(150%);
            }
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            opacity: 0;
        }

        .success-message {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeUp 0.8s ease-out forwards;
            animation-delay: 1.2s;
        }

        .order-details {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeUp 0.8s ease-out forwards;
            animation-delay: 1.6s;
        }

        .countdown {
            opacity: 0;
            animation: fadeIn 0.8s ease-out forwards;
            animation-delay: 2s;
        }

        @keyframes fadeUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }

        .pulse {
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.05);
            }

            100% {
                transform: scale(1);
            }
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>

<body>
    <div class="min-h-screen flex flex-col items-center justify-center px-4 py-12 relative overflow-hidden">
        <!-- Confetti elements -->
        <div id="confetti-container" class="absolute inset-0 pointer-events-none"></div>

        <!-- Food truck animation container -->
        <div class="w-full h-32 relative mb-8 overflow-hidden">
            <div class="food-truck absolute">
                <svg width="120" height="80" viewBox="0 0 120 80" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <!-- Truck body -->
                    <rect x="20" y="15" width="80" height="40" rx="5" fill="#FEA116" />
                    <!-- Truck cabin -->
                    <rect x="10" y="25" width="30" height="30" rx="3" fill="#FFFFFF" />
                    <!-- Windows -->
                    <rect x="15" y="30" width="20" height="15" rx="2" fill="#87CEEB" />
                    <!-- Wheels -->
                    <circle cx="25" cy="60" r="8" fill="#333333" />
                    <circle cx="25" cy="60" r="3" fill="#666666" />
                    <circle cx="85" cy="60" r="8" fill="#333333" />
                    <circle cx="85" cy="60" r="3" fill="#666666" />
                    <!-- Food service window -->
                    <rect x="60" y="20" width="25" height="20" rx="2" fill="#FFFFFF" />
                    <!-- Awning -->
                    <path d="M60 20L85 20L85 15C85 15 72.5 10 60 15L60 20Z" fill="#FFC107" />
                    <!-- Food icon -->
                    <circle cx="72.5" cy="30" r="5" fill="#FFC107" />
                    <!-- Steam -->
                    <path d="M75 20C75 20 78 15 75 10" stroke="#FFFFFF" stroke-width="1.5" stroke-linecap="round" />
                    <path d="M70 20C70 20 67 15 70 10" stroke="#FFFFFF" stroke-width="1.5" stroke-linecap="round" />
                </svg>
            </div>
        </div>

        <!-- Success checkmark -->
        <div class="relative w-32 h-32 mb-8">
            <svg class="w-full h-full" viewBox="0 0 100 100">
                <circle class="circle" cx="50" cy="50" r="48" fill="white" stroke="#FEA116" stroke-width="4" />
                <path class="checkmark" d="M30 50L45 65L70 35" fill="none" stroke="#FEA116" stroke-width="6"
                    stroke-linecap="round" stroke-linejoin="round" />
            </svg>
        </div>

        <!-- Success message -->
        <div class="success-message text-center mb-8">
            <h1 class="text-3xl md:text-4xl font-bold text-gray-800 mb-2">
                Order Placed Successfully!
            </h1>
            <p class="text-lg text-gray-600">
                Thank you for your order. Your food is being prepared.
            </p>
        </div>

        <!-- Order details -->
        <div class="order-details bg-white rounded-lg shadow-md p-6 mb-8 w-full max-w-md">
            <div class="flex justify-between items-center mb-4">
                <span class="text-gray-600">Order #:</span>
                <span class="font-mono font-semibold text-gray-800">
                    <asp:Label ID="lblOrderid" runat="server" Text=""></asp:Label>
                </span>
            </div>

            <div class="flex justify-between items-center mb-4">
                <span class="text-gray-600">Date:</span>
                <span class="text-gray-800">
                    <asp:Label ID="lblDate" runat="server" Text=""></asp:Label>
                </span>
            </div>

            <div class="flex justify-between items-center mb-4">
                <span class="text-gray-600">Estimated Delivery:</span>
                <span class="text-gray-800">
                    <asp:Label ID="lblEstimate" runat="server" Text=""></asp:Label>
                </span>
            </div>

            <div class="flex justify-between items-center mb-4">
                <span class="text-gray-600">Total Amount:</span>
                <span class="font-semibold text-gray-800">
                    <asp:Label ID="lblAmount" runat="server" Text=""></asp:Label>
                </span>
            </div>

            <div class="pt-4 border-t border-gray-200">
                <div class="flex items-center">
                    <div class="w-8 h-8 flex items-center justify-center bg-primary/10 rounded-full mr-3">
                        <i class="ri-mail-line text-primary"></i>
                    </div>
                    <span class="text-gray-600 text-sm">A confirmation email has been sent to your email address.</span>
                </div>
            </div>
        </div>

        <!-- Countdown timer -->
        <div class="countdown text-center">
            <p class="text-gray-600 mb-2">Redirecting to order tracking page in</p>
            <div class="bg-gray-100 rounded-full px-6 py-2 inline-block">
                <span id="countdown" class="text-xl font-semibold text-primary">10</span>
                <span class="text-gray-600">seconds</span>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let seconds = 10;
            const countdownElement = document.getElementById("countdown");

            const countdownInterval = setInterval(() => {
                seconds--;
                countdownElement.textContent = seconds;

                if (seconds <= 0) {
                    clearInterval(countdownInterval);
                    window.location.href = 'trackOrder.aspx';
                }
            }, 1000);

            // Create confetti
            const confettiContainer = document.getElementById("confetti-container");
            const colors = ["#FEA116", "#FFC107", "#FFD54F", "#FFECB3"];

            for (let i = 0; i < 100; i++) {
                createConfetti(confettiContainer, colors);
            }
        });

        function createConfetti(container, colors) {
            const confetti = document.createElement("div");
            confetti.classList.add("confetti");

            const size = Math.random() * 10 + 5;
            const color = colors[Math.floor(Math.random() * colors.length)];

            confetti.style.width = `${size}px`;
            confetti.style.height = `${size}px`;
            confetti.style.backgroundColor = color;
            confetti.style.borderRadius = Math.random() > 0.5 ? "50%" : "0";
            confetti.style.left = `${Math.random() * 100}%`;
            confetti.style.top = `${Math.random() * 50}%`;

            container.appendChild(confetti);

            // Animate confetti
            const duration = Math.random() * 3 + 2;
            const delay = Math.random() * 2;

            confetti.style.animation = `
                      fadeIn 0.3s ease-out ${delay}s forwards,
                      fall ${duration}s ease-in ${delay}s forwards
                  `;

            // Add keyframes for confetti animation
            const style = document.createElement("style");
            style.textContent = `
                      @keyframes fall {
                          to {
                              transform: translateY(100vh) rotate(${Math.random() * 360}deg);
                          }
                      }
                  `;
            document.head.appendChild(style);

            // Remove confetti after animation
            setTimeout(
                () => {
                    confetti.remove();
                    style.remove();
                },
                (duration + delay) * 100,
            );
        }
    </script>
</body>

</html>
