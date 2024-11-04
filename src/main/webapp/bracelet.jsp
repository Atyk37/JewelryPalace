<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
boolean isLoggedInServer = session.getAttribute("username") != null;
%>  
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Jewelry Palace</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="fontawesomepro/css/all.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js" defer></script>
    <link rel="icon" href="./logo/logo7.png">
    <script>
        function handleSortChange(value) {
            window.location.href = 'bracelet.jsp?sort=' + value;
        }
    </script>
</head>
<body class="">
    
    <!-- nav bar & loginForm -->
    <div id="nav"></div>
    <section class="px-10 py-10 pb-5">
    
    <div class="text-normal flex justify-between font-semibold pt-20">
        <div>
            <a href="index.jsp" class="">Home &nbsp;/&nbsp;</a>
            <span id="textForPfMwPh">Bracelets</span>
            <h1 class="pl-16 font-mono mt-5 text-5xl tracking-tighter">BRACELETS</h1>
            <p class="pl-16 font-mono text-xl">Elevate your jewelry ensemble with silver and gold bracelets.</p>
        </div>
        <div class="relative pt-24 pr-16 z-10">
            <button class="text-sm bg-transparent text-slate-950 p-2 rounded-md flex items-center" onclick="document.getElementById('dropdown').classList.toggle('hidden')">
                <span>Sort By</span>
                <i class="fas fa-chevron-down ml-2"></i>
            </button>
            <div id="dropdown" class="text-sm absolute top-full w-40 right-16 mt-2 bg-white border border-slate-300 rounded-sm shadow-lg hidden">
                <ul class="list-none p-2">
			        <li>
			            <a href="javascript:void(0);" onclick="handleSortChange('default');" class="block px-4 py-2 text-slate-950 hover:text-slate-500">Default</a>
			        </li>
			        <li>
			            <a href="javascript:void(0);" onclick="handleSortChange('low');" class="block px-4 py-2 text-slate-950 hover:text-slate-500">Low to High</a>
			        </li>
			        <li>
			            <a href="javascript:void(0);" onclick="handleSortChange('high');" class="block px-4 py-2 text-slate-950 hover:text-slate-500">High to Low</a>
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
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sort = request.getParameter("sort");
        String productType = "bracelet"; 
        String sql = "SELECT id, name, category, image, price, quantity FROM product WHERE category = ?";

        if ("low".equals(sort)) {
            sql += " ORDER BY price ASC"; 
        } else if ("high".equals(sort)) {
            sql += " ORDER BY price DESC"; 
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, productType); // Set category parameter

            rs = pstmt.executeQuery();

            while (rs.next()) {
                String productId = rs.getString("name");
                String productImage = rs.getString("image");
                String productPrice = rs.getString("price");
                int productQuantity = rs.getInt("quantity");

    %>
                <div class="w-80 h-96 relative mb-7 inline-block" onclick="openModal('<%= productId %>', '<%= productImage %>', '<%= productPrice %>', '<%= productQuantity %>')">
                    <div>
                        <img class="w-80 h-96 object-cover" src="./product_image/<%= productImage %>" alt="<%= productId %>">
                    </div>
                    <div class="font-mono font-medium">
                        <p class="font-bold pt-1 cursor-pointer"><%= productId %></p>
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
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
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
                            These exquisite bracelets are crafted with precision and elegance. Made from high-quality materials, they feature a stunning design that adds a touch of sophistication to any outfit. Perfect for special occasions or as a luxurious gift.
                        </p>
                    </div>
					<div id="modalStockStatus" class=" " style="display: inline-block;"></div>
                    <div class="flex justify-between ">
                        <button id="addToWishlist" class="w-full px-4 py-2 bg-slate-500 text-white font-semibold rounded-sm shadow hover:bg-slate-400 transition duration-200">
                            Add to Wishlist
                        </button>
                        <button id="addToCart" class="w-full ml-2 px-4 py-2 bg-slate-500 text-white font-semibold rounded-sm shadow hover:bg-slate-400 transition duration-200">
                            Add to Cart
                        </button>
                    </div>
                    <span id="showMsg" class="text-sm mt-2 "></span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- footer section  -->
    <div id="footer"></div>
  
    <!-- elf sight  -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
    
</body>
<script src="navi.js"></script>

<script>
	//Retrieve the isLoggedIn value from local storage
	const isLoggedInLocalStorage = localStorage.getItem('isLoggedIn') === 'true';
	// Pass the server-side login status to JavaScript
	const isLoggedInServer = <%= isLoggedInServer ? "true" : "false" %> === "true";
	// Combine both server-side and client-side checks
	const isLoggedIn = isLoggedInServer || isLoggedInLocalStorage;
	
	function openModal(productName, productImage, productPrice, productQuantity) {
        document.getElementById("modalProductName").innerText = productName;
        document.getElementById("modalImage").src = "./product_image/" + productImage;
        document.getElementById("modalProductPrice").innerText = productPrice + " kyats";

        const stockStatusElement = document.getElementById("modalStockStatus");
        const stockStatus = productQuantity > 0 ? "INSTOCK" : "Out of Stock";
        stockStatusElement.innerText = stockStatus;

        // Set text color based on stock status
        stockStatusElement.className = productQuantity > 0 ? "text-lg font-semibold mt-2 p-2 text-blue-800" : "text-lg font-semibold mt-2 p-2 text-red-800";

        const modal = document.getElementById("productModal");
        modal.classList.remove("hidden");

        // Clear any previous event listeners before adding new ones
        const addToWishlistBtn = document.getElementById("addToWishlist");
        addToWishlistBtn.onclick = null;
        addToWishlistBtn.onclick = function() {
            if (isLoggedIn) {
                addToWishlist(productName, productImage, productPrice);
            } else {
                alert('Please sign up first.');
            }
        };

        const addToCartBtn = document.getElementById("addToCart");
        const showMsg = document.getElementById("showMsg");

        addToCartBtn.onclick = function() {
            // Clear previous message
            showMsg.innerText = "";
            showMsg.classList.remove("text-green-500", "text-red-500"); // Reset message color

            // Use a switch statement to check conditions
            switch (true) {
                case !isLoggedIn:
                    showMsg.innerText = "Please sign up first.";
                    showMsg.classList.add("text-red-500");
                    break;
                case productQuantity <= 0:
                    showMsg.innerText = "This product is out of stock!";
                    showMsg.classList.add("text-red-500");
                    break;
                default:
                    addToCart(productName, productImage, productPrice); // Add the item to the cart
                    showMsg.innerText = "Item added to cart!";
                    showMsg.classList.add("text-green-500");
                    break;
            }
        };
    }

	function addToWishlist(productName, productImage, productPrice) {
	    const showMsg = document.getElementById("showMsg");

	    // Retrieve existing wishlist from local storage
	    let wishlist = JSON.parse(localStorage.getItem("wishlist")) || [];

	    // Check if the product is already in the wishlist
	    const exists = wishlist.find(item => item.name === productName);
	    if (!exists) {
	        // Add new product to the wishlist
	        wishlist.push({
	            name: productName,
	            image: productImage,
	            price: productPrice
	        });
	        localStorage.setItem("wishlist", JSON.stringify(wishlist));
	        showMsg.innerText = productName + " has been added to your wishlist!";
	        showMsg.style.color = "green";
	    } else {
	        showMsg.innerText = productName + " is already in your wishlist.";
	        showMsg.style.color = "red";
	    }
	}

	function addToCart(productName, productImage, productPrice) {
	    const showMsg = document.getElementById("showMsg");

	    // Retrieve existing cart from local storage
	    let cart = JSON.parse(localStorage.getItem("cart")) || [];

	    // Check if the product is already in the cart
	    const exists = cart.find(item => item.name === productName);
	    if (!exists) {
	        // Add new product to the cart
	        cart.push({
	            name: productName,
	            image: productImage,
	            price: productPrice
	        });
	        localStorage.setItem("cart", JSON.stringify(cart));
	        showMsg.innerText = productName + " has been added to your cart!";
	        showMsg.style.color = "green";
	    } else {
	        showMsg.innerText = productName + " is already in your cart.";
	        showMsg.style.color = "red";
	    }
	}

    document.getElementById("closeModal").onclick = function() {
        const modal = document.getElementById("productModal");
        modal.classList.add("hidden");
    };
</script>
</html>
