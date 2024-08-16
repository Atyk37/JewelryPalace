<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="ISO-8859-1">
<title>Jewelry Palace</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="fontawesomepro/css/all.min.css">
<link rel="icon" href="./logo/logo7.png">
<script>
	//Function to save data to LocalStorage
	function saveToLocalStorage(key, value) {
	    localStorage.setItem(key, value);
	}
	
	// Function to get data from LocalStorage
	function getFromLocalStorage(key) {
	    return localStorage.getItem(key);
	}
	
	// Example usage
	function handlePageLoad() {
	var username = "<%= session.getAttribute("username") != null ? session.getAttribute("username").toString() : "" %>";
	var email = "<%= session.getAttribute("email") != null ? session.getAttribute("email").toString() : "" %>";
	console.log("Name:", username || "No Name");
	console.log("Email:", email || "No Email");
	
	saveToLocalStorage('username', username);
	saveToLocalStorage('email', email);
	saveToLocalStorage('isLoggedIn', true);
	
	}
	
	// Ensure the function runs when the page loads
	document.addEventListener('DOMContentLoaded', handlePageLoad);

</script>

</head>

<body>

<% 
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
%>

<!-- nav bar & loginForm -->
<div id="nav"></div>

<section class="container mx-auto p-10 pb-5">
    <div class="text-normal font-semibold pt-20">
        <a href="index.html" class="">Home &nbsp;/&nbsp;</a>
        <span id="textForPfMwPh">My Profile</span>
        <h1 id="pageTitle" class="font-mono mt-5 text-5xl tracking-tighter">MY PROFILE</h1>
    </div>
    <div class="flex space-x-3 my-8">
        <div id="profile" class="p-3 w-max bg-slate-300 cursor-pointer">
            My Profile
        </div>
        <div id="wishlist" class="p-3 w-max bg-slate-300 cursor-pointer">
            My Wishlist
        </div>
        <div id="purchase" class="p-3 w-max bg-slate-300 cursor-pointer">
            Purchase History
        </div>
    </div>
    <div class="border-b border-slate-950 w-full"></div>
    <!-- My Profile -->
    <div id="myProfile" class="pt-10 space-y-10 text-xl">
        <div class="font-semibold">My Profile</div>
        <div>
            <p class="font-semibold">Name</p>
            <p><%= username %></p>
        </div>
        <div>
            <p class="font-semibold">Email</p>
            <p><%= email %></p>
        </div>
    </div>
    <!--My Wishlist -->
    <div id="myWishlist" class="hidden pt-10 space-y-10 text-xl">
        <div class="font-semibold">My Wishlist</div>  
        <div id="wishListContainer">
            <!-- Wishlist items go here -->
        </div>      
    </div>
    <!-- Purchase History -->
    <div id="purchaseHistory" class="hidden pt-10 space-y-10 text-xl">
        <div class="font-semibold">Purchase History</div>
        <div>
            <!-- Purchase history items go here -->
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
    // profile, wishlist, purchase page add & remove
	const profile = document.getElementById('profile');
    const myProfile = document.getElementById('myProfile');
    const wishlist = document.getElementById('wishlist');
    const myWishlist = document.getElementById('myWishlist');
    const purchase = document.getElementById('purchase');
    const purchaseHistory = document.getElementById('purchaseHistory');
    const pageTitle = document.getElementById('pageTitle'); 
    const changeText = document.getElementById('textForPfMwPh');

    function showSection(sectionToShow, activeButton, titleText, spanText) {

        myProfile.classList.add('hidden');
        myWishlist.classList.add('hidden');
        purchaseHistory.classList.add('hidden');
        
        profile.classList.remove('border');
        wishlist.classList.remove('border');
        purchase.classList.remove('border');

        sectionToShow.classList.remove('hidden');
        activeButton.classList.add('border', 'border-slate-950');
        
        changeText.textContent = "";

        pageTitle.textContent = titleText; 
        changeText.textContent = spanText; 
    }

    profile.addEventListener('click', function() {
        showSection(myProfile, profile, 'MY PROFILE', 'My Profile');
    });

    wishlist.addEventListener('click', function() {
        showSection(myWishlist, wishlist, 'MY WISHLIST', 'My Wishlist');
    });

    purchase.addEventListener('click', function() {
        showSection(purchaseHistory, purchase, 'PURCHASE HISTORY', 'Purchase History');
    });

 
</script>
</body>
</html>