package Dash;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://localhost:3306/jewelrypalace"; // Update with your database URL
    private static final String DB_USER = "root"; // Update with your database username
    private static final String DB_PASSWORD = "root"; // Update with your database password
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // Establish database connection
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Retrieve total products
            String totalProductsQuery = "SELECT COUNT(*) AS total FROM product";
            PreparedStatement totalProductsStmt = connection.prepareStatement(totalProductsQuery);
            ResultSet totalProductsResult = totalProductsStmt.executeQuery();
            if (totalProductsResult.next()) {
                request.setAttribute("totalProducts", totalProductsResult.getInt("total"));
            }

            // Retrieve total sales
            String totalSalesQuery = "SELECT SUM(price) AS total FROM product"; // Adjust as per your sales calculation logic
            PreparedStatement totalSalesStmt = connection.prepareStatement(totalSalesQuery);
            ResultSet totalSalesResult = totalSalesStmt.executeQuery();
            if (totalSalesResult.next()) {
                request.setAttribute("totalSales", totalSalesResult.getDouble("total"));
            }

            // Retrieve total users
            String totalUsersQuery = "SELECT COUNT(*) AS total FROM users";
            PreparedStatement totalUsersStmt = connection.prepareStatement(totalUsersQuery);
            ResultSet totalUsersResult = totalUsersStmt.executeQuery();
            if (totalUsersResult.next()) {
                request.setAttribute("totalUsers", totalUsersResult.getInt("total"));
            }

            // Close connections
            totalProductsStmt.close();
            totalSalesStmt.close();
            totalUsersStmt.close();
            connection.close();

            // Forward request to the JSP page
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Handle error
            request.setAttribute("error", "Database connection error");
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        }
    
    
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
