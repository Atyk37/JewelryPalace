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
                + "  <div id=\"nav\"></div>\r\n"
                
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
                
                + "<script src=\"navi.js\"></script>\r\n"
                
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
