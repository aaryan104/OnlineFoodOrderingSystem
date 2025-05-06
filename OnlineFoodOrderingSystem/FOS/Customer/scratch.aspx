<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="scratch.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.scratch" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scratch & Win</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet">
    <style>
        canvas { touch-action: none; }
        .scratch-container {
            position: relative;
            width: 320px;
            height: 200px;
            margin: 0 auto;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(255, 165, 0, 0.2);
        }
        #scratchCanvas {
            position: absolute;
            top: 0;
            left: 0;
            cursor: pointer;
            z-index: 10;
        }
        .btn {
            background: linear-gradient(135deg, #FFA116 0%, #FF8C00 100%);
            border-radius: 12px;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(255, 161, 22, 0.3);
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 161, 22, 0.4);
        }
        .btn-secondary {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: #64748b;
        }
        .btn-secondary:hover {
            background: linear-gradient(135deg, #e2e8f0 0%, #cbd5e1 100%);
        }
        #img {
            height: 100px;
            display: block;
            margin-right: auto;
            margin-left: auto;
        }
        .scratch-surface {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            position: relative;
        }
        .scratch-pattern {
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255,255,255,0.8) 2px, transparent 3px),
                radial-gradient(circle at 75% 75%, rgba(255,255,255,0.8) 2px, transparent 3px);
            background-size: 20px 20px;
        }
        .prize-card {
            background: linear-gradient(135deg, #fff9f0 0%, #ffe8cc 100%);
            border: 2px dashed #FFA116;
            border-radius: 14px;
        }
        .no-prize-card {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border: 2px dashed #94a3b8;
            border-radius: 14px;
        }
        .shine-effect {
            position: relative;
            overflow: hidden;
        }
        .shine-effect:after {
            content: '';
            position: absolute;
            top: -50%;
            left: -60%;
            width: 40%;
            height: 200%;
            background: rgba(255,255,255,0.2);
            transform: rotate(30deg);
            animation: shine 3s infinite;
        }
        @keyframes shine {
            0% { left: -60%; }
            20% { left: 120%; }
            100% { left: 120%; }
        }
        .confetti {
            position: absolute;
            width: 8px;
            background-color: #FFD700;
            border-radius: 50%;
            animation: fall 2s linear forwards;
        }
        @keyframes fall {
            to {
                transform: translateY(200px) rotate(360deg);
                opacity: 0;
            }
        }
        .timer-pulse {
            animation: pulse 1s infinite alternate;
        }
        @keyframes pulse {
            from { transform: scale(1); }
            to { transform: scale(1.05); }
        }
        .animate-fadeIn {
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .hidden {
            display: none !important;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-['Poppins']">
    <div class="max-w-4xl mx-auto p-6">
        <header class="text-center mb-10">
            <h2 class="text-3xl font-bold mb-3 text-orange-600">Scratch & Win</h2>
            <img ID="img" src="../../Asset/Library/img/scratch-card-image.jpg" />
            <p class="text-gray-600 mt-4 text-lg">Scratch the card to reveal your surprise!</p>
        </header>

        <div class="bg-white rounded-2xl shadow-xl p-8 max-w-lg mx-auto">
            <div class="mb-8">
                <div class="flex items-center justify-center gap-3 mb-6 bg-orange-50 py-2 px-4 rounded-full w-max mx-auto">
                    <div class="w-8 h-8 flex items-center justify-center bg-orange-100 rounded-full timer-pulse">
                        <i class="ri-time-line text-orange-500"></i>
                    </div>
                    <span class="text-gray-700 font-medium" id="timer">05:00</span>
                </div>
                
                <div class="scratch-container shine-effect" id="scratchCard">
                    <div class="absolute inset-0 flex flex-col items-center justify-center prize-card p-6 hidden" id="couponReveal">
                        <span class="text-sm text-gray-500 mb-1">Congratulations !</span>
                        <span class="text-4xl font-bold text-orange-600 tracking-wider mb-2" id="couponCode"></span>
                        <br /><br />
                        <span class="text-xl font-['Pacifico'] text-orange-500">You Won! </span>
                        <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-orange-500 text-white px-4 py-2 rounded-full text-xl font-bold">
                            <span id="discountValue">10% OFF</span>
                        </div>
                    </div>
                    <div class="absolute inset-0 flex flex-col items-center justify-center no-prize-card p-6 hidden" id="noPrizeReveal">
                        <i class="ri-emotion-sad-line text-4xl text-gray-400 mb-2"></i>
                        <span class="text-xl font-bold text-gray-600 mb-1">Better Luck Next Time!</span>
                        <span class="text-sm text-gray-500">Keep trying for exciting offers</span>
                    </div>
                    <canvas id="scratchCanvas" width="320" height="200"></canvas>
                    <div class="absolute bottom-4 left-0 right-0 text-center">
                        <div class="inline-flex items-center bg-white/80 px-3 py-1 rounded-full text-xs text-gray-600">
                            <i class="ri-hand-finger-line mr-1"></i> Scratch here
                        </div>
                    </div>
                </div>

                <div class="mt-6 flex justify-center">
                    <button id="revealAll" class="text-sm text-gray-500 hover:text-orange-500 cursor-pointer flex items-center gap-1 px-3 py-1 bg-gray-100 rounded-full">
                        <i class="ri-magic-line"></i> Instant Reveal
                    </button>
                </div>
            </div>

            <div id="resultSection" class="hidden mt-8 animate-fadeIn">
                <div class="rounded-xl p-6 mb-6 border" id="resultContent">
                    <!-- Content will be filled dynamically -->
                </div>

                <div class="text-center">
                    <button class="btn text-white px-10 py-4 text-lg font-semibold flex items-center justify-center gap-2 mx-auto" id="redeemButton">
                        <i class="ri-gift-fill"></i> Claim Your Reward
                    </button>
                    <p class="text-gray-500 text-sm mt-3">Offer expires in <span id="remainingTime" class="font-medium">5:00</span></p>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const canvas = document.getElementById('scratchCanvas');
            const ctx = canvas.getContext('2d');
            let isDrawing = false;
            let scratchedPixels = 0;
            const totalPixels = canvas.width * canvas.height;
            let selectedCoupon = '';
            let discountPercentage = 0;
            let couponRevealed = false;

            // Track total plays and wins
            let totalScratches = parseInt(localStorage.getItem('scratchCount') || '0');
            let totalWins = parseInt(localStorage.getItem('winCount') || '0');
            let sessionAttempts = parseInt(localStorage.getItem('sessionAttempts') || '0');

            // Initialize the game
            initGame();

            function initGame() {
                couponRevealed = false;

                const result = generateGameResult();
                const hasWon = result.hasWon;

                if (hasWon) {
                    selectedCoupon = generateRandomCoupon();
                    discountPercentage = result.discount;
                    document.getElementById('couponCode').textContent = selectedCoupon;
                    document.getElementById('discountValue').textContent = discountPercentage + '% OFF';
                    document.getElementById('couponReveal').classList.remove('hidden');
                    document.getElementById('noPrizeReveal').classList.add('hidden');
                } else {
                    document.getElementById('couponReveal').classList.add('hidden');
                    document.getElementById('noPrizeReveal').classList.remove('hidden');
                }

                document.getElementById('resultSection').classList.add('hidden');
                canvas.style.pointerEvents = 'auto';

                initScratchSurface();
            }

            function generateGameResult() {
                totalScratches++;
                sessionAttempts++;
                localStorage.setItem('scratchCount', totalScratches);
                localStorage.setItem('sessionAttempts', sessionAttempts);

                // Ensure at least some wins in 10 attempts
                if (sessionAttempts % 10 === 0 && totalWins < 2) {
                    sessionAttempts = 0;
                    localStorage.setItem('sessionAttempts', '0');
                    return { hasWon: true, discount: getRandomWeightedDiscount() };
                }

                // New probability distribution
                const random = Math.random() * 100;
                let hasWon = false;
                let discount = 0;

                if (random < 55) { // 55% chance for 0% discount
                    hasWon = false;
                    discount = 0;
                } else if (random < 75) { // 20% chance for 5% discount (55-75)
                    hasWon = true;
                    discount = 5;
                } else if (random < 90) { // 15% chance for 10% discount (75-90)
                    hasWon = true;
                    discount = 10;
                } else { // 10% chance for 15% discount (90-100)
                    hasWon = true;
                    discount = 15;
                }

                if (hasWon && discount > 0) {
                    totalWins++;
                    localStorage.setItem('winCount', totalWins);
                }

                return { hasWon, discount };
            }

            function getRandomWeightedDiscount() {
                const rand = Math.random() * 100;
                if (rand < 55) return 0;
                if (rand < 75) return 5;
                if (rand < 90) return 10;
                return 15;
            }

            function getRandomDiscount() {
                const discounts = [5, 10, 15];
                return discounts[Math.floor(Math.random() * discounts.length)];
            }

            function generateRandomCoupon() {
                const characters = 'ABCDNOPQRSTUVWXYZ01234578';
                let coupon = '';
                for (let i = 0; i < 8; i++) {
                    if (i > 0 && i % 5 === 0) coupon += '-';
                    coupon += characters[Math.floor(Math.random() * characters.length)];
                }
                return coupon;
            }

            function initScratchSurface() {
                // Clear canvas
                ctx.clearRect(0, 0, canvas.width, canvas.height);

                // Draw scratchable surface
                const gradient = ctx.createLinearGradient(0, 0, canvas.width, canvas.height);
                gradient.addColorStop(0, "#FFD700");
                gradient.addColorStop(0.5, "#FFA500");
                gradient.addColorStop(1, "#FFD700");
                ctx.fillStyle = gradient;
                ctx.fillRect(0, 0, canvas.width, canvas.height);

                // Add some sparkles
                ctx.fillStyle = "rgba(255, 255, 255, 0.7)";
                for (let i = 0; i < 50; i++) {
                    const size = 1 + Math.random() * 3;
                    const x = Math.random() * canvas.width;
                    const y = Math.random() * canvas.height;
                    ctx.beginPath();
                    ctx.arc(x, y, size, 0, Math.PI * 2);
                    ctx.fill();
                }

                // Add text
                ctx.font = "bold 18px 'Poppins'";
                ctx.fillStyle = "rgba(0, 0, 0, 0.3)";
                ctx.textAlign = "center";
                ctx.fillText("SCRATCH TO REVEAL", canvas.width / 2, canvas.height / 2 - 10);
                ctx.font = "14px 'Poppins'";
                ctx.fillText("Uncover your surprise!", canvas.width / 2, canvas.height / 2 + 15);
            }

            function scratch(e) {
                if (!isDrawing || couponRevealed) return;

                // Get position
                let x, y;
                if (e.type.includes('touch')) {
                    const touch = e.touches[0] || e.changedTouches[0];
                    const rect = canvas.getBoundingClientRect();
                    x = touch.clientX - rect.left;
                    y = touch.clientY - rect.top;
                } else {
                    const rect = canvas.getBoundingClientRect();
                    x = e.clientX - rect.left;
                    y = e.clientY - rect.top;
                }

                // Draw scratch effect
                ctx.globalCompositeOperation = 'destination-out';
                ctx.beginPath();
                const size = 15 + Math.random() * 10;
                ctx.arc(x, y, size, 0, Math.PI * 2);
                for (let i = 0; i < 5; i++) {
                    const offsetX = (Math.random() - 0.5) * 15;
                    const offsetY = (Math.random() - 0.5) * 15;
                    ctx.lineTo(x + offsetX, y + offsetY);
                }
                ctx.fill();

                calculateProgress();
            }

            function calculateProgress() {
                const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
                scratchedPixels = 0;
                for (let i = 3; i < imageData.data.length; i += 4) {
                    if (imageData.data[i] === 0) scratchedPixels++;
                }

                if ((scratchedPixels / totalPixels) > 0.35 && !couponRevealed) {
                    revealResult();
                }
            }

            function revealResult() {
                if (couponRevealed) return;
                couponRevealed = true;
                document.getElementById('resultSection').classList.remove('hidden');
                canvas.style.pointerEvents = 'none';

                const resultContent = document.getElementById('resultContent');

                if (discountPercentage > 0) {
                    resultContent.className = 'bg-gradient-to-br from-orange-50 to-amber-50 rounded-xl p-6 mb-6 border border-orange-100';
                    resultContent.innerHTML = `
                        <div class="flex flex-col items-center text-center">
                            <span class="text-sm text-gray-600 mb-1">Congratulations!</span>
                            <span class="text-4xl font-bold text-orange-600 tracking-wider mb-3">${selectedCoupon}</span>
                            <span class="text-xl font-['Pacifico'] text-orange-500 mb-4">You got <span class="font-bold">${discountPercentage}%</span> discount!</span>
                            <button class="btn text-white px-8 py-3 flex items-center gap-2 font-semibold" id="copyButton">
                                <i class="ri-file-copy-line"></i> Copy Code
                            </button>
                        </div>
                    `;

                    // Create confetti effect
                    for (let i = 0; i < 30; i++) {
                        setTimeout(() => createConfetti(), i * 100);
                    }

                    // Copy button functionality
                    document.getElementById('copyButton').addEventListener('click', () => {
                        navigator.clipboard.writeText(selectedCoupon);
                        const button = document.getElementById('copyButton');
                        button.innerHTML = '<i class="ri-check-line"></i> Copied!';
                        setTimeout(() => {
                            button.innerHTML = '<i class="ri-file-copy-line"></i> Copy Code';
                        }, 2000);
                    });
                } else {
                    resultContent.className = 'bg-gradient-to-br from-gray-50 to-slate-100 rounded-xl p-6 mb-6 border border-gray-200';
                    resultContent.innerHTML = `
                        <div class="flex flex-col items-center text-center">
                            <i class="ri-emotion-sad-line text-5xl text-gray-400 mb-4"></i>
                            <span class="text-2xl font-bold text-gray-600 mb-2">Better Luck Next Time!</span>
                            <p class="text-gray-500 max-w-xs">Don't worry, come back again for another chance.</p>
                        </div>
                    `;
                }
            }

            function createConfetti() {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.backgroundColor = `hsl(${Math.random() * 60 + 20}, 100%, 50%)`;
                confetti.style.width = (Math.random() * 10 + 5) + 'px';
                confetti.style.height = (Math.random() * 5 + 3) + 'px';
                confetti.style.borderRadius = '2px';
                confetti.style.top = '-10px';
                document.getElementById('scratchCard').appendChild(confetti);

                setTimeout(() => confetti.remove(), 2000);
            }

            // Event listeners for mouse
            canvas.addEventListener('mousedown', () => isDrawing = true);
            canvas.addEventListener('mousemove', scratch);
            canvas.addEventListener('mouseup', () => isDrawing = false);
            canvas.addEventListener('mouseleave', () => isDrawing = false);

            // Event listeners for touch
            canvas.addEventListener('touchstart', (e) => {
                e.preventDefault();
                isDrawing = true;
                scratch(e.touches[0]);
            });
            canvas.addEventListener('touchmove', (e) => {
                e.preventDefault();
                scratch(e.touches[0]);
            });
            canvas.addEventListener('touchend', () => isDrawing = false);

            // Instant reveal button
            document.getElementById('revealAll').addEventListener('click', () => {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                revealResult();
            });

            // Redeem button - always visible after reveal
            document.getElementById('redeemButton').addEventListener('click', () => {
                if (discountPercentage > 0) {
                    const redeemUrl = `Cart.aspx?code=${encodeURIComponent(selectedCoupon)}&discount=${discountPercentage}`;
                window.location.href = redeemUrl;
            } else {
                window.location.href = "Cart.aspx";
            }
            });

        // Timer functionality
        let timeLeft = 300; // 5 minutes in seconds
        const timerElement = document.getElementById('timer');
        const remainingTimeElement = document.getElementById('remainingTime');

        const updateTimerDisplay = () => {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            const timeString = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`;
        timerElement.textContent = timeString;
        remainingTimeElement.textContent = timeString;
            };

        updateTimerDisplay();

        const timer = setInterval(() => {
            timeLeft--;
            updateTimerDisplay();
            if (timeLeft <= 0) {
                clearInterval(timer);
                revealResult();
            }
            if (timeLeft <= 60) {
                timerElement.classList.add('text-red-500', 'animate-pulse');
                remainingTimeElement.classList.add('text-red-500');
            }
        }, 1000);
        });
    </script>
</body>
</html>