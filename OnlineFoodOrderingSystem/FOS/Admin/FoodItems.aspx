<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="FoodItems.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.FoodItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#FEA116',
                        secondary: '#4B5563'
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
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .tooltip {
            visibility: hidden;
            position: absolute;
            background: rgba(0,0,0,0.8);
            color: white;
            padding: 5px 10px;
            border-radius: 6px;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            transform: translateX(-50%);
            white-space: nowrap;
        }

        .tooltip-trigger:hover .tooltip {
            visibility: visible;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body class="bg-gray-50 min-h-screen">
        <div class="container mx-auto px-4 py-2">
            <div class="mb-8">
                <h1 class="text-3xl font-bold text-gray-900 mb-2">Menu Management</h1>
                <p class="text-gray-600">Add, edit or remove menu items</p>
            </div>

            <div class="bg-white rounded-lg shadow-md p-6 mb-8">
                <form id="menuForm" class="space-y-6" runat="server">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                            <asp:TextBox ID="txtName" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Price</label>
                            <div class="relative">
                                <span class="absolute left-3 top-2 text-gray-500">(₹)</span>
                                <asp:TextBox ID="txtPrice" runat="server"
                                    step="0.01" min="0" class="w-full pl-8 pr-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm" TextMode="Number"></asp:TextBox>
                            </div>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server"
                                Rows="3" class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                            <div class="relative">
                                <asp:DropDownList ID="txtCategory" runat="server" class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary appearance-none pr-10">
                                    <asp:ListItem>-- Select --</asp:ListItem>
                                    <asp:ListItem>Fast-Food</asp:ListItem>
                                    <asp:ListItem>Lunch</asp:ListItem>
                                    <asp:ListItem>Breakfast</asp:ListItem>
                                    <asp:ListItem>Dinner</asp:ListItem>
                                    <asp:ListItem>Drinks</asp:ListItem>
                                </asp:DropDownList>
                                <div class="absolute right-3 top-2.5 pointer-events-none">
                                    <i class="ri-arrow-down-s-line text-gray-400"></i>
                                </div>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Image</label>
                            <div class="flex items-center space-x-4">
                                <label
                                    class="flex items-center justify-center px-4 py-2 border border-gray-300 rounded-button cursor-pointer hover:bg-gray-50 !rounded-button">
                                    <i class="ri-upload-2-line mr-2"></i>
                                    <span class="text-sm">Upload Image</span>
                                    <asp:FileUpload ID="txtUpload" runat="server" class="hidden" onchange="previewImage(event)" />
                                </label>
                                <div id="imagePreview" class="hidden w-16 h-16 rounded overflow-hidden">
                                    <img src="" alt="Preview" class="w-full h-full object-cover" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="flex justify-end space-x-4">
                        <asp:Button ID="resetBtn" runat="server" class="px-6 py-2 border border-gray-300 rounded-button text-gray-700 hover:bg-gray-50 !rounded-button whitespace-nowrap" Text="Reset" OnClick="resetBtn_Click1" />
                        <asp:Button ID="submitBtn" runat="server" class="px-6 py-2 bg-primary text-white rounded-button hover:bg-primary/90 !rounded-button whitespace-nowrap" Text="Save" OnClick="submitBtn_Click" />
                        <asp:Button ID="updateBtn" OnClientClick="Hidden()" runat="server" class="px-6 py-2 bg-primary text-white rounded-button hover:bg-primary/90 !rounded-button whitespace-nowrap" Text="Edit" OnClick="updateBtn_Click" />
                        <asp:HiddenField ID="hiddenItemId" runat="server" />
                    </div>
                    <div class="message text-center flex flex-col items-center  ">
                        <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                    </div>
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <div class="p-4 border-b flex justify-between items-center">
                            <h2 class="text-lg font-semibold text-gray-900">Menu Items</h2>
                            <div class="relative">
                                <asp:TextBox ID="searchInput" placeholder="Search items..."
                                    class="pl-10 pr-40 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"
                                    runat="server" ClientIDMode="Static" oninput="filterMenuItems()">
                                </asp:TextBox>
                                <i class="ri-search-line absolute left-3 top-2.5 text-gray-400"></i>
                            </div>
                        </div>
                        <div class="overflow-x-auto">
                            <asp:GridView ID="MenuItems" runat="server" AutoGenerateColumns="False"
                                CssClass="w-full" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="Name" HeaderText="Name" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-right">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnEdit" runat="server" OnClick="btnEdit_Click" CommandArgument='<%# Eval("ItemId") %>' CssClass="text-primary hover:text-primary/90 mr-2">
                                                <i class="ri-edit-line"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("ItemId") %>' OnClientClick="Conform()" CssClass="text-red-600 hover:text-red-700">
                                                <i class="ri-delete-bin-line"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="bg-gray-50" />
                                <RowStyle CssClass="border-b border-gray-200 menu-row" />
                            </asp:GridView>
                        </div>
                    </div>
                </form>
            </div>

        </div>

        <div id="modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
            <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
                <h3 class="text-lg font-medium text-gray-900 mb-4" id="modalTitle">Confirm Delete
                </h3>
                <p class="text-gray-500 mb-6" id="modalMessage">
                    Are you sure you want to delete this item?
                </p>
                <div class="flex justify-end space-x-4">
                    <button onclick="closeModal()"
                        class="px-4 py-2 border border-gray-300 rounded-button text-gray-700 hover:bg-gray-50 !rounded-button">
                        Cancel
                    </button>
                    <button id="modalConfirm"
                        class="px-4 py-2 bg-red-600 text-white rounded-button hover:bg-red-700 !rounded-button">
                        Delete
                    </button>
                </div>
            </div>
        </div>

        <script>
            function previewImage(event) {
                const preview = document.getElementById("imagePreview");
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.querySelector("img").src = e.target.result;
                        preview.classList.remove("hidden");
                    };
                    reader.readAsDataURL(file);
                }
            }

            function filterMenuItems() {
                const searchTerm = document.getElementById("searchInput").value.toLowerCase();
                const rows = document.querySelectorAll(".menu-row");
                let visibleCount = 0;

                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    const match = text.includes(searchTerm);
                    row.style.display = match ? "" : "none";
                    if (match) visibleCount++;
                });

                // Optional: Show a message if no results
                let msg = document.getElementById("noResultsMsg");
                if (!msg) {
                    msg = document.createElement("h1");
                    msg.id = "noResultsMsg";
                    msg.className = "text-center text-gray-500 text-xl mt-6";
                    msg.innerText = "No item found";
                    document.querySelector(".overflow-x-auto").appendChild(msg);
                }
                msg.style.display = visibleCount === 0 ? "block" : "none";
            }

            function Conform() {
                confirm("Are you want to delete this food?");   
            }
        </script>
    </body>
</asp:Content>
