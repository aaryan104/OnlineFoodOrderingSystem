<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.Transaction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Transaction Management</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#4B5563" },
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            text-align: center;
            white-space: nowrap;
        }

        .payment-method-pending {
            background-color: #FEF3C7;
            color: #92400E;
        }

        .payment-method-failed {
            background-color: #FEE2E2;
            color: #B91C1C;
        }

        .payment-method-successful {
            background-color: #D1FAE5;
            color: #065F46;
        }

        .payment-status-cod {
            background-color: #E5E7EB;
            color: #374151;
        }

        .payment-status-paypal {
            background-color: #DBEAFE;
            color: #1E40AF;
        }

        .payment-status-debit {
            background-color: #D1FAE5;
            color: #065F46;
        }

        .payment-status-credit {
            background-color: #EDE9FE;
            color: #5B21B6;
        }

        .custom-date-input::-webkit-calendar-picker-indicator {
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="16" height="15" viewBox="0 0 24 24"><path fill="%23FEA116" d="M20 3h-1V1h-2v2H7V1H5v2H4c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 18H4V8h16v13z"/></svg>');
            cursor: pointer;
        }

        /* Custom Switch */
        .switch-wrapper {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 20px;
        }

        .switch-wrapper input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .switch-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 20px;
        }

        .switch-slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 2px;
            bottom: 2px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked+.switch-slider {
            background-color: #FEA116;
        }

        input:checked+.switch-slider:before {
            transform: translateX(20px);
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <body class="bg-gray-50 min-h-screen">
        <div class="flex h-screen overflow-hidden">
            <div class="flex flex-col flex-1 w-0 overflow-hidden">
                <main class="flex-1 overflow-y-auto bg-gray-50 p-6">
                    <div class="max-w-7xl mx-auto">
                        <div class="mb-6">
                            <h1 class="text-2xl font-bold text-gray-900">
                                Transaction Management
                            </h1>
                            <div class="h-1 w-24 bg-primary mt-2 rounded-full"></div>
                        </div>
                        <!-- Filters Section -->
                        <div class="bg-white p-5 rounded-lg shadow-sm mb-6">
                            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                <!-- Search -->
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                        <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                            <i class="ri-search-line"></i>
                                        </div>
                                    </div>
                                    <input type="text"
                                        class="pl-10 pr-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm"
                                        placeholder="Search by Order ID" />
                                </div>
                                <!-- Date Range -->
                                <div class="grid grid-cols-2 gap-2">
                                    <div class="relative">
                                        <input type="date"
                                            class="custom-date-input px-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm"
                                            placeholder="From" />
                                    </div>
                                    <div class="relative">
                                        <input type="date"
                                            class="custom-date-input px-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm"
                                            placeholder="To" />
                                    </div>
                                </div>
                                <!-- Payment Method Filter -->
                                <div class="relative">
                                    <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                        <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                            <i class="ri-arrow-down-s-line"></i>
                                        </div>
                                    </div>
                                    <button
                                        class="px-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm text-left pr-10 bg-white"
                                        id="paymentMethodDropdown">
                                        Payment Method
                                    </button>
                                    <div class="hidden absolute z-10 mt-1 w-full bg-white shadow-lg rounded-md py-1"
                                        id="paymentMethodOptions">
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="methodPending" />
                                            <label for="methodPending">Pending</label>
                                        </div>
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="methodFailed" />
                                            <label for="methodFailed">Failed</label>
                                        </div>
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="methodSuccessful" />
                                            <label for="methodSuccessful">Successful</label>
                                        </div>
                                    </div>
                                </div>
                                <!-- Payment Status Filter -->
                                <div class="relative">
                                    <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                                        <div class="w-5 h-5 flex items-center justify-center text-gray-400">
                                            <i class="ri-arrow-down-s-line"></i>
                                        </div>
                                    </div>
                                    <button
                                        class="px-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm text-left pr-10 bg-white"
                                        id="paymentStatusDropdown">
                                        Payment Status
                                    </button>
                                    <div class="hidden absolute z-10 mt-1 w-full bg-white shadow-lg rounded-md py-1"
                                        id="paymentStatusOptions">
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="statusCOD" />
                                            <label for="statusCOD">Cash on Delivery</label>
                                        </div>
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="statusPayPal" />
                                            <label for="statusPayPal">PayPal</label>
                                        </div>
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="statusDebit" />
                                            <label for="statusDebit">Debit Card</label>
                                        </div>
                                        <div class="px-3 py-2 text-sm hover:bg-gray-100 cursor-pointer flex items-center">
                                            <input type="checkbox" class="mr-2" id="statusCredit" />
                                            <label for="statusCredit">Credit Card</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Filter Buttons -->
                            <div class="flex justify-end mt-4 space-x-3">
                                <button
                                    class="px-4 py-2 border border-gray-300 rounded-button text-gray-700 hover:bg-gray-50 text-sm font-medium whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="w-4 h-4 mr-2 flex items-center justify-center">
                                            <i class="ri-refresh-line"></i>
                                        </div>
                                        Reset
                                    </div>
                                </button>
                                <button
                                    class="px-4 py-2 bg-primary border border-primary rounded-button text-white hover:bg-primary/90 text-sm font-medium whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="w-4 h-4 mr-2 flex items-center justify-center">
                                            <i class="ri-filter-line"></i>
                                        </div>
                                        Apply Filters
                                    </div>
                                </button>
                            </div>
                        </div>                    
                        <!-- Transactions Table -->
                        <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                <div class="flex items-center">
                                                    Order ID
                                                    <div
                                                        class="w-4 h-4 ml-1 flex items-center justify-center text-gray-400">
                                                        <i class="ri-arrow-up-down-line"></i>
                                                    </div>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                <div class="flex items-center">
                                                    Payment Method
                                                    <div
                                                        class="w-4 h-4 ml-1 flex items-center justify-center text-gray-400">
                                                        <i class="ri-arrow-up-down-line"></i>
                                                    </div>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                <div class="flex items-center">
                                                    Amount
                                                    <div
                                                        class="w-4 h-4 ml-1 flex items-center justify-center text-gray-400">
                                                        <i class="ri-arrow-up-down-line"></i>
                                                    </div>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                <div class="flex items-center">
                                                    Payment Status
                                                    <div
                                                        class="w-4 h-4 ml-1 flex items-center justify-center text-gray-400">
                                                        <i class="ri-arrow-up-down-line"></i>
                                                    </div>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                <div class="flex items-center">
                                                    Payment Date
                                                    <div
                                                        class="w-4 h-4 ml-1 flex items-center justify-center text-gray-400">
                                                        <i class="ri-arrow-up-down-line"></i>
                                                    </div>
                                                </div>
                                            </th>
                                            <th scope="col"
                                                class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                                                Actions
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                #1003
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <span class="status-badge payment-method-successful">Successful</span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                ₹304.00
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <span class="status-badge payment-status-credit">Credit Card</span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                Apr 25, 2025
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex justify-end space-x-2">
                                                    <button class="p-1 text-primary hover:text-primary/80" title="Edit">
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-pencil-line"></i>
                                                        </div>
                                                    </button>
                                                    <button class="p-1 text-red-500 hover:text-red-700" title="Delete">
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-delete-bin-line"></i>
                                                        </div>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                #2007
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <span class="status-badge payment-method-pending">Pending</span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                ₹470.00
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <span class="status-badge payment-status-cod">
                                                    Cash on Delivery</span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                Apr 24, 2025
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                                <div class="flex justify-end space-x-2">
                                                    <button class="p-1 text-primary hover:text-primary/80" title="Edit">
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-pencil-line"></i>
                                                        </div>
                                                    </button>
                                                    <button class="p-1 text-red-500 hover:text-red-700" title="Delete">
                                                        <div class="w-5 h-5 flex items-center justify-center">
                                                            <i class="ri-delete-bin-line"></i>
                                                        </div>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const tableBody = document.querySelector("tbody");
                const originalTableContent = tableBody.innerHTML;
                function showLoadingIndicator() {
                    const loadingRow = document.createElement("tr");
                    loadingRow.id = "loadingIndicator";
                    loadingRow.innerHTML = `
              <td colspan="6" class="px-6 py-12 text-center">
                <div class="flex items-center justify-center">
                  <div class="w-6 h-6 border-2 border-primary border-t-transparent rounded-full animate-spin"></div>
                  <span class="ml-2 text-gray-600">Filtering transactions...</span>
                </div>
              </td>
            `;
                    tableBody.innerHTML = "";
                    tableBody.appendChild(loadingRow);
                }
                function showNoResults() {
                    tableBody.innerHTML = `
              <tr>
                <td colspan="6" class="px-6 py-12 text-center">
                  <div class="flex flex-col items-center justify-center text-gray-500">
                    <div class="w-16 h-16 mb-4 flex items-center justify-center text-gray-400">
                      <i class="ri-inbox-line ri-3x"></i>
                    </div>
                    <p class="text-gray-600 font-medium">No matching transactions found</p>
                    <p class="mt-1 text-sm text-gray-500">Try adjusting your filters</p>
                  </div>
                </td>
              </tr>
            `;
                }
                function applyFilters() {
                    const searchText = document
                        .querySelector('input[placeholder="Search by Order ID"]')
                        .value.toLowerCase();
                    const dateFrom = document.querySelector(
                        'input[type="date"]:first-of-type',
                    ).value;
                    const dateTo = document.querySelector(
                        'input[type="date"]:last-of-type',
                    ).value;

                    const selectedPaymentMethods = Array.from(
                        document.querySelectorAll(
                            '#paymentMethodOptions input[type="checkbox"]:checked',
                        ),
                    ).map((checkbox) => checkbox.id.replace("method", ""));

                    const selectedPaymentStatuses = Array.from(
                        document.querySelectorAll(
                            '#paymentStatusOptions input[type="checkbox"]:checked',
                        ),
                    ).map((checkbox) => checkbox.id.replace("status", ""));
                    showLoadingIndicator();
                    setTimeout(() => {
                        const rows = originalTableContent
                            .split("</tr>")
                            .filter((row) => row.trim());
                        const filteredRows = rows.filter((row) => {
                            const orderID = row.match(/#ORD-\d+/)?.[0]?.toLowerCase() || "";
                            const paymentMethod =
                                row.match(/payment-method-(\w+)/)?.[1]?.toLowerCase() || "";
                            const paymentStatus =
                                row.match(/payment-status-(\w+)/)?.[1]?.toLowerCase() || "";
                            const date = row.match(/Apr \d+, 2025/)?.[0] || "";
                            const matchesSearch = !searchText || orderID.includes(searchText);
                            const matchesDateRange =
                                !dateFrom || !dateTo || (date >= dateFrom && date <= dateTo);
                            const matchesPaymentMethod =
                                !selectedPaymentMethods.length ||
                                selectedPaymentMethods.some((method) =>
                                    paymentMethod.includes(method.toLowerCase()),
                                );
                            const matchesPaymentStatus =
                                !selectedPaymentStatuses.length ||
                                selectedPaymentStatuses.some((status) =>
                                    paymentStatus.includes(status.toLowerCase()),
                                );
                            return (
                                matchesSearch &&
                                matchesDateRange &&
                                matchesPaymentMethod &&
                                matchesPaymentStatus
                            );
                        });
                        if (filteredRows.length === 0) {
                            showNoResults();
                        } else {
                            tableBody.innerHTML = filteredRows.join("</tr>") + "</tr>";
                        }
                    }, 500);
                }
                // Payment Method Dropdown
                const paymentMethodDropdown = document.getElementById(
                    "paymentMethodDropdown",
                );
                const paymentMethodOptions = document.getElementById("paymentMethodOptions");
                paymentMethodDropdown.addEventListener("click", function () {
                    paymentMethodOptions.classList.toggle("hidden");
                    // Hide the other dropdown if open
                    paymentStatusOptions.classList.add("hidden");
                });
                // Payment Status Dropdown
                const paymentStatusDropdown = document.getElementById(
                    "paymentStatusDropdown",
                );
                const paymentStatusOptions = document.getElementById("paymentStatusOptions");
                paymentStatusDropdown.addEventListener("click", function () {
                    paymentStatusOptions.classList.toggle("hidden");
                    // Hide the other dropdown if open
                    paymentMethodOptions.classList.add("hidden");
                });
                // Close dropdowns when clicking outside
                document.addEventListener("click", function (event) {
                    if (
                        !paymentMethodDropdown.contains(event.target) &&
                        !paymentMethodOptions.contains(event.target)
                    ) {
                        paymentMethodOptions.classList.add("hidden");
                    }
                    if (
                        !paymentStatusDropdown.contains(event.target) &&
                        !paymentStatusOptions.contains(event.target)
                    ) {
                        paymentStatusOptions.classList.add("hidden");
                    }
                });
                // Add click event listener for Apply Filters button
                document
                    .querySelector("button:has(.ri-filter-line)")
                    .addEventListener("click", applyFilters);
            });
        </script>
    </body>

</asp:Content>
