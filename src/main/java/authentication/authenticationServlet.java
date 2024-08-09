package authentication;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DB_connection;

@WebServlet("/authenticationServlet")
public class authenticationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public authenticationServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Retrieve user data from request parameters
        String action = request.getParameter("action");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if any parameter is null or empty
        if (email == null || email.isEmpty() || password == null || password.isEmpty() || 
            ("signUp".equals(action) && (username == null || username.isEmpty()))) {
            response.sendRedirect("index.html"); // Redirect to index if any parameter is missing
            return;
        }

        // Use DB_connection to process the request
        DB_connection dbConnection = new DB_connection();
        boolean result = false;

        if ("signIn".equals(action)) {
            result = dbConnection.authenticate(email, password);
        } else if ("signUp".equals(action)) {
            result = dbConnection.addUser(username, email, password);
        }

        // Redirect based on the result
        if (result) {
            response.sendRedirect("userprofile.html");
        } else {
            response.sendRedirect("index.html?error=true");
        }
    }
}
