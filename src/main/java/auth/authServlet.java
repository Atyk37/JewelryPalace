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
        	response.sendRedirect("profile.jsp");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
