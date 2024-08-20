<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Jewelry Palace</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="fontawesomepro/css/all.min.css">
    <link rel="icon" href="./logo/logo7.png">
</head>
<style>
	/* Hide horizontal scrollbar for WebKit browsers (Chrome, Safari) */
        .scrollbar-hidden::-webkit-scrollbar {
            display: none;
        }

        /* Hide scrollbar for Firefox */
        .scrollbar-hidden {
            overflow-x: auto;
            scrollbar-width: none;
        }

        /* Hide scrollbar for IE and Edge */
        .scrollbar-hidden {
            -ms-overflow-style: none;
        }
</style>
<body>
    <!-- nav bar & loginForm -->
    <div id="nav"></div>

    <!-- home page -->
    <div id="home"></div>

    <!-- BEST SELLERS -->  
    <section>
        <div class="py-10 ml-10 tracking-widest rounded-2xl">
            <p class="text-5xl ml-10 font-semibold font-mono">BEST SELLERS</p>
            <div class="flex py-10 px-0 ml-10 bg-slate-50 overflow-x-auto scrollbar-hidden">
                <div id="bestsellers" class="flex whitespace-nowrap space-x-12">
                    <%
                        String url = "jdbc:mysql://localhost:3306/jewelrypalace"; 
                        String user = "root"; 
                        String password = "root"; 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(url, user, password);
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM product WHERE price > 3400000 ORDER BY id LIMIT 20"; 
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String productId = rs.getString("name");
                                String productImage = rs.getString("image");
                                String productPrice = rs.getString("price");
                    %>
                                <div class="w-80 h-96 relative mb-7 inline-block" onclick="openModal('<%= productId %>', './product_image/<%= productImage %>', '<%= productPrice %>')">
                                    <div>
                                        <img class="w-80 h-96 object-cover" src="./product_image/<%= productImage %>" alt="<%= productId %>">
                                    </div>
                                    <div class="font-mono font-medium">
                                        <p class="font-bold pt-1 cursor-pointer " ><%= productId %></p>
                                        <p><%= productPrice %> kyats</p>
                                    </div>
                                </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace(); 
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </section>

<!-- Modal for product details -->
<div id="productModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex justify-center items-center">
    <div class="bg-white rounded-sm shadow-lg p-6 max-w-4xl mx-auto">
        <span id="closeModal" class="close cursor-pointer float-right">
            <i class="fa-lg fa far fa-times"></i>
        </span>
        <div class="flex">
            <img id="modalImage" class="w-80 h-80 object-cover rounded-sm" src="" alt="">
            <div class="ml-6 flex flex-col justify-between">
                <div>
                	<p id="modalProductName" class="text-2xl font-bold text-slate-800"></p>
                	<p id="modalProductPrice" class="text-xl text-slate-600 mt-1"></p>
                	<p class="mt-8 text-slate-700">
                    These exquisite earrings are crafted with precision and elegance. Made from high-quality materials, they feature a stunning design that adds a touch of sophistication to any outfit. Perfect for special occasions or as a luxurious gift.
                </p>
                </div>
               
                <div class="flex justify-between ">
                    <button class="w-full px-4 py-2 bg-slate-500 text-white font-semibold rounded-sm shadow hover:bg-slate-400 transition duration-200">
                        Add to Wishlist
                    </button>
                    <button class="w-full ml-2 px-4 py-2 bg-slate-500 text-white font-semibold rounded-sm shadow hover:bg-slate-400 transition duration-200">
                        Add to Cart
                    </button>
                </div>
                
            </div>
        </div>
    </div>
</div>

    <!-- footer section  -->
    <div id="footer"></div>

    <!-- elf sight  -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
    
    <script src="navi.js"></script>
    <script src="home.js"></script>
    <script>

    function openModal(productName, productImage, productPrice) {
            document.getElementById("modalProductName").innerText = productName;
            document.getElementById("modalImage").src = productImage;
            document.getElementById("modalProductPrice").innerText = productPrice + " kyats";

            const modal = document.getElementById("productModal");
            modal.classList.remove("hidden"); 
        }

        document.getElementById("closeModal").onclick = function() {
            const modal = document.getElementById("productModal");
            modal.classList.add("hidden"); 
        }

        window.onclick = function(event) {
            const modal = document.getElementById("productModal");
            if (event.target === modal) {
                modal.classList.add("hidden"); 
            }
        }
    </script>
</body>
</html>
