<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Jewelry Palace</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="fontawesomepro/css/all.min.css">
    <link rel="icon" href="./logo/logo7.png">
    <script>
        function handleSortChange(value) {
            if (value === 'price') {
                window.location.href = 'earring.jsp?sort=price';
            } else {
                window.location.href = 'earring.jsp';
            }
        }

        function addToWishlist(productId, productName, productCategory, productImage, productPrice) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "AddToWishlistServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        const heartIcon = document.getElementById(`heart-icon-${productId}`);
                        heartIcon.classList.toggle("fas"); 
                        heartIcon.classList.toggle("far"); 
                    } else {
                        alert("Error adding to wishlist: " + xhr.responseText); 
                    }
                }
            };

            const params = "id=" + productId + 
                           "&name=" + encodeURIComponent(productName) + 
                           "&category=" + encodeURIComponent(productCategory) + 
                           "&image=" + encodeURIComponent(productImage) + 
                           "&price=" + productPrice;

            xhr.send(params);
        }
    </script>
</head>
<body>
    
    <!-- nav bar & loginForm -->
    <div id="nav"></div>
    <section class="px-10 py-10 pb-5">
    
        <div class="text-normal flex justify-between font-semibold pt-20">
            <div>
                <a href="index.jsp" class="">Home &nbsp;/&nbsp;</a>
                <span id="textForPfMwPh">Earrings</span>
                <h1 class="pl-16 font-mono mt-5 text-5xl tracking-tighter">EARRINGS</h1>
                <p class="pl-16 font-mono text-xl">Elevate your jewelry ensemble with silver and gold earrings.</p>
            </div>
            <div class="relative pt-24 pr-16 z-10">
                <button class=" text-sm bg-trasparent text-slate-950 p-2 rounded-md flex items-center" onclick="document.getElementById('dropdown').classList.toggle('hidden')">
                    <span>Sort By</span>
                    <i class="fas fa-chevron-down ml-2"></i>
                </button>
                <div id="dropdown" class=" text-sm absolute top-full w-40 right-16 mt-2 bg-white border border-slate-300 rounded-sm shadow-lg hidden">
                    <ul class="list-none p-2">
                        <li>
                            <a href="javascript:void(0);" onclick="handleSortChange('default');" class="block px-4 py-2 text-slate-950 hover:text-slate-500">Default</a>
                        </li>
                        <li>
                            <a href="javascript:void(0);" onclick="handleSortChange('price');" class="block px-4 py-2 text-slate-950 hover:text-slate-500">Sorted by Price</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="flex flex-wrap gap-16 px-16 py-10">
        <%
            String url = "jdbc:mysql://localhost:3306/jewelrypalace";
            String user = "root";
            String password = "root";
            String sql;
            
            String sort = request.getParameter("sort");
            String productType = "earring"; 
            
            if ("price".equals(sort)) {
                sql = "SELECT id, name, category, image, price FROM product WHERE category = ? ORDER BY price ASC"; 
            } else {
                sql = "SELECT id, name, category, image, price FROM product WHERE category = ?"; 
            }
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     PreparedStatement pstmt = conn.prepareStatement(sql)) {

                    pstmt.setString(1, productType); 
                    try (ResultSet rs = pstmt.executeQuery()) {

                        while (rs.next()) {
                            int productId = rs.getInt("id");
                            String name = rs.getString("name");
                            String imagePath = rs.getString("image");
                            double price = rs.getDouble("price");
                            String category = rs.getString("category");
        %>
                            <div class="w-80 h-96 relative mb-7 inline-block">
                                <div>
                                    <i id="heart-icon-<%= productId %>" class="heart-icon fa-lg far fa-heart cursor-pointer absolute top-3 right-2 text-white" 
                                       onclick="addToWishlist(<%= productId %>, '<%= name.replace("'", "\\'") %>', '<%= category.replace("'", "\\'") %>', '<%= imagePath.replace("'", "\\'") %>', <%= price %>)"></i>
                                    <img class="w-80 h-96 object-cover" src="./product_image/<%= imagePath %>" alt="<%= name %>">
                                </div>
                                <div class="font-mono font-medium">
                                    <p class="font-bold pt-1"><a href="itemdetails.html"><%= name %></a></p>
                                    <p><%= price %> kyats</p>
                                </div>
                            </div>
        <%
                        }
                    }
                }
            } catch (ClassNotFoundException e) {
                out.println("JDBC Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                out.println("Database error occurred: " + e.getMessage());
            }
        %>
        </div>
    </section>
    
    <!-- footer section  -->
    <div id="footer"></div>
  
    <!-- elf sight  -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
    
</body>
<script src="navi.js"></script>
</html>
