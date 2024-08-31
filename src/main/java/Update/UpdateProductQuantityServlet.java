package Update;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class UpdateProductQuantityServlet
 */
@WebServlet("/UpdateProductQuantityServlet")
public class UpdateProductQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProductQuantityServlet() {
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
		// Set response type
        response.setContentType("application/json");

        // Step 1: Parse the incoming JSON data
        JsonArray productArray = parseJsonData(request);
        if (productArray == null) {
            sendErrorResponse(response, "Invalid JSON data.");
            return;
        }

        // Step 2: Process the product data and update the database
        boolean updateSuccess = updateProductQuantities(productArray);

        // Step 3: Send a response back to the client
        if (updateSuccess) {
            sendSuccessResponse(response);
        } else {
            sendErrorResponse(response, "Failed to update product quantities.");
        }
    }

    // Method to parse JSON data from the request
    private JsonArray parseJsonData(HttpServletRequest request) {
        StringBuilder jsonBuffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        
        try {
            JsonElement jsonElement = JsonParser.parseReader(new StringReader(jsonBuffer.toString()));
            return jsonElement.getAsJsonArray();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Method to update product quantities in the database
    private boolean updateProductQuantities(JsonArray productArray) {
        String updateQuery = "UPDATE product SET quantity = quantity - ? WHERE name = ? AND quantity >= ?";
        
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
            for (int i = 0; i < productArray.size(); i++) {
                JsonObject product = productArray.get(i).getAsJsonObject();
                String name = product.get("name").getAsString();
                int quantity = product.get("quantity").getAsInt();

                pstmt.setInt(1, quantity);
                pstmt.setString(2, name);
                pstmt.setInt(3, quantity);

                int affectedRows = pstmt.executeUpdate();
                if (affectedRows == 0) {
                    return false; // If any product update fails, return false
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    // Utility method to establish a database connection
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/jewelrypalace";
        String username = "root";
        String password = "root"; // Replace with your MySQL password
        return DriverManager.getConnection(url, username, password);
    }

    // Method to send a success response
    private void sendSuccessResponse(HttpServletResponse response) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", true);
        response.getWriter().write(jsonResponse.toString());
    }

    // Method to send an error response
    private void sendErrorResponse(HttpServletResponse response, String errorMessage) throws IOException {
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("success", false);
        jsonResponse.addProperty("error", errorMessage);
        response.getWriter().write(jsonResponse.toString());
    }
}