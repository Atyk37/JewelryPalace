<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
boolean isLoggedInServer = session.getAttribute("username") != null;
%>  
<%@ page import="Submit.Review" %> <!-- Adjust this line -->
<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/navi.js"></script> -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Jewelry Palace</title>
    <script src="https://cdn.tailwindcss.com"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js" defer></script>
    <link rel="stylesheet" href="fontawesomepro/css/all.min.css">
    <link rel="icon" href="./logo/logo7.png">
</head>
<style>

	:root {
    --gold-color: #D4AF37; /* Gold color for accents and highlights */
    --secondary-color: #4B0082; /* Indigo for backgrounds and headers */
    --neutral-color: #F5F5DC; /* Beige as a neutral base */
	}
	
    /* Additional styles, including scrollbars */
	/* (rest of your existing styles) */

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
    
    /* Custom Scroll bar Style */

	::-webkit-scrollbar {
	  width: 12px;
	}
	
	::-webkit-scrollbar-thumb {
	  background-color: #888;
	  border-radius: 10px;
	}
	
	::-webkit-scrollbar-thumb:hover {
	  background-color: #555;
	}
	
	::-webkit-scrollbar-track {
	  background: #f1f1f1;
	}
	
	/* Firefox scrollbar styles */
	* {
	  scrollbar-width:thin;
	  scrollbar-color: var(--secondary) #f1f1f1;
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
                            String sql = "SELECT * FROM product WHERE price > 3400000 ORDER BY id DESC LIMIT 20"; 
                            rs = stmt.executeQuery(sql);

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
    <div id="productModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex justify-center items-center z-10">
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
    
	<!-- Review Container -->
	<section class="py-10 px-6 bg-gray-100">
	    <h2 class="text-5xl font-semibold font-mono text-center mb-6">What Our Clients Say</h2>
	    <div class="flex justify-between">
	        <div class="flex flex-col justify-center">
	            <div id="reviewsContainer" class=" mb-6 rounded-sm max-w-[800px] overflow-y-auto max-h-64">
	            		 
	                <!-- Existing reviews will be displayed here -->
				    <%
				        @SuppressWarnings("unchecked") // Suppress unchecked cast warning
				        List<Review> reviews = (List<Review>) request.getAttribute("reviews");
				        if (reviews != null) {
				            for (Review review : reviews) {
				    %>
				        <div class="flex flex-col border border-gray-300 max-w-[800px] rounded-sm p-4 mb-4 shadow-sm relative ">
				            <div class=" flex justify-between items-center">
				                <p class="font-semibold text-xl"><%= review.getUserName() %></p>
				                <p class="text-slate-950 font-semibold text-sm "><%= review.getCreatedAt() != null ? review.getCreatedAt().toString() : "No date available" %></p> <!-- Display created_at -->
				            </div>
				            <div class="">
				            	<p class="text-slate-800 text-md"><%= review.getContent() %></p>
				            </div>
				            <div class="absolute bottom-1 right-1">
				                <form action="SubmitReviewServlet" method="POST" style="display:inline;">
				                    <input type="hidden" name="reviewId" value="<%= review.getId() %>">
				                    <button type="submit" name="action" value="delete" class="px-2 py-0 bg-red-500 text-white rounded-sm mb-0">Delete</button>
				                </form>
				            </div>
				        </div>
				    <%
				            }
				        } else {
				    %>
				    	<!-- <p>No reviews available.</p> -->
				    <%
				        }
				    %>
				    
				    
				    <div class="flex flex-col border border-gray-300 max-w-[800px] rounded-sm p-4 mb-4 shadow-sm relative ">
				            <div class=" flex justify-between items-center">
				                <p class="font-semibold text-xl">Aung Thura Kyaw</p>
				                <p class="text-slate-950 font-semibold text-sm ">2024-08-26 20:57:45.0</p> <!-- Display created_at -->
				            </div>
				            <div class="">
				            	<p class="text-slate-800 text-md">
				            		I purchased the diamond pendant for my wife, and she absolutely loves it! The craftsmanship is exquisite, and it sparkles beautifully in any light. Highly recommend this piece for anyone looking to add a touch of elegance to their collection.
				            	</p>
				            </div>
				            <div class="absolute bottom-1 right-1">
				                <form action="SubmitReviewServlet" method="POST" style="display:inline;">
				                    <input type="hidden" name="reviewId" value="">
				                    <button type="submit" name="action" value="delete" class="px-2 py-0 bg-red-500 text-white rounded-sm mb-0">Delete</button>
				                </form>
				            </div>
				        </div>
				        <div class="flex flex-col border border-gray-300 max-w-[800px] rounded-sm p-4 mb-4 shadow-sm relative ">
				            <div class=" flex justify-between items-center">
				                <p class="font-semibold text-xl">Aung Thura Kyaw</p>
				                <p class="text-slate-950 font-semibold text-sm ">2024-08-27 18:24:33.0</p> <!-- Display created_at -->
				            </div>
				            <div class="">
				            	<p class="text-slate-800 text-md">
									"This ring is stunning! The design is unique, and I've received countless compliments every time I wear it. It truly stands out among my other jewelry pieces. The quality is fantastic, and I couldn't be happier with my purchase!"
				            	</p>
				            </div>
				            <div class="absolute bottom-1 right-1">
				                <form action="SubmitReviewServlet" method="POST" style="display:inline;">
				                    <input type="hidden" name="reviewId" value="">
				                    <button type="submit" name="action" value="delete" class="px-2 py-0 bg-red-500 text-white rounded-sm mb-0">Delete</button>
				                </form>
				            </div>
				        </div>
				    
	            </div>
	        </div>
	        
	        <div class="w-full md:w-1/2">
	            <form id="reviewForm" action="SubmitReviewServlet" method="POST" class="flex flex-col">
	                <textarea name="reviewContent" id="reviewText" rows="4" class="border border-slate-300 rounded-sm p-3 mb-4 min-h-48 focus:outline-none focus:ring-2 focus:ring-slate-500" placeholder="Write your review here..." required></textarea>
	                <button type="submit" class="px-4 py-2 bg-slate-600 text-white font-semibold rounded-sm shadow hover:bg-slate-500 transition duration-200">
	                    Submit Review
	                </button>
	            </form>
	        </div>
	    </div>
	</section>
	
	<!-- Gold Price -->
	<section>
		
	</section>

    <!-- footer section  -->
    <div id="footer"></div>

    <!-- elf sight  -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
    
    <script src="navi.js"></script>
    <script src="home.js"></script>
    
    <script>

    // Retrieve the isLoggedIn value from local storage
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
            	showMsg.innerText = "Please sign up first.";
                showMsg.classList.add("text-red-500");
                
             // Clear error message after 3 seconds
                setTimeout(() => {
                    showMsg.innerText = "";
                    showMsg.classList.remove("text-red-500");
                }, 2000);
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
                    
                    setTimeout(() => {
                        showMsg.innerText = "";
                    }, 2000);
                 
                    break;
                case productQuantity <= 0:
                    showMsg.innerText = "This product is out of stock!";
                    showMsg.classList.add("text-red-500");
                    
                    setTimeout(() => {
                        showMsg.innerText = "";
                    }, 2000);
                 
                    break;
                default:
                    addToCart(productName, productImage, productPrice); // Add the item to the cart
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
            
            setTimeout(() => {
                showMsg.innerText = "";
                showMsg.style.color = ""; 
            }, 2000);
         
        } else {
            showMsg.innerText = productName + " is already in your wishlist.";
            showMsg.style.color = "red";
            
            setTimeout(() => {
                showMsg.innerText = "";
                showMsg.style.color = ""; 
            }, 2000);
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
            
            setTimeout(() => {
                showMsg.innerText = "";
                showMsg.style.color = ""; 
            }, 2000);
         
        } else {
            showMsg.innerText = productName + " is already in your cart.";
            showMsg.style.color = "red";
            
            setTimeout(() => {
                showMsg.innerText = "";
                showMsg.style.color = ""; 
            }, 2000);
        }
    }

    document.getElementById("closeModal").onclick = function() {
        const modal = document.getElementById("productModal");
        modal.classList.add("hidden");
    };

    window.onclick = function(event) {
        const modal = document.getElementById("productModal");
        if (event.target === modal) {
            modal.classList.add("hidden");
        }
    };

    </script>
    
</body>
</html>
