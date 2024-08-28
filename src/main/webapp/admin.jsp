<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Panel</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="fontawesomepro/css/all.min.css">
<link rel="icon" href="./logo/logo7.png">
</head>
<body class="bg-gray-100">

    <!-- Admin Panel Sidebar -->
    <div class="flex">
    
        <div class="w-1/5 bg-gray-800 text-white h-screen fixed p-4">
            <div class="text-2xl font-bold mb-6">Admin Dashboard</div>
            <ul class="space-y-4">
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('dashboard')">Dashboard</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('userList')">Users</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('categories')">Products</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('addProduct')">Add Products</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('deleteProduct')">Delete Products</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded">Reports</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded">Settings</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="w-4/5 p-10 ml-80">
        
       		<!-- Dashboard Content (Optional) -->
            <section id="dashboard">
                <h1 class="text-4xl font-bold mb-4">Welcome to the Admin Dashboard</h1>
                <!-- Dashboard content goes here -->
            </section>
            
            <!-- Add Product Container -->
            <section id="addProduct" class="hidden">
                <h1 class="text-4xl font-bold mb-4">Add New Product</h1>
                <form action="AddProductServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-4">
                        <label for="name" class="block text-lg font-semibold">Product Name:</label>
                        <input type="text" name="name" id="name" placeholder="Don't put the existing name!" class="w-full p-2 border rounded-sm" required>
                    </div>
                    <div class="mb-4">
                        <label for="product_type" class="block text-lg font-semibold">Category :</label>
                        <select name="product_type" id="product_type" class="w-full p-2 border rounded-sm" required>
                            <option value="earring">Earring</option>
                            <option value="necklace">Necklace</option>
                            <option value="ring">Ring</option>
                            <option value="bracelet">Bracelet</option>
                        </select>
                    </div>
                    <div class="mb-4">
                        <label for="price" class="block text-lg font-semibold">Price:</label>
                        <input type="text" name="price" id="price" class="w-full p-2 border rounded-sm" required>
                    </div>
                    <div class="mb-4">
                        <label for="image" class="block text-lg font-semibold">Image:</label>
                        <div id="drop-zone" class="w-full p-2 border-dashed border-2 border-gray-300 rounded-sm flex items-center justify-center cursor-pointer bg-gray-50">
                            <span class="text-gray-400">Drag & drop an image here or click to select</span>
                        </div>
                        <input type="file" name="image" id="image" class="hidden" accept="image/*" required>
                    </div>
                    <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Add Product</button>
                </form>
            </section>

            <!-- Delete Product Container -->
            <section id="deleteProduct" class="hidden">
                <h1 class="text-4xl font-bold mb-4">Delete Product</h1>
                <form action="DeleteProductServlet" method="post">
                    <div class="mb-4">
                        <label for="productName" class="block text-lg font-semibold">Product Name:</label>
                        <input type="text" name="productName" id="productName" placeholder="Enter the product name to delete" class="w-full p-2 border rounded-sm" required>
                    </div>
                    <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded">Delete Product</button>
                </form>
            </section>
            
           <!-- User List Container -->
            <section id="userList" class="hidden">
                <h1 class="text-4xl font-bold mb-4">User List</h1>
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr>
                            <th class="p-2 border-b">ID</th>
                            <th class="p-2 border-b">Name</th>
                            <th class="p-2 border-b">Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            StringBuilder userListHtml = new StringBuilder();
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/jewelrypalace", "root", "root");
                                String query = "SELECT * FROM users";
                                PreparedStatement ps = con.prepareStatement(query);
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                                    userListHtml.append("<tr>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getInt("id")).append("</td>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getString("name")).append("</td>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getString("email")).append("</td>");
                                    userListHtml.append("</tr>");
                                }
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <%= userListHtml.length() > 0 ? userListHtml.toString() : "<tr><td colspan='3' class='p-2 border-b text-center'>No users found</td></tr>" %>
                    </tbody>
                </table>
            </section>
            
            <!-- Categories Container -->
			<section id="categories" class="hidden">
    <h1 class="text-4xl font-bold mb-4">Categories</h1>
    <table class="min-w-full bg-white border border-gray-200">
        <thead>
            <tr>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">ID</th>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">Name</th>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">Category</th>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">Price</th>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">Quantity</th>
                <th class="px-4 py-2 text-left text-sm font-medium text-gray-700 border-b">Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jewelrypalace", "root", "root");

                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT id, name, category, price, quantity FROM product");

                    while (rs.next()) {
                        String productId = rs.getString("id");
            %>
                <tr id="row-<%= productId %>">
                    <td class="px-4 py-2 border-b"><%= productId %></td>
                    <td class="px-4 py-2 border-b">
                        <span id="name-<%= productId %>"><%= rs.getString("name") %></span>
                        <input type="text" id="edit-name-<%= productId %>" value="<%= rs.getString("name") %>" class="hidden border px-2 py-1">
                    </td>
                    <td class="px-4 py-2 border-b">
                        <span id="category-<%= productId %>"><%= rs.getString("category") %></span>
                        <input type="text" id="edit-category-<%= productId %>" value="<%= rs.getString("category") %>" class="hidden border px-2 py-1">
                    </td>
                    <td class="px-4 py-2 border-b">
                        <span id="price-<%= productId %>"><%= rs.getDouble("price") %></span>
                        <input type="number" step="0.01" id="edit-price-<%= productId %>" value="<%= rs.getDouble("price") %>" class="hidden border px-2 py-1">
                    </td>
                    <td class="px-4 py-2 border-b">
                        <span id="quantity-<%= productId %>"><%= rs.getInt("quantity") %></span>
                        <input type="number" id="edit-quantity-<%= productId %>" value="<%= rs.getInt("quantity") %>" class="hidden border px-2 py-1">
                    </td>
                    <td class="px-4 py-2 border-b">
                        <button onclick="editProduct('<%= productId %>')" class="bg-blue-500 text-white px-2 py-1 rounded">Edit</button>
                        <button onclick="saveProduct('<%= productId %>')" id="save-<%= productId %>" class="hidden bg-green-500 text-white px-2 py-1 rounded">Save</button>
                    </td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='6' class='px-4 py-2 text-center border-b'>Error: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</section>

        </div>
        
    </div>

    <script src="navi.js"></script>
    
    <script>
        function showContainer(containerId) {

        	document.getElementById('addProduct').classList.add('hidden');
            document.getElementById('deleteProduct').classList.add('hidden');
            document.getElementById('dashboard').classList.add('hidden');
            document.getElementById('userList').classList.add('hidden');
            document.getElementById('categories').classList.add('hidden');
            
            document.getElementById(containerId).classList.remove('hidden');
        }

        const dropZone = document.getElementById('drop-zone');
        const imageInput = document.getElementById('image');

        dropZone.addEventListener('click', () => {
            imageInput.click();
        });

        dropZone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropZone.classList.add('border-blue-500');
        });

        dropZone.addEventListener('dragleave', () => {
            dropZone.classList.remove('border-blue-500');
        });

        dropZone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropZone.classList.remove('border-blue-500');
            if (e.dataTransfer.files.length) {
                imageInput.files = e.dataTransfer.files;
                updateDropZone();
            }
        });

        imageInput.addEventListener('change', updateDropZone);

        function updateDropZone() {
            dropZone.innerHTML = ''; 
            if (imageInput.files.length) {
                const file = imageInput.files[0];
                const reader = new FileReader();
                reader.onload = (e) => {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.alt = 'Selected Image';
                    img.classList.add('w-32', 'h-32', 'object-cover', 'rounded');
                    dropZone.appendChild(img); 
                };
                reader.readAsDataURL(file);
            } else {
                const placeholder = document.createElement('span');
                placeholder.classList.add('text-gray-400');
                placeholder.textContent = 'Drag & drop an image here or click to select';
                dropZone.appendChild(placeholder);
            }
        }
        
        function editProduct(productId) {
            document.getElementById("name-" + productId).classList.add("hidden");
            document.getElementById("edit-name-" + productId).classList.remove("hidden");
            document.getElementById("category-" + productId).classList.add("hidden");
            document.getElementById("edit-category-" + productId).classList.remove("hidden");
            document.getElementById("price-" + productId).classList.add("hidden");
            document.getElementById("edit-price-" + productId).classList.remove("hidden");
            document.getElementById("quantity-" + productId).classList.add("hidden");
            document.getElementById("edit-quantity-" + productId).classList.remove("hidden");
            
            document.getElementById("save-" + productId).classList.remove("hidden");
        }

        function saveProduct(productId) {
            const name = document.getElementById("edit-name-" + productId).value;
            const category = document.getElementById("edit-category-" + productId).value;
            const price = document.getElementById("edit-price-" + productId).value;
            const quantity = document.getElementById("edit-quantity-" + productId).value;

            // Send an AJAX request to the servlet to update the product
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "UpdateProductServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onload = function () {
                if (xhr.status === 200) {
                    // Update UI with new values
                    document.getElementById("name-" + productId).innerText = name;
                    document.getElementById("category-" + productId).innerText = category;
                    document.getElementById("price-" + productId).innerText = price;
                    document.getElementById("quantity-" + productId).innerText = quantity;

                    // Hide the edit inputs
                    document.getElementById("edit-name-" + productId).classList.add("hidden");
                    document.getElementById("edit-category-" + productId).classList.add("hidden");
                    document.getElementById("edit-price-" + productId).classList.add("hidden");
                    document.getElementById("edit-quantity-" + productId).classList.add("hidden");
                    
                    // Hide the save button
                    document.getElementById("save-" + productId).classList.add("hidden");
                }
            };
            xhr.send("id=" + productId + "&name=" + encodeURIComponent(name) + "&category=" + encodeURIComponent(category) + "&price=" + price + "&quantity=" + quantity);
        }
    </script>
</body>
</html>
