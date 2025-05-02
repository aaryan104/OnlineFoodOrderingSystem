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

    <body>
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
                                    <input type="text" id="orderIdSearch" placeholder="Search by Order ID"
                                        class="pl-10 pr-3 py-2 w-full border border-gray-300 rounded focus:ring-primary focus:border-primary text-sm"
                                        onkeyup="filterTable()" />
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
                                        id="paymentStatusDropdown">
                                        Payment Status
                                    </button>
                                    <div class="hidden absolute z-10 mt-1 w-full bg-white shadow-lg rounded-md py-1"
                                        id="paymentStatusOptions">
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
                                        id="paymentMethodDropdown">
                                        Payment Methos
                                    </button>
                                    <div class="hidden absolute z-10 mt-1 w-full bg-white shadow-lg rounded-md py-1"
                                        id="paymentMethodOptions">
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
                        <div class="message text-center flex flex-col items-center  ">
                            <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                        </div>
                        <!-- Transactions Table -->
                        <form runat="server">
                            <div class="bg-white rounded-lg shadow-sm overflow-hidden">
                                <div class="overflow-x-auto">
                                    <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="min-w-full divide-y divide-gray-200"
                                        GridLines="None" ShowHeader="true">
                                        <HeaderStyle CssClass="bg-white text-center" />
                                        <RowStyle CssClass="hover:bg-white" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <input type="checkbox" class="chk custom-checkbox" id="select-all" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <input type="checkbox" class="chk custom-checkbox row-checkbox" />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="OrderId" HeaderText="Order ID"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" />
        
                                            <asp:TemplateField HeaderText="Customer"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                                <ItemTemplate>
                                                    <div class="flex items-center">
                                                        <div class="w-8 h-8 flex items-center justify-center bg-blue-100 rounded-full bg-black-100 text-black-600">
                                                            <span class="text-xs font-medium">
                                                                <%# Eval("UserId") %>
                                                            </span>
                                                        </div>
                                                        <div class="ml-3">
                                                            <p class="text-sm font-medium text-gray-900"><%# Eval("FullName") %></p>
                                                            <p class="text-xs text-gray-500"><%# Eval("PhoneNumber") %></p>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
        
                                            <asp:TemplateField HeaderText="Payment Status"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" 
                                                    ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                                    <ItemTemplate>
                                                        <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                                        <%# Eval("PaymentStatus").ToString() == "Failed" ? "bg-red-100 text-red-800" : 
                                                            Eval("PaymentStatus").ToString() == "Successful" ? "bg-green-100 text-green-800" : 
                                                            Eval("PaymentStatus").ToString() == "Pending" ? "bg-yellow-100 text-yellow-800" : 
                                                            "bg-gray-100 text-gray-800" %>'>
                                                        <%# Eval("PaymentStatus") %>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
        
                                            <asp:BoundField DataField="TotalAmount" HeaderText="Amount"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                                                DataFormatString="{0:C}" HtmlEncode="false" />
        
                                            <asp:TemplateField HeaderText="Payment Method"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" 
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                                                <ItemTemplate>
                                                    <span class='px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                                    <%# Eval("PaymentMethod").ToString() == "Cash on Delivery" ? "bg-purple-100 text-purple-800" : 
                                                        Eval("PaymentMethod").ToString() == "PayPal" ? "bg-purple-100 text-purple-800" : 
                                                        Eval("PaymentMethod").ToString() == "Debit Card" ? "bg-purple-100 text-purple-800" : 
                                                        Eval("PaymentMethod").ToString() == "Credit Card" ? "bg-yellow-100 text-" : 
                                                        "bg-gray-100 text-gray-800" %>'>
                                                        <%# Eval("PaymentMethod") %>
                                                    </span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
        
                                            <asp:TemplateField HeaderText="Payment Date"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <ItemTemplate>
                                                    <%# Convert.ToDateTime(Eval("PaymentDate")).ToString("MMM dd, yyyy - hh:mm tt") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Order Date"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <ItemTemplate>
                                                    <%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy - hh:mm:ss tt") %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
        
                                            <asp:TemplateField HeaderText="Actions"
                                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <ItemTemplate>
                                                    <div class="flex justify-end space-x-2">
                                                        <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("OrderId") %>' CssClass="text-red-500 hover:text-red-700 w-8 h-8 flex items-center justify-center" 
                                                            OnClientClick="return confirm('Are you sure you want to delete this agent?');">
                                                            <i class="ri-delete-bin-line ri-lg"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </form>
                    </div>
                </main>
            </div>
        </div>
        <script>
            function filterTable() {
                var input = document.getElementById("orderIdSearch");
                var filter = input.value.toLowerCase();
                var table = document.querySelector("#<%= gvOrders.ClientID %>");
                var tr = table.getElementsByTagName("tr");

                for (var i = 1; i < tr.length; i++) {
                    var td = tr[i].getElementsByTagName("td")[1];
                    if (td) {
                        var txtValue = td.textContent || td.innerText;
                        tr[i].style.display = txtValue.toLowerCase().indexOf(filter) > -1 ? "" : "none";
                    }
                }
            }

            function applyAdvancedFilters() {
                var orderIdFilter = document.getElementById("orderIdSearch").value.toLowerCase();
                var dateFrom = document.querySelector('input[type="date"]:first-of-type').value;
                var dateTo = document.querySelector('input[type="date"]:last-of-type').value;
                var table = document.querySelector("#<%= gvOrders.ClientID %>");
                var tr = table.getElementsByTagName("tr");

                for (var i = 1; i < tr.length; i++) {
                    var row = tr[i];
                    var orderId = row.cells[1].innerText.toLowerCase();
                    var paymentStatus = row.cells[3].innerText.toLowerCase();
                    var paymentMethod = row.cells[4].innerText.toLowerCase();
                    var paymentDate = new Date(row.cells[5].innerText);
                    var match = true;

                    if (orderIdFilter && !orderId.includes(orderIdFilter)) match = false;
                    if (dateFrom && new Date(dateFrom) > paymentDate) match = false;
                    if (dateTo && new Date(dateTo) < paymentDate) match = false;

                    // Add your payment status/method check here as needed

                    row.style.display = match ? "" : "none";
                }
            }

            document.querySelector("button:has(.ri-filter-line)").addEventListener("click", applyAdvancedFilters);

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
