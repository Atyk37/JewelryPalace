package Delete;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteProductServlet
 */
@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteProductServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
        Integer deletedProductId = null; // Variable to hold the deleted product ID
        String deletedProductCategory = null; // Variable to hold the deleted product category
        Double deletedProductPrice = null; // Variable to hold the deleted product price

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jewelrypalace", "root", "root")) {
            // First, fetch the product details before deletion
            String fetchQuery = "SELECT id, category, price FROM product WHERE name=?";
            try (PreparedStatement fetchPstmt = conn.prepareStatement(fetchQuery)) {
                fetchPstmt.setString(1, productName);
                try (ResultSet rs = fetchPstmt.executeQuery()) {
                    if (rs.next()) {
                        deletedProductId = rs.getInt("id"); // Get the ID of the product to be deleted
                        deletedProductCategory = rs.getString("category"); // Get the category
                        deletedProductPrice = rs.getDouble("price"); // Get the price
                    }
                }
            }

            // Now delete the product
            String sql = "DELETE FROM product WHERE name=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, productName);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Log the delete activity only if deletion is successful
                    String logQuery = "INSERT INTO activity_log (product_id, product_name, product_category, product_price, action) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement logPstmt = conn.prepareStatement(logQuery)) {
                        logPstmt.setInt(1, deletedProductId); // ID of the deleted product
                        logPstmt.setString(2, productName); // Name of the deleted product
                        logPstmt.setString(3, deletedProductCategory); // Category of the deleted product
                        logPstmt.setDouble(4, deletedProductPrice); // Price of the deleted product
                        logPstmt.setString(5, "deleted"); // Action taken
                        logPstmt.executeUpdate(); // Execute the logging statement
                    }
                    response.sendRedirect("admin.jsp?deleteSuccess=true");
                } else {
                    response.sendRedirect("admin.jsp?deleteError=true");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?deleteError=true");
        }
    }
}
