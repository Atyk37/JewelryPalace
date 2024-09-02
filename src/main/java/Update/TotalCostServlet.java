package Update;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TotalCostServlet
 */
@WebServlet("/TotalCostServlet")
public class TotalCostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TotalCostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        StringBuilder sb = new StringBuilder();
        
        // Read the incoming JSON data
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        
        // Parse the total cost from the JSON data
        double totalCost = Double.parseDouble(sb.toString());
        
        // Database connection variables
        String jdbcURL = "jdbc:mysql://localhost:3306/jewelrypalace"; // Replace with your database URL
        String dbUser = "root"; // Replace with your database user
        String dbPassword = "root"; // Replace with your database password
        
        // Database insertion
        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "INSERT INTO total_cost (total_cost) VALUES (?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setDouble(1, totalCost);
                int rowsInserted = statement.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("{\"success\": true}");
                } else {
                    out.println("{\"success\": false}");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"success\": false}");
        } finally {
            out.close();
        }
    
	}

}
