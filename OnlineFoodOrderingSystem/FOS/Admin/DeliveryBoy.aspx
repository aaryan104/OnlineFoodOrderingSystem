<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DeliveryBoy.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.DeliveryBoy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manage Delivery Agents</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: { primary: "#FEA116", secondary: "#0F172A" },
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" rel="stylesheet" />
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .custom-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .custom-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked+.slider {
            background-color: #FEA116;
        }

        input:checked+.slider:before {
            transform: translateX(26px);
        }

        @media (max-width: 640px) {
            .responsive-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <body>
        <div class="container mx-auto px-4 py-8">
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-3xl font-bold text-primary">Manage Delivery Agents</h1>
                <a href="../DeliveryAgent/addAgent.aspx"
                    class="bg-primary text-white px-4 py-2 !rounded-button whitespace-nowrap flex items-center">
                    <div class="w-5 h-5 flex items-center justify-center mr-2">
                        <i class="ri-user-add-line"></i>
                    </div>
                    Add New Agent
                </a>
            </div>
            <div class="bg-white rounded shadow-md p-6 mb-8 relative">
                <h2 class="text-xl font-semibold mb-6 text-gray-800">
                    Update Agent Information
                </h2>
                <form id="agentForm" runat="server">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                            <asp:TextBox ID="firstName" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                                placeholder="Enter first name"></asp:TextBox>
                        </div>
                        <div>
                            <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                            <asp:TextBox ID="lastName" runat="server" 
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                                placeholder="Enter last name"></asp:TextBox>
                        </div>
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                            <asp:TextBox ID="email" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                                placeholder="Enter email address"></asp:TextBox>
                        </div>
                        <div>
                            <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <asp:TextBox ID="password" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded bg-gray-100 cursor-not-allowed"
                                placeholder="Password" readonly></asp:TextBox>
                        </div>
                        <div>
                            <label for="phoneNumber" class="block text-sm font-medium text-gray-700 mb-1">Phone
                                Number</label>
                            <asp:TextBox ID="phoneNumber" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                                placeholder="Enter phone number"></asp:TextBox>
                        </div>
                        <div>
                            <label for="vehicleNumber" class="block text-sm font-medium text-gray-700 mb-1">Vehicle
                                Number</label>
                            <asp:TextBox ID="vehicleNumber" runat="server"
                                class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary"
                                placeholder="Enter vehicle number"></asp:TextBox>
                        </div>
                        <div>
                            <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                            <div class="relative">
                                <asp:DropDownList ID="status" runat="server"
                                    class="w-full px-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary appearance-none pr-8">
                                    <asp:ListItem>-- Status --</asp:ListItem>
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                    <asp:ListItem>Offline</asp:ListItem>
                                </asp:DropDownList>
                                <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                    <div class="w-5 h-5 flex items-center justify-center text-gray-500">
                                        <i class="ri-arrow-down-s-line"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="md:col-span-2">
                            <label for="address" class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                            <asp:DropDownList ID="workingArea" runat="server"
                                class="w-full px-10 py-2 border border-gray-300 rounded text-gray-700 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary">
                                <asp:ListItem>-- Select area --</asp:ListItem>
                                <asp:ListItem>Katargam, Surat</asp:ListItem>
                                <asp:ListItem>Adajan, Surat</asp:ListItem>
                                <asp:ListItem>Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Nana Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Mota Varachha, Surat</asp:ListItem>
                                <asp:ListItem>Kamrej, Surat</asp:ListItem>
                                <asp:ListItem>Vesu, Surat</asp:ListItem>
                                <asp:ListItem>New Katargam, Surat</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="flex justify-end mt-8">
                        <button id="resetBtn"
                            class="absolute top-6 right-6 text-gray-500 hover:text-primary transition-colors w-10 h-10 flex items-center justify-center">
                            <i class="ri-refresh-line ri-lg"></i>
                        </button>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Agent" 
                            class="px-5 py-2 bg-primary text-white !rounded-button whitespace-nowrap hover:bg-primary/90 transition-colors" OnClick="btnUpdate_Click"/>
                    </div>
                    <asp:HiddenField ID="hiddenItemId" runat="server" />
                    <div class="message text-center flex flex-col items-center  ">
                        <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                    </div>
            </div>
            <div class="bg-white rounded shadow-md p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-semibold text-gray-800">
                        All Delivery Agents
                    </h2>
                    <div class="relative">
                        <input type="text" id="searchAgent" placeholder="Search agents..."
                            class="pl-10 pr-4 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-primary/50 focus:border-primary" />
                        <div
                            class="absolute left-0 top-0 h-full flex items-center pl-3 pointer-events-none w-5 h-5 text-gray-500">
                            <i class="ri-search-line"></i>
                        </div>
                    </div>
                </div>
                <div class="overflow-x-auto responsive-table">
                    <asp:GridView ID="GridViewDeliveryAgents" runat="server" AutoGenerateColumns="False" CssClass="min-w-full divide-y divide-gray-200" 
                        GridLines="None" HeaderStyle-BackColor="#F9FAFB" HeaderStyle-ForeColor="Gray" HeaderStyle-Font-Bold="true" 
                        RowStyle-BackColor="White" AlternatingRowStyle-BackColor="#F9FAFB" DataKeyNames="DeliveryAgentId">
    
                        <Columns>
                            <asp:BoundField DataField="FirstName" HeaderText="First Name" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center" />
                            <asp:BoundField DataField="LastName" HeaderText="Last Name" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center" />
                            <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center" />
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center" />
                            <asp:BoundField DataField="VehicleNumber" HeaderText="Vehicle" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-center" />
        
                            <asp:TemplateField HeaderText="Status"> 
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' 
                                        CssClass='<%# Eval("Status").ToString() == "Active" ? "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800" : 
                                                      Eval("Status").ToString() == "Inactive" ? "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800" :
                                                                                              "px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800" %>'>
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="px-6 py-4 whitespace-nowrap" />
                            </asp:TemplateField>

                            <asp:BoundField DataField="Address" HeaderText="Address" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center" />
    
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="flex items-center space-x-3">
                                        <asp:LinkButton ID="btnEdit" runat="server" OnClick="btnEdit_Click" CommandArgument='<%# Eval("DeliveryAgentId") %>' CssClass="text-primary hover:text-primary/90 mr-2">
                                            <i class="ri-edit-line"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("DeliveryAgentId") %>' CssClass="text-red-500 hover:text-red-700 w-8 h-8 flex items-center justify-center" 
                                            OnClientClick="return confirm('Are you sure you want to delete this agent?');">
                                            <i class="ri-delete-bin-line ri-lg"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle CssClass="px-6 py-4 whitespace-nowrap text-sm font-medium" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </form>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                const resetBtn = document.getElementById("resetBtn");
                const agentForm = document.getElementById("agentForm");
                resetBtn.addEventListener("click", function () {
                    agentForm.reset();
                });

                const editButtons = document.querySelectorAll(".text-primary");
                editButtons.forEach((button) => {
                    button.addEventListener("click", function () {
                        const row = this.closest("tr");
                        const cells = row.querySelectorAll("td");

                        document.getElementById("firstName").value = cells[1].textContent;
                        document.getElementById("lastName").value = cells[2].textContent;
                        document.getElementById("email").value = cells[3].textContent;
                        document.getElementById("password").value = "********";
                        document.getElementById("phoneNumber").value = cells[4].textContent;
                        document.getElementById("vehicleNumber").value = cells[5].textContent;
                        document.getElementById("status").value =
                            cells[6].textContent.trim().toLowerCase() === "active"
                                ? "active"
                                : "inactive";
                        document.getElementById("address").value = cells[7].textContent;

                        document
                            .querySelector(".bg-white")
                            .scrollIntoView({ behavior: "smooth" });
                    });
                });

                const deleteButtons = document.querySelectorAll(".text-red-500");
                deleteButtons.forEach((button) => {
                    button.addEventListener("click", function () {
                        const row = this.closest("tr");
                        const name =
                            row.querySelectorAll("td")[1].textContent +
                            " " +
                            row.querySelectorAll("td")[2].textContent;
                        if (confirm(`Are you sure you want to delete ${name}?`)) {
                            row.remove();
                            alert("Agent deleted successfully!");
                        }
                    });
                });

                const searchInput = document.getElementById("searchAgent");
                searchInput.addEventListener("input", function () {
                    const searchTerm = this.value.toLowerCase();
                    const rows = document.querySelectorAll("tbody tr");
                    rows.forEach((row) => {
                        const text = row.textContent.toLowerCase();
                        row.style.display = text.includes(searchTerm) ? "" : "none";
                    });
                });
            });
        </script>
    </body>

</asp:Content>
