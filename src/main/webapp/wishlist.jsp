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
</head>
<body>
    
    <!-- nav bar & loginForm -->
    <div id="nav"></div>
    
    <section class="px-10 py-10 pb-5">
        <div class="text-normal flex justify-between font-semibold pt-20">
            <div>
                <a href="index.jsp" class="">Home &nbsp;/&nbsp;</a>
                <span id="textForPfMwPh">Wishlists</span>
                <h1 class="pl-16 font-mono mt-5 text-5xl tracking-tighter">WISHLISTS</h1>
                <p class="pl-16 font-mono text-xl">Elevate your jewelry ensemble with silver and gold stuff.</p>
            </div>
        </div>

        <!-- Wishlist Items -->
        <div class="mt-10">
            <div id="wishlistItems" class="flex flex-wrap gap-16 px-16 py-10">
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

                        String wishlistData = request.getParameter("wishlistItems");

                        if (wishlistData != null && !wishlistData.isEmpty()) {
                            String[] wishlistArray = wishlistData.split(",");

                            for (String itemName : wishlistArray) {
                                String sql = "SELECT * FROM product WHERE name = '" + itemName + "'";
                                rs = stmt.executeQuery(sql);

                                if (rs.next()) {
                                    String productName = rs.getString("name");
                                    String productImage = rs.getString("image");
                                    String productPrice = rs.getString("price");
                %>
                                    <div class="w-80 h-96 relative mb-7 inline-block cursor-pointer" data-product="<%= productName %>" onclick="openModal('<%= productName %>', '<%= productImage %>', '<%= productPrice %> kyats')">
                                        <div>
                                            <img class="w-80 h-96 object-cover" src="./product_image/<%= productImage %>" alt="<%= productName %>">
                                        </div>
                                        <div class="font-mono font-medium">
                                            <p class="font-bold pt-1"><%= productName %></p>
                                            <p><%= productPrice %> kyats</p>
                                        </div>
                                        <!-- Move the trash icon to the right side -->
                                        <button class="removeItem absolute top-2 right-2" data-product="<%= productName %>">
                                            <i class="fas fa-trash-alt text-red-600"></i>
                                        </button>
                                    </div>
                <%
                                }
                            }
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
                            These exquisite stuff are crafted with precision and elegance. Made from high-quality materials, they feature a stunning design that adds a touch of sophistication to any outfit. Perfect for special occasions or as a luxurious gift.
                        </p>
                    </div>

                    <div class="flex justify-between ">
                        <button id="addToCart" class="w-full ml-2 px-4 py-2 bg-slate-500 text-white font-semibold rounded-sm shadow hover:bg-slate-400 transition duration-200">
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
    
    <script>
        // Pass wishlist items to JSP
        window.onload = function() {
            let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];
            let wishlistItems = wishlist.map(item => item.name).join(",");

            // Check if the current URL already contains the wishlistItems parameter
            let urlParams = new URLSearchParams(window.location.search);
            if (!urlParams.has('wishlistItems') && wishlistItems) {
                // If the parameter is not present, redirect with the wishlist items
                window.location.href = "wishlist.jsp?wishlistItems=" + encodeURIComponent(wishlistItems);
            }

            // Add event listener for removing items
            document.querySelectorAll('.removeItem').forEach(button => {
                button.addEventListener('click', function(event) {
                    event.stopPropagation(); // Prevent triggering the modal

                    let productName = this.getAttribute('data-product');

                    // Remove the item from local storage
                    wishlist = wishlist.filter(item => item.name !== productName);
                    localStorage.setItem("wishlist", JSON.stringify(wishlist));

                    // Reload the page with the updated wishlist items
                    let updatedWishlistItems = wishlist.map(item => item.name).join(",");
                    window.location.href = "wishlist.jsp?wishlistItems=" + encodeURIComponent(updatedWishlistItems);
                });
            });
        };

        function openModal(productName, productImage, productPrice) {
        	document.getElementById('modalImage').src = './product_image/' + productImage;
            document.getElementById('modalProductName').textContent = productName;
            document.getElementById('modalProductPrice').textContent = productPrice;

            // Assign the addToCart function to the button's onclick event
            document.getElementById('addToCart').onclick = function() {
                addToCart(productName, productImage, productPrice);
            };

            document.getElementById('productModal').classList.remove('hidden');
        }

        function addToCart(productName, productImage, productPrice) {
            let cart = JSON.parse(localStorage.getItem("cart")) || [];

            const exists = cart.find(item => item.name === productName);
            if (!exists) {
                cart.push({
                    name: productName,
                    image: productImage,
                    price: productPrice
                });
                localStorage.setItem("cart", JSON.stringify(cart));
                alert(productName + " has been added to your cart!");
            } else {
                alert(productName + " is already in your cart.");
            }
        }

        // Close modal when clicking on the close icon
        document.getElementById('closeModal').onclick = function() {
            document.getElementById('productModal').classList.add('hidden');
        };


        // Close modal when clicking on the close icon
        document.getElementById('closeModal').onclick = function() {
            document.getElementById('productModal').classList.add('hidden');
        };

    </script>

</body>
</html>
