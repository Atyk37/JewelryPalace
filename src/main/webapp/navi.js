const navContainer =  document.getElementById("nav")

const navInnerHTML = `
  <section class="menuBar">
    <div class="fixed flex items-center justify-between w-full bg-slate-50 border border-x-0 border-slate-950 h-16 z-10">
      <div>
        <img class="w-[180px] p-1 ml-12 mr-12" src="./logo/logo9.png" alt="">
      </div>

      <div>
        <ul class=" flex space-x-10 font-semibold ">
          <li class=" hover:underline underline-offset-4 ">NEW</li>
          <li class=" hover:underline underline-offset-4 ">BEST SELLERS</li>
          <li class=" hover:underline underline-offset-4 "><a href="earrings.html">EARRINGS</a></li>
          <li class=" hover:underline underline-offset-4 "><a href="rings.html">RINGS</a></li>
          <li class=" hover:underline underline-offset-4 "><a href="necklaces.html">NECKLACES</a></li>
          <li class=" hover:underline underline-offset-4 "><a href="bracelets.html">BRACELETS</a></li>
        </ul>
      </div>

      <!-- sign up button hover-->
      <div class=" mr-12 flex space-x-8 ">
        <div class=" hover:drop-shadow-xl relative">
          <i id="profileIcon" class=" group fa-lg far fa-user cursor-pointer">
            <div class="hidden group-hover:flex w-[400px] delay-100 duration-100 bg-slate-50 right-[-163px] top-[25px] shadow-slate-400 shadow-md absolute ">
              <div class="flex flex-col p-10 font-bold font-sans ">
                <div class=" text-2xl text-left mb-4 ">
                  DISCOVER ALL THINGS IN JEWELRY PALACE.
                </div>
                <div class=" text-left mb-4 text-sm font-normal">
                  One account to shop personalized recommendations and exclusive products.
                </div>
                <div id="signInLink" class=" cursor-pointer py-3 mb-4 text-center text-xl text-slate-50 bg-slate-950 ">
                  SIGN IN
              	</div>
              	<div class="text-left text-sm font-normal">
                	Don't have an account?
                	<span id="signUpLink" class=" font-semibold ml-2 cursor-pointer" >Sign up</span>
              	</div>
              </div>
            </div>
          </i>
        </div>
        <a href="#">
          <div class=" hover:drop-shadow-xl ">
            <i class="fa-lg far fa-heart cursor-pointer"></i>
          </div>
        </a>
        <div id="shoppingCartIcon" class=" hover:drop-shadow-xl ">
          <i class="fa-lg far fa-shopping-cart cursor-pointer"></i>
        </div>
      </div>
    </div>
  </section>

  <!-- login Form for Sign Up & Sign In -->
  <div id="loginForm" class="hidden fixed inset-0 bg-slate-900 bg-opacity-50 justify-center items-center z-10">
    <div class="bg-slate-50 p-8 rounded shadow-lg w-1/3 relative">
      <div id="closeLoginForm" class="absolute top-3 right-3 cursor-pointer text-slate-400 hover:text-gray-600">
        <i class="fa-lg fa far fa-times"></i>
      </div>
      <h2 id="headerWel" class="text-3xl font-bold mb-6 text-center text-slate-800">Welcome to Jewelry Palace</h2>
      
      <!-- For Servlet Page -->
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

  <!-- shopping cart box -->
  <div id="shoppingCartBox" class="fixed top-0 right-0 h-screen w-96 bg-white shadow-xl z-10 transform translate-x-full transition-transform duration-300 ease-in-out">
    <div class="p-4 relative h-full">
        <div id="closeShoppingCart" class="cursor-pointer text-slate-500 hover:text-slate-950 absolute top-4 right-4">
            <i class="fa-lg fa far fa-times"></i>
        </div>
        <h2 class="text-xl font-bold my-8">Shopping Cart</h2>
        <!-- <p>No items in the cart.</p> -->
    </div>
  </div>
`;

navContainer.innerHTML = navInnerHTML;

const signUpLink = document.getElementById("signUpLink");
const signInLink = document.getElementById('signInLink');
const loginForm = document.getElementById("loginForm");
const closeLoginForm = document.getElementById("closeLoginForm");
const userNameContainer = document.getElementById('userNameContainer');
const userNameInput = document.getElementById('userName');
const submitBtn = document.getElementById('submitBtn');
const headerWel = document.getElementById('headerWel');
const profileIcon = document.getElementById('profileIcon');
const shoppingCartIcon = document.getElementById('shoppingCartIcon');
const shoppingCartBox = document.getElementById('shoppingCartBox');
const closeShoppingCart = document.getElementById('closeShoppingCart');

// Function to show the login form
function showLoginForm() {
  loginForm.classList.remove("hidden");
  loginForm.classList.add("flex");
}

// Event listener for Sign Up link
signUpLink.addEventListener("click", function() {
  showLoginForm();
  userNameContainer.classList.remove("hidden"); // Ensure username container is visible for Sign Up
  userNameInput.removeAttribute('required'); // Ensure username field is not required
  submitBtn.textContent = 'SIGN UP'; 
  headerWel.textContent = 'Welcome to Jewelry Palace';
});

// Event listener for Sign In link
signInLink.addEventListener("click", function(){
  showLoginForm();
  userNameContainer.classList.add("hidden"); // Hide username container for Sign In
  userNameInput.removeAttribute('required'); // Remove required attribute for Sign In
  submitBtn.textContent = 'SIGN IN'; 
  headerWel.textContent = 'Welcome Back';
});

// Event listener for close button in login form
closeLoginForm.addEventListener("click", function() {
  loginForm.classList.add("hidden");
});

// Event listener for Shopping Cart icon
shoppingCartIcon.addEventListener('click', function () {
    shoppingCartBox.style.transform = 'translateX(0)';
});

// Event listener for close button in shopping cart
closeShoppingCart.addEventListener('click', function () {
    shoppingCartBox.style.transform = 'translateX(100%)';
});
// Event listener for Shopping Cart icon
shoppingCartIcon.addEventListener('click', function () {
    shoppingCartBox.style.transform = 'translateX(0)';
});

// Event listener for close button in shopping cart
closeShoppingCart.addEventListener('click', function () {
    shoppingCartBox.style.transform = 'translateX(100%)';
});

// Removed unnecessary action handling code
// Document element for action handling was removed since it caused errors
// Ensure username field visibility before form submission
