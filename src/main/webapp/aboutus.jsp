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

    <section class="pt-[63px] ">
    <div class="flex flex-col">
        <div class="flex flex-col md:flex-row ">
            <div class="flex justify-center items-center font-mono w-full md:w-1/2 bg-slate-950 text-white font-semibold text-5xl p-6 text-center">
                <p class="text-left">
                    <span class="block text-2xl">ABOUTUS </span>
                    WE'RE ON A MISSION <br>
                    TO REDEFINE LUXURY.
                </p>
            </div>
            <div class="md:w-1/2 flex justify-center">
                <img class="w-full h-auto rounded-lg shadow-lg" src="./item/aboutus.jpg" alt="About Us">
            </div>
        </div>
        <div class="mt-8 px-4 md:px-12">
            <h2 class="text-3xl font-bold mb-4">Welcome to JewelryPalace!</h2>
            <p class="mb-4">At JewelryPalace, we believe that every piece of jewelry tells a unique story. Founded with a passion for craftsmanship and elegance, we are dedicated to offering high-quality, exquisite jewelry that adds a touch of luxury to your life.</p>
            
            <h3 class="text-2xl font-semibold mt-6">Our Journey</h3>
            <p class="mb-4">Our journey began with a love for timeless beauty and intricate designs. Each piece in our collection is thoughtfully crafted by skilled artisans who pour their heart and soul into every creation. We source only the finest materials, ensuring that our jewelry is not just a purchase but a cherished heirloom for generations to come.</p>
            
            <h3 class="text-2xl font-semibold mt-6">Our Mission</h3>
            <p class="mb-4">Our mission is to empower individuals to express their unique style and celebrate special moments through our jewelry. Whether it’s an engagement ring, a gift for a loved one, or a treat for yourself, we strive to provide pieces that resonate with your personal story.</p>
            
            <h3 class="text-2xl font-semibold mt-6">Our Promise</h3>
            <p class="mb-4">At JewelryPalace, customer satisfaction is our top priority. We are committed to providing exceptional service, from the moment you browse our collection to the day you wear your new treasure. Our team is here to assist you with personalized recommendations and to ensure that your shopping experience is seamless and enjoyable.</p>
            
            <h3 class="text-2xl font-semibold mt-6">Join Our Community</h3>
            <p class="mb-4">We invite you to explore our exquisite collection and find the perfect piece that speaks to you. Follow us on social media to stay updated on new arrivals, exclusive offers, and behind-the-scenes glimpses into our craftsmanship.</p>
            
            <p>Thank you for being part of the JewelryPalace family. We look forward to helping you create memories that last a lifetime!</p>
        </div>
    </div>
</section>



    <!-- footer section  -->
    <div id="footer"></div>

    <!-- elf sight  -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
    
    <script src="navi.js"></script>
    
    <script>

    // Retrieve the isLoggedIn value from local storage
    const isLoggedInLocalStorage = localStorage.getItem('isLoggedIn') === 'true';
    // Pass the server-side login status to JavaScript
    const isLoggedInServer = <%= isLoggedInServer ? "true" : "false" %> === "true";
    // Combine both server-side and client-side checks
    const isLoggedIn = isLoggedInServer || isLoggedInLocalStorage;
    
    </script>
    
</body>
</html>
