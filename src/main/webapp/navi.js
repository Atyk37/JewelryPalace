// Function to initialize the navigation bar
function initializeNav() {
  const navContainer = document.getElementById("nav");
  let isLoggedIn = localStorage.getItem("isLoggedIn");
  const getUserName = localStorage.getItem('username') || sessionStorage.getItem('username');

  const navInnerHTML = `
    <section class="menuBar">
      <div class="fixed flex items-center justify-between w-full bg-slate-50 border border-x-0 border-slate-950 h-16 z-10">
        <div>
          <img class="w-[180px] p-1 ml-12 mr-12" src="./logo/logo9.png" alt="">
        </div>

        <div>
          <ul class="flex space-x-10 font-semibold">
            <li class="hover:underline underline-offset-4"><a href="index.jsp">HOME</a></li>
            <li class="hover:underline underline-offset-4"><a href="bestseller.jsp">BEST SELLERS</a></li>
            <li class="hover:underline underline-offset-4"><a href="earring.jsp">EARRINGS</a></li>
            <li class="hover:underline underline-offset-4"><a href="ring.jsp">RINGS</a></li>
            <li class="hover:underline underline-offset-4"><a href="bracelet.jsp">BRACELETS</a></li>
			<li class="hover:underline underline-offset-4"><a href="necklace.jsp">NECKLACES</a></li>
          </ul>
        </div>

        <div class="mr-12 flex space-x-8">
          <div class="hover:drop-shadow-xl relative">
            <i class=" group fa-lg far fa-user cursor-pointer">
              <div class="hidden group-hover:flex w-[400px] delay-100 duration-100 bg-slate-50 right-[-163px] top-[25px] shadow-slate-400 shadow-md absolute">
                <div class="flex z-20 flex-col p-10">
                
                  ${isLoggedIn ? `
                  <div id="afterLogin" class=" space-y-5">
                    <div class="text-xl text-left mb-4 inline">
                      Welcome Back,
                      <span>${getUserName}</span>
                    </div>
                    <a class=" text-base text-left hover:opacity-75 my-7 underline-offset-2 block" href="profile.jsp">
                      My profile
                    </a>
                    <div id="signOutLink" class="cursor-pointer text-left text-base  mb-5 hover:opacity-75 underline-offset-2">
                      Sign out
                    </div>
                  </div>
                  ` : `
                  <div id="beforeLogin" class="font-bold font-sans">
                    <div class="text-2xl text-left mb-4">
                      DISCOVER ALL THINGS IN JEWELRY PALACE.
                    </div>
                    <div class="text-left mb-4 text-sm font-normal">
                      One account to shop personalized recommendations and exclusive products.
                    </div>
                    <div id="signInLink" class="cursor-pointer py-3 mb-4 text-center text-xl text-slate-50 bg-slate-950">
                      SIGN IN
                    </div>
                    <div class="text-left text-sm font-normal">
                      Don't have an account?
                      <span id="signUpLink" class="font-semibold ml-2 cursor-pointer">Sign up</span>
                    </div>
                  </div>
                  `}
                  
                </div>
              </div>
            </i>
          </div>
          <div class=" hover:drop-shadow-xl">
          	<a href="wishlist.jsp"><i class="fa-lg far fa-heart cursor-pointer"></i></a>
          </div>
          <div id="shoppingCartIcon" class="hover:drop-shadow-xl">
            <i class="fa-lg far fa-shopping-cart cursor-pointer"></i>
          </div>
        </div>
      </div>
    </section>

    <div id="loginForm" class="hidden fixed inset-0 bg-slate-900 bg-opacity-50 justify-center items-center z-10">
      <div class="bg-slate-50 p-8 rounded shadow-lg w-1/3 relative">
        <div id="closeLoginForm" class="absolute top-3 right-3 cursor-pointer text-slate-400 hover:text-gray-600">
          <i class="fa-lg fa far fa-times"></i>
        </div>
        <h2 id="headerWel" class="text-3xl font-bold mb-6 text-center text-slate-800">Welcome to Jewelry Palace</h2>
        
        <form method="post" action="authServlet">
          <div id="userNameContainer" class="mb-4">
            <label for="userName" class="block text-sm font-medium text-slate-700 mb-1">Enter your name</label>
            <input type="text" id="userName" name="username" class="w-full px-0 py-2 border-b border-gray-300 focus:border-slate-950 focus:outline-none transition duration-200" required>
          </div>
          <div class="mb-4">
            <label for="email" class="block text-sm font-medium text-slate-700 mb-1">Enter your email</label>
            <input type="email" id="email" name="email" class="w-full px-0 py-2 border-b border-slate-300 focus:border-slate-950 focus:outline-none transition duration-200" required>
          </div>
          <div class="mb-6">
            <label for="password" class="block text-sm font-medium text-slate-700 mb-1">Enter your password</label>
            <input type="password" id="password" name="password" class="w-full px-0 py-2 border-b border-slate-300 focus:border-slate-950 focus:outline-none transition duration-200" required>
          </div>
          <div>
            <button id="submitBtn" type="submit" class="w-full bg-slate-500 text-white py-2 rounded-md shadow-lg hover:bg-slate-600 focus:ring-4 focus:ring-slate-300 transition ease-in-out duration-150">SIGN UP</button>
          </div>
        </form>
      </div>
    </div>

    <div id="shoppingCartBox" class="fixed top-0 right-0 h-screen w-96 bg-white shadow-xl z-20 transform translate-x-full transition-transform duration-300 ease-in-out">
      <div class="p-4 relative h-full">
        <div id="closeShoppingCart" class="cursor-pointer z-20 text-slate-500 hover:text-slate-950 absolute top-4 right-4">
          <i class="fa-lg fa far fa-times"></i>
        </div>
        <h2 class="text-xl font-bold my-8">Shopping Cart</h2>
        <div id="cartItemsContainer">
          <!-- Cart items will be displayed here -->
        </div>
      </div>
    </div>
  `;

  navContainer.innerHTML = navInnerHTML;
  
  const footerContainer = document.getElementById("footer");

const footerInnerHTML = `
  <section class=" container mx-auto pt-20">
    <div class=" flex item-center justify-self-start font-mono p-5 border-t-2 border-t-slate-950">

      <!-- location -->
      <div class=" mr-14 " >
      	<iframe class="w-[500px] h-[250px] " src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1351.1289414342793!2d98.69154455341364!3d12.46406470198828!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x30fbbac4a940b3c5%3A0xfc8423e9db112e26!2sUniversity%20of%20Computer%20Studies%20(Myeik)!5e1!3m2!1sen!2smm!4v1723697090132!5m2!1sen!2smm" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
      </div>

      <div class=" flex flex-col gap-16">

        <div class="">
          <p class=" font-semibold text-2xl pb-2 tracking-widest">CONTACTUS</p>
          <p class=" text-base "><i class="far fa-phone-rotary"></i>+959784444037</p>
          <p class=" text-base "><i class="far fa-envelope"></i>&nbsp;thu454909@gmail.com</p>
        </div>

        <div class=" flex gap-16 ">
          <div class="">
            <p class=" font-semibold text-2xl pb-2 tracking-widest">ADDRESS</p>
            <p class=" text-base ">Myeik&nbsp;<i class="far fa-map-marker-alt"></i> ,</p>
            <p class=" text-base ">Tanintharyi</p>
          </div>
  
          <div class="">
            <p class=" font-semibold text-2xl pb-2 tracking-widest">CONNECT</p>
            <p class=" text-base "><i class="fab fa-facebook-square"></i>&nbsp;facebook</p>
            <p class=" text-base "><i class="fab fa-instagram"></i>&nbsp;Instagram</p>
          </div>
        </div>

      </div>

    </div>
  </section>
`;

footerContainer.innerHTML = footerInnerHTML;

  const signUpLink = document.getElementById("signUpLink");
  const signInLink = document.getElementById('signInLink');
  const loginForm = document.getElementById("loginForm");
  const closeLoginForm = document.getElementById("closeLoginForm");
  const userNameContainer = document.getElementById('userNameContainer');
  const userNameInput = document.getElementById('userName');
  const submitBtn = document.getElementById('submitBtn');
  const headerWel = document.getElementById('headerWel');
  const shoppingCartIcon = document.getElementById('shoppingCartIcon');
  const shoppingCartBox = document.getElementById('shoppingCartBox');
  const closeShoppingCart = document.getElementById('closeShoppingCart');
  const signOutLink = document.getElementById('signOutLink');

// Function to validate password
function validatePassword(password) {
  // Regular expression for password requirements: at least 8 characters, 
  // at least one uppercase letter, one lowercase letter, one digit, and one special character
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
  return passwordRegex.test(password);
}

// Event listener for the form submission
document.querySelector('form[action="authServlet"]').addEventListener('submit', function(event) {
  const passwordInput = document.getElementById('password');
  const password = passwordInput.value;

  if (!validatePassword(password)) {
    event.preventDefault(); // Prevent form submission
    alert('Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character.');
    passwordInput.focus(); // Focus on the password input for correction
  }
});


 // Event listener for Sign Up link
  if (signUpLink) {
    signUpLink.addEventListener("click", function() {
      showLoginForm();
      userNameContainer.classList.remove("hidden"); 
      userNameInput.removeAttribute("required"); 
      submitBtn.textContent = 'SIGN UP'; 
      headerWel.textContent = 'Welcome to Jewelry Palace';
    });
  }

 // Event listener for Sign In link
  if (signInLink) {
    signInLink.addEventListener("click", function(){
      showLoginForm();
      userNameContainer.classList.add("hidden"); 
      userNameInput.removeAttribute("required"); 
      submitBtn.textContent = 'SIGN IN'; 
      headerWel.textContent = 'Welcome Back';
    });
  }

 //  Event listener for Sign Out link
  if (signOutLink) {
    signOutLink.addEventListener('click', handleSignOut);
  }

 // Event listener for close button in login form
  if (closeLoginForm) {
    closeLoginForm.addEventListener("click", function() {
      loginForm.classList.add("hidden");
    });
  }

 // Event listener for Shopping Cart icon
  if (shoppingCartIcon) {
    shoppingCartIcon.addEventListener('click', function () {
      renderCartItems(); // Call to render items before showing the cart
      shoppingCartBox.style.transform = 'translateX(0)';
    });
  }

 // Event listener for close button in shopping cart
  if (closeShoppingCart) {
    closeShoppingCart.addEventListener('click', function () {
      shoppingCartBox.style.transform = 'translateX(100%)';
    });
  }
}

// Function to show the login form
function showLoginForm() {
  const loginForm = document.getElementById("loginForm");
  if (loginForm) {
    loginForm.classList.remove("hidden");
    loginForm.classList.add("flex");
  }
}

// Function to sign out link
function handleSignOut() {
  localStorage.removeItem('isLoggedIn');
  localStorage.removeItem('username');
  localStorage.removeItem('email');
  
  sessionStorage.removeItem('username');
  sessionStorage.removeItem('email');
  
  const beforeLogin = document.getElementById('beforeLogin');
  const afterLogin = document.getElementById('afterLogin');
  
  if (beforeLogin) {
    beforeLogin.classList.remove('hidden');
  }
  
  if (afterLogin) {
    afterLogin.classList.add('hidden');
  }
  
  window.location.href = 'index.jsp';
}

document.addEventListener('DOMContentLoaded', initializeNav);

// Render Cart Items in the Shopping Cart
function renderCartItems() {
  const cartItems = JSON.parse(localStorage.getItem('cart')) || []; 
  const cartItemsContainer = document.getElementById('cartItemsContainer');

  const cartItemsHTML = cartItems.map(item => `
    <div class="flex justify-between pr-3 p-2 border-b">
      <div class="flex">
        <img src="${item.image}" alt="${item.name}" class="w-12 h-12">
        <div class="flex flex-col ml-2 mt-2 text-sm">
          <span>${item.name}</span>
          <span>${item.price} MMK</span>
        </div>
      </div>
      <i class="far fa-times cursor-pointer ml-2" onclick="removeFromCart('${item.name}')"></i>
    </div>
  `).join('');

  cartItemsContainer.innerHTML = cartItemsHTML || '<p>No items in the cart.</p>';

  if (cartItems.length > 0) {
    const buyButtonHTML = `
      <div class="mt-4 text-right">
        <button id="buyButton" class="bg-slate-500 text-white py-2 px-4 rounded-md shadow-lg hover:bg-slate-600 transition ease-in-out duration-150">
          Buy Now
        </button>
      </div>
    `;
    cartItemsContainer.insertAdjacentHTML('beforeend', buyButtonHTML);

    // Add event listener to the "Buy" button
    const buyButton = document.getElementById('buyButton');
    buyButton.addEventListener('click', function() {
      purchaseItems();
    });
  }
}

// Function to handle the purchase of items
function purchaseItems() {
  const cartItems = JSON.parse(localStorage.getItem('cart')) || [];

  if (cartItems.length > 0) {
    // Example of processing the purchase (e.g., send to server, handle payment, etc.)
    alert('Thank you for your purchase!');

    // Clear the cart after purchase
    localStorage.removeItem('cart');
    renderCartItems();
  } else {
    alert('Your cart is empty.');
  }
}

// Function to remove an item from the cart
function removeFromCart(itemName) {
  let cartItems = JSON.parse(localStorage.getItem('cart')) || [];
  cartItems = cartItems.filter(item => item.name !== itemName);
  localStorage.setItem('cart', JSON.stringify(cartItems));
  renderCartItems();
}

// Call the initializeNav function when the page loads
window.onload = initializeNav;


