<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.*" %>
<%@ page import="com.google.gson.JsonArray, com.google.gson.JsonObject" %>
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
    <div class="flex flex-col">
    
        <div class="w-full bg-gray-800 text-white fixed p-3">
            <ul class=" flex justify-center items-center space-x-4">
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('dashboard')">Dashboard</a></li>
				<li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('productManagement')">Product Management</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('userList')">Users</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('report')">Reports</a></li>
                <li><a href="#" class="block py-2 px-4 hover:bg-gray-700 rounded" onclick="showContainer('setting')">Settings</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class=" p-10 pt-24 ">
        
       		<!-- Dashboard Content -->
			<%
			    // Database connection details
			    String jdbcUrl = "jdbc:mysql://localhost:3306/jewelrypalace"; // Update with your DB URL
			    String dbUser = "root"; // Update with your DB username
			    String dbPassword = "root"; // Update with your DB password
			
			    Connection connection = null;
			    PreparedStatement pstmt = null;
			    ResultSet productCountResultSet = null;
			    ResultSet totalSalesResultSet = null;
			    ResultSet userCountResultSet = null;
			    ResultSet recentActivitiesResultSet = null;
			
			    Integer totalProducts = 0;
			    Double totalSales = 0.0;
			    Integer totalUsers = 0;
			
			    List<Map<String, String>> recentActivities = new ArrayList<>(); // List to hold recent activities
			
			    try {
			    	Class.forName("com.mysql.cj.jdbc.Driver");
			    	// Establish a connection to the database
			        connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

			        // Query to get total products
			        pstmt = connection.prepareStatement("SELECT COUNT(*) AS total FROM product");
			        productCountResultSet = pstmt.executeQuery();
			        if (productCountResultSet.next()) {
			            totalProducts = productCountResultSet.getInt("total");
			        }
			        productCountResultSet.close(); // Close the result set

			        // Query to get total sales
			        pstmt = connection.prepareStatement("SELECT SUM(total_cost) AS totalSales FROM total_cost");
			        totalSalesResultSet = pstmt.executeQuery();
			        if (totalSalesResultSet.next()) {
			            totalSales = totalSalesResultSet.getDouble("totalSales");
			        }
			        totalSalesResultSet.close(); // Close the result set

			        // Query to get total users
			        pstmt = connection.prepareStatement("SELECT COUNT(*) AS total FROM users");
			        userCountResultSet = pstmt.executeQuery();
			        if (userCountResultSet.next()) {
			            totalUsers = userCountResultSet.getInt("total");
			        }

			     // Query to fetch recent product additions
			        pstmt = connection.prepareStatement("SELECT name, added_time FROM product ORDER BY added_time DESC LIMIT 5");
			        recentActivitiesResultSet = pstmt.executeQuery();
			        while (recentActivitiesResultSet.next()) {
			            String productName = recentActivitiesResultSet.getString("name");

			            Map<String, String> activity = new HashMap<>();
			            activity.put("message", "New product \"" + productName + "\" added.");
			            activity.put("time", recentActivitiesResultSet.getTimestamp("added_time").toString());

			            recentActivities.add(activity);

			        }
			        
			        // recentActivitiesResultSet.close();

			        // Query to fetch recent user logins (assuming users table exists in your DB)
			        pstmt = connection.prepareStatement("SELECT name, creation_time FROM users ORDER BY creation_time DESC LIMIT 5");
			        recentActivitiesResultSet = pstmt.executeQuery();
			        while (recentActivitiesResultSet.next()) {
			            Map<String, String> activity = new HashMap<>();
			            activity.put("message", "User \"" + recentActivitiesResultSet.getString("name") + "\" signed in.");
			            activity.put("time", recentActivitiesResultSet.getTimestamp("creation_time").toString());
			            recentActivities.add(activity);
			        }
			        
			     	// Query to fetch recent sold-out products (quantity = 0)
			        pstmt = connection.prepareStatement("SELECT name, sold_out_time FROM product WHERE quantity = 0 ORDER BY sold_out_time DESC LIMIT 5");
			        recentActivitiesResultSet = pstmt.executeQuery();

			        while (recentActivitiesResultSet.next()) {
			            String productName = recentActivitiesResultSet.getString("name");
			            Timestamp soldOutTime = recentActivitiesResultSet.getTimestamp("sold_out_time");

			            if (productName != null && soldOutTime != null) { // Check if values are not null
			                Map<String, String> activity = new HashMap<>();
			                activity.put("message", "Product \"" + productName + "\" of the quantity is no left.");
			                activity.put("time", soldOutTime.toString());
			                recentActivities.add(activity);
			            } else {
			                // Debugging output
			                System.out.println("Null value found for product or sold_out_time.");
			            }
			        }
			        
			     	// Query to fetch recent delete activities
			        pstmt = connection.prepareStatement("SELECT product_name, action_time FROM activity_log WHERE action = 'deleted' ORDER BY action_time DESC LIMIT 2");
			        recentActivitiesResultSet = pstmt.executeQuery();
			        while (recentActivitiesResultSet.next()) {
			            String productName = recentActivitiesResultSet.getString("product_name");
			            Timestamp actionTime = recentActivitiesResultSet.getTimestamp("action_time");

			            if (productName != null && actionTime != null) { // Check if values are not null
			                Map<String, String> activity = new HashMap<>();
			                activity.put("message", "Product \"" + productName + "\" has been deleted.");
			                activity.put("time", actionTime.toString());
			                recentActivities.add(activity);
			            }
			        }
			        
			        pstmt = connection.prepareStatement(
			        	    "SELECT name, (10 - quantity) AS sold_quantity, soldout_quantity_time " +
			        	    "FROM product " +
			        	    "WHERE quantity < 10 AND soldout_quantity_time IS NOT NULL " +
			        	    "ORDER BY soldout_quantity_time DESC " +
			        	    "LIMIT 5"
			        	);
			        	recentActivitiesResultSet = pstmt.executeQuery();

			        	while (recentActivitiesResultSet.next()) {
			        	    String productName = recentActivitiesResultSet.getString("name");
			        	    int soldQuantity = recentActivitiesResultSet.getInt("sold_quantity");
			        	    Timestamp soldOutQuantityTime = recentActivitiesResultSet.getTimestamp("soldout_quantity_time");

			        	    if (productName != null && soldOutQuantityTime != null) {
			        	        Map<String, String> activity = new HashMap<>();
			        	        activity.put("message", "Product \"" + productName + "\" has less than 10 items remaining. Total sold quantity: " + soldQuantity + ".");
			        	        activity.put("time", soldOutQuantityTime.toString());
			        	        recentActivities.add(activity);
			        	    }
			        	}
			        
			        recentActivitiesResultSet.close(); // Close the result set
			                		
			    } catch (SQLException e) {
			        e.printStackTrace();
			    } finally {
			        // Clean up resources
			        try {
			            if (recentActivitiesResultSet != null) recentActivitiesResultSet.close(); // Close recent activities result set
			            if (userCountResultSet != null) userCountResultSet.close();
			            if (totalSalesResultSet != null) totalSalesResultSet.close();
			            if (productCountResultSet != null) productCountResultSet.close();
			            if (pstmt != null) pstmt.close();
			            if (connection != null) connection.close();
			        } catch (SQLException e) {
			            e.printStackTrace();
			        }
			    }

			    // Sort recent activities by timestamp (most recent first)
			    Collections.sort(recentActivities, new Comparator<Map<String, String>>() {
			        @Override
			        public int compare(Map<String, String> activity1, Map<String, String> activity2) {
			            return activity2.get("time").compareTo(activity1.get("time")); // Sort in descending order
			        }
			    });
			%>
			
			<!-- Dashboard Content -->
			<section id="dashboard" class="bg-white p-6 rounded-lg shadow-lg">
			    <h1 class="text-3xl font-bold mb-6">Welcome to the Admin Dashboard</h1>
			
			    <!-- Key Metrics Section -->
			    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
			        <!-- Total Products -->
			        <div class="p-4 bg-blue-500 text-white rounded-lg shadow-md">
			            <h2 class="text-2xl font-semibold mb-2">Total Products</h2>
			            <p class="text-4xl font-bold"><%= totalProducts %></p>
			        </div>
			
			        <!-- Total Sales -->
			        <div class="p-4 bg-green-500 text-white rounded-lg shadow-md">
			            <h2 class="text-2xl font-semibold mb-2">Total Sales</h2>
			            <p class="text-4xl font-bold">$<%= String.format("%.2f", totalSales) %></p>
			        </div>
			
			        <!-- Total Users -->
			        <div class="p-4 bg-yellow-500 text-white rounded-lg shadow-md">
			            <h2 class="text-2xl font-semibold mb-2">Total Users</h2>
			            <p class="text-4xl font-bold"><%= totalUsers %></p>
			        </div>
			    </div>
				<div class="text-3xl font-bold mb-5">Recent Activities</div>
			    <!-- Recent Activities Section -->
				<div class="mb-6 max-h-96 overflow-y-auto border border-gray-200 rounded-lg">
				    <div class="flex flex-col space-y-4 p-4">
				        <%
				            if (!recentActivities.isEmpty()) {
				                for (Map<String, String> activity : recentActivities) {
				        %>
				        <div class="p-4 bg-white rounded-lg shadow-md">
				            <div class="flex justify-between items-center mb-2">
				                <span class="text-sm text-gray-500"><%= activity.get("time") %></span>
				            </div>
				            <p class="text-lg font-semibold text-gray-800"><%= activity.get("message") %></p>
				        </div>
				        <%
				                }
				            } else {
				        %>
				        <div class="p-4 bg-white rounded-lg shadow-md">
				            <p class="text-lg text-gray-800">No recent activities found.</p>
				        </div>
				        <%
				            }
				        %>
				    </div>
				</div>

			</section>
            
            <!-- Product Management Container -->
            <section id="productManagement" class="hidden flex flex-col items-center justify-center ">
            	
            	<div class="flex flex-col md:flex-row items-start md:items-stretch space-y-6 md:space-y-0 md:space-x-6 mb-16">
    
				    <!-- Add Product Container -->
				    <div id="addProduct" class="flex-1 bg-white p-6 rounded-lg shadow-lg min-h-[400px]">
				        <h1 class="text-2xl font-bold mb-4">Add New Product</h1>
				        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
				            <div class="mb-4 flex items-center">
				                <label for="name" class="text-sm font-medium w-32">Product Name:</label>
				                <input type="text" name="name" id="name" placeholder="Don't put the existing name!" class="flex-1 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400 text-sm" required>
				            </div>
				            <div class="mb-4 flex items-center">
				                <label for="product_type" class="text-sm font-medium w-32">Category :</label>
				                <select name="product_type" id="product_type" class="flex-1 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400 text-sm" required>
				                    <option value="earring">Earring</option>
				                    <option value="necklace">Necklace</option>
				                    <option value="ring">Ring</option>
				                    <option value="bracelet">Bracelet</option>
				                </select>
				            </div>
				            <div class="mb-4 flex items-center">
				                <label for="price" class="text-sm font-medium w-32">Price:</label>
				                <input type="text" name="price" id="price" class="flex-1 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400 text-sm" required>
				            </div>
				            <div class="mb-4 flex items-center">
				                <label for="image" class="text-sm font-medium w-32">Image:</label>
				                <div id="drop-zone" class="flex-1 p-3 border-dashed border-2 border-gray-300 rounded-md flex items-center justify-center cursor-pointer bg-gray-50 hover:bg-gray-100 transition text-sm">
				                    <span class="text-gray-400">Drag & drop an image here or click to select</span>
				                </div>
				                <input type="file" name="image" id="image" class="hidden" accept="image/*" required>
				            </div>
				            <button type="submit" class="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600 transition text-sm">Add Product</button>
				        </form>
				    </div>
				
				    <!-- Delete Product Container -->
				    <div id="deleteProduct" class="flex-1 bg-white p-6 rounded-lg shadow-lg min-h-[400px]">
				        <h1 class="text-2xl font-bold mb-4">Delete Product</h1>
				        <form action="DeleteProductServlet" method="post">
				            <div class="mb-4 flex items-center">
				                <label for="productName" class="text-sm font-medium w-32">Product Name:</label>
				                <input type="text" name="productName" id="productName" placeholder="Enter the product name to delete" class="flex-1 p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-red-400 text-sm" required>
				            </div>
				            <button type="submit" class="w-full bg-red-500 text-white py-2 rounded-md hover:bg-red-600 transition text-sm">Delete Product</button>
				        </form>
				    </div>
				    
				</div>

                
                <!-- Edit & List Product Container -->
				<div id="categories" class="">
				    <h1 class="text-4xl font-bold mb-4">Product List</h1>
				    <table class="min-w-full bg-white border border-gray-200">
				        <thead>
				            <tr class=" text-left text-xl font-medium text-gray-700 border-b">
				                <th class="px-4 py-2">ID</th>
				                <th class="px-4 py-2">Name</th>
				                <th class="px-4 py-2">Category</th>
				                <th class="px-4 py-2">Price</th>
				                <th class="px-4 py-2">Quantity</th>
				                <th class="px-4 py-2">Actions</th>
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
				</div>
			
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
							<th class="p-2 border-b">Creation Time</th>
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
                                rs = ps.executeQuery();
                                while (rs.next()) {
                                    userListHtml.append("<tr>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getInt("id")).append("</td>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getString("name")).append("</td>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getString("email")).append("</td>");
                                    userListHtml.append("<td class='p-2 border-b'>").append(rs.getString("creation_time")).append("</td>");
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
            
            <!-- Report Container -->
            <section id="dashboard" class="hidden" >
                <h1 class="text-4xl font-bold mb-4">Report</h1>
                <!-- Report content goes here -->
            </section>
            
        </div>
        
    </div>

    <script src="navi.js"></script>
    
    <script>
    
    function showContainer(containerId) {
        var containers = document.querySelectorAll('section');
        containers.forEach(function(container) {
            container.style.display = 'none';
        });

        document.getElementById(containerId).style.display = 'block';
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
