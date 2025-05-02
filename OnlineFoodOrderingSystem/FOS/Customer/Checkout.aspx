<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Checkout" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Payment</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FEA116",
                        secondary: "#64748b",
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

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .card-input::-webkit-input-placeholder {
            letter-spacing: 4px;
        }
    </style>
</head>

<body class="bg-gray-50 min-h-screen">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:HiddenField ID="hfSubtotal" runat="server" />
        <asp:HiddenField ID="hfTax" runat="server" />
        <asp:HiddenField ID="hfDeliveryFee" runat="server" />
        <asp:HiddenField ID="hfTotal" runat="server" />
        <div class="max-w-3xl mx-auto p-6 min-h-screen">
            <div class="mb-8 text-center">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Payment Details</h1>
                <p class="text-gray-600">Complete your payment securely</p>
            </div>
            <div class="bg-white rounded-lg shadow-sm p-8 mb-8">
                <div class="flex items-center justify-between mb-6">
                    <h2 class="text-xl font-semibold">Amount to Pay</h2>
                        <span class="text-2xl font-bold text-primary" id="amountToPay" runat="server">₹0.00</span>
                </div>
                <div class="mb-8">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Payment Method</h3>
                    <div class="space-y-3">
                        <label
                            class="flex items-center p-4 border rounded-lg cursor-pointer hover:border-primary transition-colors">
                            <input type="radio" name="payment" value="card" class="h-5 w-5 text-primary" checked />
                            <div class="ml-3 flex items-center">
                                <i class="ri-bank-card-line text-xl mr-2"></i>
                                <span class="font-medium">Credit/Debit Card</span>
                            </div>
                        </label>
                        <label
                            class="flex items-center p-4 border rounded-lg cursor-pointer hover:border-primary transition-colors">
                            <input type="radio" name="payment" value="gpay" class="h-5 w-5 text-primary" />
                            <div class="ml-3 flex items-center">
                                <i class="ri-google-fill text-xl mr-2"></i>
                                <span class="font-medium">Google Pay</span>
                            </div>
                        </label>
                        <div id="gpayDetails" class="mt-4 space-y-4" style="display: none;">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Google Pay ID</label>
                                <input type="text"
                                    class="w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                    placeholder="Enter your Google Pay ID" />
                            </div>
                            <div class="flex justify-center">
                                <div class="bg-gray-100 p-4 rounded-lg w-48 h-48 flex items-center justify-center">
                                    <img src="../../Asset/Library/img/PaymentCode.png"
                                        alt="Google Pay QR Code" class="w-full h-full object-contain" />
                                </div>
                            </div>
                        </div>
                        <label
                            class="flex items-center p-4 border rounded-lg cursor-pointer hover:border-primary transition-colors">
                            <input type="radio" name="payment" value="apple" class="h-5 w-5 text-primary" />
                            <div class="ml-3 flex items-center">
                                <i class="ri-apple-fill text-xl mr-2"></i>
                                <span class="font-medium">Apple Pay</span>
                            </div>
                        </label>
                        <div id="applePayDetails" class="mt-4 space-y-4" style="display: none;">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Apple ID</label>
                                <input type="text"
                                    class="w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                    placeholder="Enter your Apple ID" />
                            </div>
                            <div class="flex justify-center">
                                <div class="bg-gray-100 p-4 rounded-lg w-48 h-48 flex items-center justify-center">
                                    <img src="https://public.readdy.ai/ai/img_res/41fb308fd6eb90a39131a507f8a95cc8.jpg"
                                        alt="Apple Pay QR Code" class="w-full h-full object-contain" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="cardDetails" class="space-y-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Cardholder Name</label>
                        <div class="relative">
                            <input type="text"
                                class="w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                placeholder="Name on card" id="cardholderName" />
                            <span id="nameValidation"
                                class="absolute right-4 top-1/2 transform -translate-y-1/2 hidden text-xl"></span>
                        </div>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                        <div class="relative">
                            <input type="text"
                                class="card-input w-full pl-4 pr-12 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                placeholder="•••• •••• •••• ••••" maxlength="19" id="cardNumber" />
                            <span id="numberValidation"
                                class="absolute right-4 top-1/2 transform -translate-y-1/2 hidden text-xl"></span>
                            <div class="absolute right-4 top-1/2 transform -translate-y-1/2">
                                <i class="ri-bank-card-line text-gray-400"></i>
                            </div>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                            <div class="relative">
                                <input type="text"
                                    class="w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                    placeholder="MM/YY" maxlength="5" id="expiryDate" />
                                <span id="expiryValidation" r
                                    class="absolute right-4 top-1/2 tansform -translate-y-1/2 hidden text-xl"></span>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                            <div class="relative">
                                <input type="text"
                                    class="w-full pl-4 pr-12 py-3 border rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-gray-900"
                                    placeholder="•••" maxlength="3" id="cvv" />
                                <span id="cvvValidation"
                                    class="absolute right-4 top-1/2 transform -translate-y-1/2 hidden text-xl"></span>
                                <div class="absolute right-4 top-1/2 transform -translate-y-1/2">
                                    <i class="ri-question-line text-gray-400 cursor-help" id="cvvHelp"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow-sm p-8 mb-8">
                <h3 class="text-lg font-medium text-gray-900 mb-4">Payment Summary</h3>
                <div class="space-y-3">
                    <div class="flex justify-between text-gray-600">
                        <span>Subtotal</span>
                        <span id="lblSubtotal" runat="server">₹0.00</span>
                    </div>
                    <div class="flex justify-between text-gray-600">
                        <span>Delivery charge</span>
                        <span id="lblDelivery" runat="server">₹20.00</span>
                    </div>
                    <div class="flex justify-between text-gray-600">
                        <span>Tax (5%)</span>
                        <span id="lblTax" runat="server">₹0.00</span>
                    </div>
                    <div class="border-t pt-3 flex justify-between font-medium text-gray-900">
                        <span>Total</span>
                        <span id="lblTotal" runat="server">₹0.00</span>
                    </div>
                </div>
            </div>
            <div class="flex flex-col space-y-4"> 
                <asp:Button ID="btnPay" runat="server"
                    Text="Pay Now"
                    CssClass="bg-primary text-white py-3 px-6 rounded-lg hover:bg-yellow-400 transition-colors font-semibold"
                    OnClick="btnPay_Click" />
                <button
                    class="w-full bg-gray-100 text-gray-700 font-medium py-4 px-6 rounded-button hover:bg-gray-200 transition-colors cursor-pointer">
                    Cancel
                </button>
            </div>
        </div>
    </form>
    <div id="cvvTooltip" class="hidden fixed bg-white p-4 rounded-lg shadow-lg max-w-xs text-sm text-gray-600 border">
        The CVV is the 3-digit security code on the back of your card
    </div>
    <div id="successModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
        <div class="bg-white rounded-lg p-8 max-w-md w-full mx-4">
            <div class="text-center">
                <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                    <i class="ri-check-line text-3xl text-green-500"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-2">Payment Successful!
                </h3>
                <p class="text-gray-600 mb-6">
                    Your payment has been processed successfully.
                </p>
                <button onclick="closeSuccessModal()"
                    class="w-full bg-primary text-white font-medium py-3 px-6 rounded-button hover:bg-primary/90 transition-colors cursor-pointer">
                    Done
                </button>
            </div>
        </div>
    </div>
    <script>

        // Validation function for displayed icons
        function updateValidation(input, validationSpan, regex) {
            if (regex.test(input.value)) {
                validationSpan.innerHTML = "&#10003;";
                validationSpan.style.color = "green";
                validationSpan.classList.remove("hidden");
            } else {
                validationSpan.innerHTML = "&#10005;";
                validationSpan.style.color = "red";
                validationSpan.classList.remove("hidden");
            }
        }

        document.getElementById('cardholderName').addEventListener('input', function () {
            updateValidation(this, document.getElementById('nameValidation'), /^(?=(?:.*\s.*)[^]*$).{10,40}$/);
            // Minimum 15 characters, maximum 50 characters, and must contain at least 1 or 2 spaces
        });

        // Call this function on input change for card number
        document.getElementById('cardNumber').addEventListener('input', function () {
            updateValidation(this, document.getElementById('numberValidation'), /^\d{4}\s\d{4}\s\d{4}\s\d{4}$/);
            // Valid card format
        });

        // Call this function on input change for expiry date
        document.getElementById('expiryDate').addEventListener('input', function () {
            updateValidation(this, document.getElementById('expiryValidation'), /^(0[1-9]|1[0-2])\/[0-9]{2}$/);
            // MM/YY format
        });

        // Call this function on input change for CVV
        document.getElementById('cvv').addEventListener('input', function () {
            updateValidation(this, document.getElementById('cvvValidation'), /^[0-9]{3}$/);
            // 3-digit CVV
        });


        const cardInput = document.querySelector(".card-input");
        cardInput.addEventListener("input", (e) => {
            let value = e.target.value.replace(/\D/g, "");
            value = value.replace(/(.{4})/g, "$1 ").trim();
            e.target.value = value;
        });
        const expiryInput = document.querySelector('input[placeholder="MM/YY"]');
        expiryInput.addEventListener("input", (e) => {
            let value = e.target.value.replace(/\D/g, "");
            if (value.length >= 2) {
                value = value.slice(0, 2) + "/" + value.slice(2, 4);
            }
            e.target.value = value;
        });
        const cvvHelp = document.getElementById("cvvHelp");
        const cvvTooltip = document.getElementById("cvvTooltip");
        cvvHelp.addEventListener("mouseenter", (e) => {
            cvvTooltip.style.display = "block";
            cvvTooltip.style.left = e.pageX + "px";
            cvvTooltip.style.top = e.pageY - 40 + "px";
        });
        cvvHelp.addEventListener("mouseleave", () => {
            cvvTooltip.style.display = "none";
        });

        <%--const payButton = document.getElementById('<%= btnPay.ClientID %>');
        const successModal = document.getElementById("successModal");

        payButton.addEventListener("click", function (e) {
            e.preventDefault(); // Stop default refresh
            payButton.disabled = true;
            payButton.innerHTML = '<i class="ri-loader-4-line animate-spin mr-2"></i> Processing...';

            setTimeout(function () {
                // Correct ASP.NET way to trigger server-side click
                __doPostBack('<%= btnPay.UniqueID %>', '');
            }, 2000);
        });

        function closeSuccessModal() {
            successModal.style.display = "none";
        }--%>

        document.querySelectorAll('input[name="payment"]').forEach(function (el) {
            el.addEventListener('change', function () {
                document.getElementById('gpayDetails').style.display = this.value === 'gpay' ? 'block' : 'none';
                document.getElementById('applePayDetails').style.display = this.value === 'apple' ? 'block' : 'none';
                document.getElementById('cardDetails').style.display = this.value === 'card' ? 'block' : 'none';
            });
        });

    </script>
</body>

</html>
