package auth;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class authServlet
 */
@WebServlet("/authServlet")
public class authServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public authServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        String signUpQuery = "INSERT INTO Users (name, email, password) VALUES (?, ?, ?)";
        String signInQuery = "SELECT name, password FROM Users WHERE email = ?"; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jewelrypalace", "root", "root");

            if (username == null || username.trim().isEmpty()) { 
                // Sign In
                PreparedStatement pstmt = conn.prepareStatement(signInQuery);
                pstmt.setString(1, email);
                ResultSet resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    String storedUsername = resultSet.getString("name"); 
                    String storedHashedPassword = resultSet.getString("password");
                    boolean passwordMatch = BCrypt.checkpw(password, storedHashedPassword);

                    if (passwordMatch) {
                        session.setAttribute("username", storedUsername); 
                        session.setAttribute("email", email);
                    } else {
                        out.println("Invalid email or password.");
                        return;
                    }
                } else {
                    out.println("Invalid email or password.");
                    return;
                }
                resultSet.close();
                pstmt.close();
            } else {
                // Sign Up
                PreparedStatement pstmt = conn.prepareStatement(signUpQuery);
                pstmt.setString(1, username);
                pstmt.setString(2, email);
                pstmt.setString(3, hashedPassword);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    session.setAttribute("username", username);
                    session.setAttribute("email", email);
                } else {
                    out.println("Failed to sign up.");
                    return;
                }
            }

            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }

        String currentUsername = (String) session.getAttribute("username");
        String currentEmail = (String) session.getAttribute("email");

        if (currentUsername == null || currentEmail == null) { 
            out.println("Sign In First!");
        } else {
            out.println("<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<head>\r\n"
                + "<meta charset=\"ISO-8859-1\">\r\n"
                + "<title>Jewelry Palace</title>\r\n"
                + "<script src=\"https://cdn.tailwindcss.com\"></script>\r\n"
                + "<link rel=\"stylesheet\" href=\"fontawesomepro/css/all.min.css\">\r\n"
                + "<link rel=\"icon\" href=\"./logo/logo7.png\">\r\n"
                + "</head>\r\n"
                + "<body>\r\n"
                + "<!-- nav bar & loginForm -->\r\n"
                + "<div id=\"nav\"></div>\r\n"
                +"<section class=\"menuBar\">\r\n"
                + "    <div class=\"fixed flex items-center justify-between w-full bg-slate-50 border border-x-0 border-slate-950 h-16 z-10\">\r\n"
                + "      <div>\r\n"
                + "        <img class=\"w-[180px] p-1 ml-12 mr-12\" src=\"./logo/logo9.png\" alt=\"\">\r\n"
                + "      </div>\r\n"
                + "\r\n"
                + "      <div>\r\n"
                + "        <ul class=\" flex space-x-10 font-semibold \">\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \">NEW</li>\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \">BEST SELLERS</li>\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \"><a href=\"earrings.html\">EARRINGS</a></li>\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \"><a href=\"rings.html\">RINGS</a></li>\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \"><a href=\"necklaces.html\">NECKLACES</a></li>\r\n"
                + "          <li class=\" hover:underline underline-offset-4 \"><a href=\"bracelets.html\">BRACELETS</a></li>\r\n"
                + "        </ul>\r\n"
                + "      </div>\r\n"
                + "\r\n"
                + "      <!-- sign up button hover-->\r\n"
                + "      <div class=\" mr-12 flex space-x-8 \">\r\n"
                + "        <div class=\" hover:drop-shadow-xl relative\">\r\n"
                + "          <i id=\"profileIcon\" class=\" group fa-lg far fa-user cursor-pointer\">\r\n"
                + "            <div class=\"hidden group-hover:flex w-[400px] delay-100 duration-100 bg-slate-50 right-[-163px] top-[25px] shadow-slate-400 shadow-md absolute \">\r\n"
                + "              <div class=\"flex flex-col p-10 font-semibold font-sans relative\">\r\n"
                + "                <div class=\" text-base text-left mb-4 inline \">\r\n"
                + "                    Welcome Back,<span>&nbsp;"+session.getAttribute("username")+"</span>\r\n"
                + "                </div>\r\n"
                + "                <div id=\"signOutLink\" class=\" cursor-pointer text-center text-sm py-5 absolute bottom-0 \">\r\n"
                + "                  Sign out\r\n"
                + "              	</div>\r\n"
                + "              </div>\r\n"
                + "            </div>\r\n"
                + "          </i>"
                + "        </div>\r\n"
                + "        <a href=\"#\">\r\n"
                + "          <div class=\" hover:drop-shadow-xl \">\r\n"
                + "            <i class=\"fa-lg far fa-heart cursor-pointer\"></i>\r\n"
                + "          </div>\r\n"
                + "        </a>\r\n"
                + "        <div id=\"shoppingCartIcon\" class=\" hover:drop-shadow-xl \">\r\n"
                + "          <i class=\"fa-lg far fa-shopping-cart cursor-pointer\"></i>\r\n"
                + "        </div>\r\n"
                + "      </div>\r\n"
                + "    </div>\r\n"
                + "  </section>\r\n"
                + "\r\n"
                + "  <!-- login Form for Sign Up & Sign In -->\r\n"
                + "  <div id=\"loginForm\" class=\"hidden fixed inset-0 bg-slate-900 bg-opacity-50 justify-center items-center z-10\">\r\n"
                + "    <div class=\"bg-slate-50 p-8 rounded shadow-lg w-1/3 relative\">\r\n"
                + "      <div id=\"closeLoginForm\" class=\"absolute top-3 right-3 cursor-pointer text-slate-400 hover:text-gray-600\">\r\n"
                + "        <i class=\"fa-lg fa far fa-times\"></i>\r\n"
                + "      </div>\r\n"
                + "      <h2 id=\"headerWel\" class=\"text-3xl font-bold mb-6 text-center text-slate-800\">Welcome to Jewelry Palace</h2>\r\n"
                + "      \r\n"
                + "      <!-- For Servlet Page -->\r\n"
                + "      <form method=\"post\" action=\"authServlet\">\r\n"
                + "        <div id=\"userNameContainer\" class=\"mb-4\">\r\n"
                + "          <label for=\"userName\" class=\"block text-sm font-medium text-slate-700 mb-1\">Enter your name</label>\r\n"
                + "          <input type=\"text\" id=\"userName\" name=\"username\" class=\"w-full px-0 py-2 border-b border-gray-300 focus:border-slate-950 focus:outline-none transition duration-200\" required>\r\n"
                + "        </div>\r\n"
                + "        <div class=\"mb-4\">\r\n"
                + "          <label for=\"email\" class=\"block text-sm font-medium text-slate-700 mb-1\">Enter your email</label>\r\n"
                + "          <input type=\"email\" id=\"email\" name=\"email\" class=\"w-full px-0 py-2 border-b border-slate-300 focus:border-slate-950 focus:outline-none transition duration-200\" required>\r\n"
                + "        </div>\r\n"
                + "        <div class=\"mb-6\">\r\n"
                + "          <label for=\"password\" class=\"block text-sm font-medium text-slate-700 mb-1\">Enter your password</label>\r\n"
                + "          <input type=\"password\" id=\"password\" name=\"password\" class=\"w-full px-0 py-2 border-b border-slate-300 focus:border-slate-950 focus:outline-none transition duration-200\" required>\r\n"
                + "        </div>\r\n"
                + "        <div>\r\n"
                + "          <button id=\"submitBtn\" type=\"submit\" class=\"w-full bg-slate-500 text-white py-2 rounded-md shadow-lg hover:bg-slate-600 focus:ring-4 focus:ring-slate-300 transition ease-in-out duration-150\">SIGN UP</button>\r\n"
                + "        </div>\r\n"
                + "      </form>\r\n"
                + "    </div>\r\n"
                + "  </div>\r\n"
                + "\r\n"
                + "  <!-- shopping cart box -->\r\n"
                + "  <div id=\"shoppingCartBox\" class=\"fixed top-0 right-0 h-screen w-96 bg-white shadow-xl z-10 transform translate-x-full transition-transform duration-300 ease-in-out\">\r\n"
                + "    <div class=\"p-4 relative h-full\">\r\n"
                + "        <div id=\"closeShoppingCart\" class=\"cursor-pointer text-slate-500 hover:text-slate-950 absolute top-4 right-4\">\r\n"
                + "            <i class=\"fa-lg fa far fa-times\"></i>\r\n"
                + "        </div>\r\n"
                + "        <h2 class=\"text-xl font-bold my-8\">Shopping Cart</h2>\r\n"
                + "        <!-- <p>No items in the cart.</p> -->\r\n"
                + "    </div>\r\n"
                + "  </div>"
                + "<section class=\"container mx-auto p-10 pb-5\">\r\n"
                + "    <div class=\"text-normal font-semibold pt-20\">\r\n"
                + "        <a href=\"index.html\" class=\"\">Home &nbsp;/&nbsp;</a>\r\n"
                + "        <span id=\"textForPfMwPh\">My Profile</span>\r\n"
                + "        <h1 id=\"pageTitle\" class=\"font-mono mt-5 text-5xl tracking-tighter\">MY PROFILE</h1>\r\n"
                + "    </div>\r\n"
                + "    <div class=\"flex space-x-3 my-8\">\r\n"
                + "        <div id=\"profile\" class=\"p-3 w-max bg-slate-300 cursor-pointer\">\r\n"
                + "            My Profile\r\n"
                + "        </div>\r\n"
                + "        <div id=\"wishlist\" class=\"p-3 w-max bg-slate-300 cursor-pointer\">\r\n"
                + "            My Wishlist\r\n"
                + "        </div>\r\n"
                + "        <div id=\"purchase\" class=\"p-3 w-max bg-slate-300 cursor-pointer\">\r\n"
                + "            Purchase History\r\n"
                + "        </div>\r\n"
                + "    </div>\r\n"
                + "    <div class=\"border-b border-slate-950 w-full\"></div>\r\n"
                + "    <!-- My Profile -->\r\n"
                + "    <div id=\"myProfile\" class=\"pt-10 space-y-10 text-xl\">\r\n"
                + "        <div class=\"font-semibold\">My Profile</div>\r\n"
                + "        <div>\r\n"
                + "            <p class=\"font-semibold\">Name</p>\r\n"
                + "            <p>"+session.getAttribute("username")+"</p>\r\n"
                + "        </div>\r\n"
                + "        <div>\r\n"
                + "            <p class=\"font-semibold\">Email</p>\r\n"
                + "            <p>"+session.getAttribute("email")+"</p>\r\n"
                + "        </div>\r\n"
                + "    </div>\r\n"
                + "    <!--My Wishlist -->\r\n"
                + "    <div id=\"myWishlist\" class=\"hidden pt-10 space-y-10 text-xl\">\r\n"
                + "        <div class=\"font-semibold\">My Wishlist</div>  \r\n"
                + "        <div>\r\n"
                + "            <!-- Wishlist items go here -->\r\n"
                + "        </div>\r\n"
                + "    </div>\r\n"
                + "    <!-- Purchase History -->\r\n"
                + "    <div id=\"purchaseHistory\" class=\"hidden pt-10 space-y-10 text-xl\">\r\n"
                + "        <div class=\"font-semibold\">Purchase History</div>\r\n"
                + "        <div>\r\n"
                + "            <!-- Purchase history items go here -->\r\n"
                + "        </div>\r\n"
                + "    </div>\r\n"
                + "</section>\r\n"
                + "<!-- elf sight  -->\r\n"
                + "<script src=\"https://static.elfsight.com/platform/platform.js\" data-use-service-core defer></script>\r\n"
                + "<div class=\"elfsight-app-28c6dc95-5400-49df-a698-6341ed374307\" data-elfsight-app-lazy></div>\r\n"
                + "<script src=\"script.js\"></script>\r\n"
                + "<script>\r\n"
                + "    // profile, wishlist, purchase page add & remove\r\n"
                + "	const profile = document.getElementById('profile');\r\n"
                + "    const myProfile = document.getElementById('myProfile');\r\n"
                + "    const wishlist = document.getElementById('wishlist');\r\n"
                + "    const myWishlist = document.getElementById('myWishlist');\r\n"
                + "    const purchase = document.getElementById('purchase');\r\n"
                + "    const purchaseHistory = document.getElementById('purchaseHistory');\r\n"
                + "    const pageTitle = document.getElementById('pageTitle'); \r\n"
                + "    const changeText = document.getElementById('textForPfMwPh');\r\n"
                + "    function showSection(sectionToShow, activeButton, titleText, spanText) {\r\n"
                + "        myProfile.classList.add('hidden');\r\n"
                + "        myWishlist.classList.add('hidden');\r\n"
                + "        purchaseHistory.classList.add('hidden');\r\n"
                + "        profile.classList.remove('border');\r\n"
                + "        wishlist.classList.remove('border');\r\n"
                + "        purchase.classList.remove('border');\r\n"
                + "        sectionToShow.classList.remove('hidden');\r\n"
                + "        activeButton.classList.add('border', 'border-slate-950');\r\n"
                + "        changeText.textContent = \"\";\r\n"
                + "        pageTitle.textContent = titleText; \r\n"
                + "        changeText.textContent = spanText; \r\n"
                + "    }\r\n"
                + "    profile.addEventListener('click', function() {\r\n"
                + "        showSection(myProfile, profile, 'MY PROFILE', 'My Profile');\r\n"
                + "    });\r\n"
                + "    wishlist.addEventListener('click', function() {\r\n"
                + "        showSection(myWishlist, wishlist, 'MY WISHLIST', 'My Wishlist');\r\n"
                + "    });\r\n"
                + "    purchase.addEventListener('click', function() {\r\n"
                + "        showSection(purchaseHistory, purchase, 'PURCHASE HISTORY', 'Purchase History');\r\n"
                + "    });\r\n"
                + "const signUpLink = document.getElementById(\"signUpLink\");\r\n"
                + "const signInLink = document.getElementById('signInLink');\r\n"
                + "const loginForm = document.getElementById(\"loginForm\");\r\n"
                + "const closeLoginForm = document.getElementById(\"closeLoginForm\");\r\n"
                + "const userNameContainer = document.getElementById('userNameContainer');\r\n"
                + "const userNameInput = document.getElementById('userName');\r\n"
                + "const submitBtn = document.getElementById('submitBtn');\r\n"
                + "const headerWel = document.getElementById('headerWel');\r\n"
                + "const profileIcon = document.getElementById('profileIcon');\r\n"
                + "const shoppingCartIcon = document.getElementById('shoppingCartIcon');\r\n"
                + "const shoppingCartBox = document.getElementById('shoppingCartBox');\r\n"
                + "const closeShoppingCart = document.getElementById('closeShoppingCart');\r\n"
                + "\r\n"
                + "// Function to show the login form\r\n"
                + "function showLoginForm() {\r\n"
                + "  loginForm.classList.remove(\"hidden\");\r\n"
                + "  loginForm.classList.add(\"flex\");\r\n"
                + "}\r\n"
                + "\r\n"
                + "// Event listener for Sign Up link\r\n"
                + "signUpLink.addEventListener(\"click\", function() {\r\n"
                + "  showLoginForm();\r\n"
                + "  userNameContainer.classList.remove(\"hidden\"); // Ensure username container is visible for Sign Up\r\n"
                + "  userNameInput.removeAttribute('required'); // Ensure username field is not required\r\n"
                + "  submitBtn.textContent = 'SIGN UP'; \r\n"
                + "  headerWel.textContent = 'Welcome to Jewelry Palace';\r\n"
                + "});\r\n"
                + "\r\n"
                + "// Event listener for Sign In link\r\n"
                + "signInLink.addEventListener(\"click\", function(){\r\n"
                + "  showLoginForm();\r\n"
                + "  userNameContainer.classList.add(\"hidden\"); // Hide username container for Sign In\r\n"
                + "  userNameInput.removeAttribute('required'); // Remove required attribute for Sign In\r\n"
                + "  submitBtn.textContent = 'SIGN IN'; \r\n"
                + "  headerWel.textContent = 'Welcome Back';\r\n"
                + "});\r\n"
                + "\r\n"
                + "// Event listener for close button in login form\r\n"
                + "closeLoginForm.addEventListener(\"click\", function() {\r\n"
                + "  loginForm.classList.add(\"hidden\");\r\n"
                + "});\r\n"
                + "\r\n"
                + "// Event listener for Shopping Cart icon\r\n"
                + "shoppingCartIcon.addEventListener('click', function () {\r\n"
                + "    shoppingCartBox.style.transform = 'translateX(0)';\r\n"
                + "});\r\n"
                + "\r\n"
                + "// Event listener for close button in shopping cart\r\n"
                + "closeShoppingCart.addEventListener('click', function () {\r\n"
                + "    shoppingCartBox.style.transform = 'translateX(100%)';\r\n"
                + "});\r\n"
                + "// Event listener for Shopping Cart icon\r\n"
                + "shoppingCartIcon.addEventListener('click', function () {\r\n"
                + "    shoppingCartBox.style.transform = 'translateX(0)';\r\n"
                + "});\r\n"
                + "\r\n"
                + "// Event listener for close button in shopping cart\r\n"
                + "closeShoppingCart.addEventListener('click', function () {\r\n"
                + "    shoppingCartBox.style.transform = 'translateX(100%)';\r\n"
                + "});\r\n"
                + "\r\n"
                + "</script>\r\n"
                + "</body>\r\n"
                + "</html>\r\n");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
