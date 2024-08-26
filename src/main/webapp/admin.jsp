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
			
			                    // Display data
			                    while (rs.next()) {
			            %>
			                <tr>
			                	<td class="px-4 py-2 border-b"><%= rs.getString("id") %></td>
			                    <td class="px-4 py-2 border-b"><%= rs.getString("name") %></td>
			                    <td class="px-4 py-2 border-b"><%= rs.getString("category") %></td>
			                    <td class="px-4 py-2 border-b"><%= rs.getDouble("price") %></td>
			                    <td class="px-4 py-2 border-b"><%= rs.getInt("quantity") %></td>
			                </tr>
			            <%
			                    }
			                } catch (Exception e) {
			                    out.println("<tr><td colspan='4' class='px-4 py-2 text-center border-b'>Error: " + e.getMessage() + "</td></tr>");
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
    </script>
</body>
</html>
