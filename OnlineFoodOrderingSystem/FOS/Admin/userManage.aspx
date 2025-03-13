<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="userManage.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.userManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FEA116",
                        secondary: "#F43F5E",
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

        .table-container::-webkit-scrollbar {
            height: 6px;
        }

        .table-container::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        .table-container::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 3px;
        }

        .table-container::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        .addUser {
            border: 2px solid #FEA116;
            padding: 0 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <body class="bg-gray-50 min-h-screen">
    <div class="container mx-auto px-4 py-2">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">User Management</h1>
            <p class="text-gray-600">Edit or remove User</p>
        </div>

        <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
            <form id="userForm" class="grid grid-cols-1 md:grid-cols-2 gap-6" runat="server">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                    <asp:TextBox ID="txtfirstName" runat="server" placeholder="Enter first name"
                        class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                    <asp:TextBox ID="txtlastName" runat="server" placeholder="Enter last name"
                        class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter email"
                        class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                    <div class="relative">
                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter password" type="password"
                            class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm pr-10"></asp:TextBox>
                        <button type="button" id="togglePassword"
                            class="absolute right-3 top-1/2 -translate-y-1/2 w-6 h-6 flex items-center justify-center text-gray-500 cursor-pointer">
                            <i id="eyeIcon" class="ri-eye-line text-lg"></i>
                        </button>
                    </div>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter phone number"
                        class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm"></asp:TextBox>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                    <div class="relative">
                        <asp:DropDownList ID="txtRole" runat="server" class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm appearance-none pr-10">
                            <asp:ListItem>-- Select Role --</asp:ListItem>
                            <asp:ListItem>Admin</asp:ListItem>
                            <asp:ListItem>Customer</asp:ListItem>
                            <asp:ListItem>Delivery-Boy</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;<div
                            class="absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none w-6 h-6 flex items-center justify-center">
                            <i class="ri-arrow-down-s-line text-gray-400"></i>
                        </div>
                    </div>
                </div>
                <div class="md:col-span-2">
                    <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="Enter address" Rows="3"
                        class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm" TextMode="MultiLine"></asp:TextBox>
                </div>
                <div class="md:col-span-2 flex gap-4">
                    <asp:Button ID="updateBtn" runat="server" Text="Update User" 
                         class="px-6 py-2 bg-primary text-white rounded-button hover:bg-primary/90 transition-colors cursor-pointer whitespace-nowrap text-sm font-medium" OnClick="updateBtn_Click"/>
                    <asp:HiddenField ID="hiddenItemId" runat="server" />
                    <asp:Button ID="btnAddUser" runat="server" Text="Add new user?" class="addUser text-primary hover:text-primary/80 text-sm font-medium !rounded-button" OnClick="btnAddUser_Click1"/>
                    <button id="btnRefresh" type="button" onclick="clearFormFields()">
                        <i class="ri-refresh-line cursor-pointer text-2xl"></i>
                    </button>
                </div>
            </div>
            <div class="message text-center flex flex-col items-center">
                <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
            </div>
       
                <div class="bg-white rounded-lg shadow-sm p-6 overflow-hidden">
                    <div class="flex flex-col md:flex-row gap-4 mb-6">
                        <div class="flex-1">
                            <asp:TextBox ID="searchInput" runat="server" placeholder="Search users..." onkeyup="debounceSearch()"
                                class="w-full px-4 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm" OnTextChanged="searchInput_TextChanged"></asp:TextBox>
                        </div>
                        <div class="flex items-center gap-2 text-sm text-gray-600">
                            <span>Sort by:</span>
                            <asp:DropDownList ID="sortField" runat="server" class="px-3 py-2 border rounded-button focus:ring-2 focus:ring-primary focus:border-primary text-sm">
                                <asp:ListItem>First Name</asp:ListItem>
                                <asp:ListItem>Last Name</asp:ListItem>
                                <asp:ListItem>Email</asp:ListItem>
                                <asp:ListItem>Role</asp:ListItem>
                            </asp:DropDownList>
                            <button id="sortOrder"
                                class="w-8 h-8 flex items-center justify-center border rounded-button hover:bg-gray-50">
                                <i class="ri-sort-asc"></i>
                            </button>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <asp:GridView ID="UserGV" runat="server" AutoGenerateColumns="False"
                            CssClass="w-full" GridLines="None" OnRowDataBound="GridView_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-right">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" OnClick="btnEdit_Click" CommandArgument='<%# Eval("UserID") %>' CssClass="text-primary hover:text-primary/90 mr-2">
                                            <i class="ri-edit-line"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("UserID") %>' OnClientClick="Conform()" CssClass="text-red-600 hover:text-red-700">
                                            <i class="ri-delete-bin-line"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="FirstName" HeaderText="FirstName" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                <asp:BoundField DataField="LastName" HeaderText="LastName" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                <asp:BoundField DataField="Email" HeaderText="Email" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                <asp:BoundField DataField="Role" HeaderText="Role" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                                <asp:BoundField DataField="Address" HeaderText="Address" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 text-sm text-gray-900" />
                            </Columns>
                            <HeaderStyle CssClass="bg-gray-50" />
                            <RowStyle CssClass="border-b border-gray-200" />
                        </asp:GridView>
                    </form>
                    </div>
            </div>
            <div id="confirmDialog" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
                    <div class="flex items-center justify-center w-12 h-12 rounded-full bg-red-100 mx-auto mb-4">
                        <i class="ri-error-warning-line text-2xl text-secondary"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 text-center mb-2">
                        Delete Confirmation
                    </h3>
                    <p class="text-sm text-gray-500 text-center mb-6">
                        Are you sure you want to delete this user? This action cannot be
                        undone.
                    </p>
                    <div class="flex justify-center gap-4">
                        <button id="cancelDelete"
                            class="px-4 py-2 border border-gray-300 rounded-button hover:bg-gray-50 transition-colors cursor-pointer whitespace-nowrap text-sm font-medium">
                            Cancel
                        </button>
                        <button id="confirmDelete"
                            class="px-4 py-2 bg-secondary text-white rounded-button hover:bg-secondary/90 transition-colors cursor-pointer whitespace-nowrap text-sm font-medium">
                            Delete
                        </button>
                    </div>
                </div>
            </div>
        </div>
        </body>
        <script>
            document.getElementById("togglePassword").addEventListener("click", function () {
                const passwordInput = document.getElementById("txtPassword");
                const eyeIcon = document.getElementById("eyeIcon");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    eyeIcon.className = "ri-eye-off-line text-lg";
                } else {
                    passwordInput.type = "password";
                    eyeIcon.className = "ri-eye-line text-lg";
                }
            });

            let debounceTimer;

            function debounceSearch() {
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(function () {
                    __doPostBack('<%= searchInput.ClientID %>', '');
                }, 500);
            }

            function clearFormFields() {
                document.getElementById('<%= txtfirstName.ClientID %>').value = '';
                document.getElementById('<%= txtlastName.ClientID %>').value = '';
                document.getElementById('<%= txtEmail.ClientID %>').value = '';
                document.getElementById('<%= txtPassword.ClientID %>').value = '';
                document.getElementById('<%= txtPhone.ClientID %>').value = '';
                document.getElementById('<%= txtRole.ClientID %>').selectedIndex = 0;
                document.getElementById('<%= txtAddress.ClientID %>').value = '';
                document.getElementById('<%= hiddenItemId.ClientID %>').value = '';
            }
        </script>
</asp:Content>
