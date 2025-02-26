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
        :where([class^="ri-"])::before { content: "\f3c2"; }
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
    <div class="container mx-auto px-4 py-8">
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900 mb-2">Menu Management</h1>
            <p class="text-gray-600">Add, edit or remove menu items</p>
        </div>

        <div class="bg-white rounded-lg shadow-lg p-6 mb-8">
            <form id="menuForm" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="relative tooltip-trigger">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Name</label>
                        <input type="text" id="name" required class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary">
                        <span class="tooltip">Enter the dish name</span>
                    </div>

                    <div class="relative tooltip-trigger">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Price ($)</label>
                        <input type="number" id="price" required step="0.01" min="0" class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary">
                        <span class="tooltip">Enter the price in USD</span>
                    </div>

                    <div class="relative tooltip-trigger md:col-span-2">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                        <textarea id="description" rows="3" class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary"></textarea>
                        <span class="tooltip">Describe the dish</span>
                    </div>

                    <div class="relative tooltip-trigger">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Category</label>
                        <div class="relative">
                            <select id="category" required class="w-full px-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary appearance-none pr-10">
                                <option value="">Select category</option>
                                <option value="appetizer">Appetizer</option>
                                <option value="main">Main Course</option>
                                <option value="dessert">Dessert</option>
                                <option value="beverage">Beverage</option>
                            </select>
                            <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
                                <i class="ri-arrow-down-s-line text-gray-400"></i>
                            </div>
                        </div>
                        <span class="tooltip">Select dish category</span>
                    </div>

                    <div class="relative tooltip-trigger">
                        <label class="block text-sm font-medium text-gray-700 mb-1">Image</label>
                        <div class="flex items-center space-x-4">
                            <label class="flex items-center px-4 py-2 bg-white border border-gray-300 rounded-button cursor-pointer hover:bg-gray-50">
                                <i class="ri-upload-2-line mr-2"></i>
                                <span>Choose file</span>
                                <input type="file" id="image" accept="image/*" class="hidden">
                            </label>
                            <div id="imagePreview" class="hidden w-16 h-16 rounded-lg overflow-hidden">
                                <img src="" alt="Preview" class="w-full h-full object-cover">
                            </div>
                        </div>
                        <span class="tooltip">Upload dish image</span>
                    </div>
                </div>

                <div class="flex justify-end space-x-4">
                    <button type="button" id="resetBtn" class="px-6 py-2 border border-gray-300 rounded-button text-gray-700 hover:bg-gray-50 !rounded-button whitespace-nowrap">Reset</button>
                    <button type="submit" class="px-6 py-2 bg-primary text-white rounded-button hover:bg-primary/90 !rounded-button whitespace-nowrap">Save Menu Item</button>
                </div>
            </form>
        </div>

        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="p-4 border-b border-gray-200">
                <div class="flex flex-wrap items-center justify-between gap-4">
                    <h2 class="text-xl font-semibold text-gray-900">Menu Items</h2>
                    <div class="relative">
                        <input type="text" id="searchInput" placeholder="Search menu items..." class="pl-10 pr-4 py-2 border border-gray-300 rounded-button focus:ring-2 focus:ring-primary focus:border-primary">
                        <i class="ri-search-line absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    </div>
                </div>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="menuTableBody" class="bg-white divide-y divide-gray-200"></tbody>
                </table>
            </div>

            <div class="flex items-center justify-between p-4 border-t border-gray-200">
                <div class="text-sm text-gray-700">
                    Showing <span id="itemCount">0</span> items
                </div>
                <div class="flex space-x-2">
                    <button class="px-3 py-1 border border-gray-300 rounded-button hover:bg-gray-50 !rounded-button whitespace-nowrap">Previous</button>
                    <button class="px-3 py-1 border border-gray-300 rounded-button hover:bg-gray-50 !rounded-button whitespace-nowrap">Next</button>
                </div>
            </div>
        </div>
    </div>

    <div id="toast" class="fixed top-4 right-4 transform transition-transform duration-300 translate-x-full">
        <div class="bg-white border-l-4 border-primary shadow-lg rounded-lg p-4 flex items-center">
            <i class="ri-check-line text-primary mr-3"></i>
            <p id="toastMessage" class="text-gray-700"></p>
        </div>
    </div>

    <script>
        const mockData = [
            { id: 1, name: "Grilled Salmon", category: "main", price: 24.99, description: "Fresh Atlantic salmon with herbs and lemon" },
            { id: 2, name: "Chocolate Lava Cake", category: "dessert", price: 8.99, description: "Warm chocolate cake with molten center" },
            { id: 3, name: "Caesar Salad", category: "appetizer", price: 12.99, description: "Crisp romaine lettuce with classic Caesar dressing" },
            { id: 4, name: "Craft Beer", category: "beverage", price: 6.99, description: "Local IPA with citrus notes" }
        ];
        function showToast(message) {
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            toastMessage.textContent = message;
            toast.classList.remove('translate-x-full');
            setTimeout(() => {
                toast.classList.add('translate-x-full');
            }, 3000);
        }

        function renderTable() {
            const tableBody = document.getElementById('menuTableBody');
            tableBody.innerHTML = '';

            mockData.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">${item.name}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-gray-500">${item.category}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-gray-900">$${item.price.toFixed(2)}</div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="text-sm text-gray-500">${item.description}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <button onclick="editItem(${item.id})" class="text-primary hover:text-primary/80 mr-3">Edit</button>
                        <button onclick="deleteItem(${item.id})" class="text-red-600 hover:text-red-900">Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });

            document.getElementById('itemCount').textContent = mockData.length;
        }

        document.getElementById('menuForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const formData = {
                id: Date.now(),
                name: document.getElementById('name').value,
                price: parseFloat(document.getElementById('price').value),
                description: document.getElementById('description').value,
                category: document.getElementById('category').value
            };

            mockData.push(formData);
            renderTable();
            this.reset();
            showToast('Menu item added successfully!');
        });

        document.getElementById('resetBtn').addEventListener('click', function () {
            document.getElementById('menuForm').reset();
            document.getElementById('imagePreview').classList.add('hidden');
        });

        document.getElementById('image').addEventListener('change', function (e) {
            const preview = document.getElementById('imagePreview');
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.querySelector('img').src = e.target.result;
                    preview.classList.remove('hidden');
                }
                reader.readAsDataURL(file);
            }
        });

        document.getElementById('searchInput').addEventListener('input', function (e) {
            const searchTerm = e.target.value.toLowerCase();
            const filteredData = mockData.filter(item =>
                item.name.toLowerCase().includes(searchTerm) ||
                item.description.toLowerCase().includes(searchTerm) ||
                item.category.toLowerCase().includes(searchTerm)
            );
            renderFilteredTable(filteredData);
        });
        function renderFilteredTable(data) {
            const tableBody = document.getElementById('menuTableBody');
            tableBody.innerHTML = '';

            data.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm font-medium text-gray-900">${item.name}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-gray-500">${item.category}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-gray-900">$${item.price.toFixed(2)}</div>
                    </td>
                    <td class="px-6 py-4">
                        <div class="text-sm text-gray-500">${item.description}</div>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                        <button onclick="editItem(${item.id})" class="text-primary hover:text-primary/80 mr-3">Edit</button>
                        <button onclick="deleteItem(${item.id})" class="text-red-600 hover:text-red-900">Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });

            document.getElementById('itemCount').textContent = data.length;
        }

        function editItem(id) {
            const item = mockData.find(item => item.id === id);
            if (item) {
                document.getElementById('name').value = item.name;
                document.getElementById('price').value = item.price;
                document.getElementById('description').value = item.description;
                document.getElementById('category').value = item.category;
                mockData = mockData.filter(item => item.id !== id);
                renderTable();
                showToast('Item ready for editing');
            }
        }

        function deleteItem(id) {
            if (confirm('Are you sure you want to delete this item?')) {
                mockData = mockData.filter(item => item.id !== id);
                renderTable();
                showToast('Item deleted successfully');
            }
        }

        renderTable();
    </script>
</body>
</asp:Content>
