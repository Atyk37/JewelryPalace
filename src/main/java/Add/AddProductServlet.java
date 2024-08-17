package Add;

import java.io.File;
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AddProductServlet
 */
@WebServlet("/AddProductServlet")
@MultipartConfig  // This annotation is crucial for handling file uploads
public class AddProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "product_image";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductServlet() {
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
		 String name = request.getParameter("name");
	        String productType = request.getParameter("product_type");
	        String price = request.getParameter("price");
	        Part imagePart = request.getPart("image");

	        // Check if imagePart is not null and has a file
	        if (imagePart == null || imagePart.getSize() == 0) {
	            response.sendRedirect("admin.jsp?status=error&message=Image upload failed. Please select an image.");
	            return;
	        }

	        // Get the file name and save it to the server
	        String fileName = imagePart.getSubmittedFileName();
	        String imagePath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
	        File uploadDir = new File(imagePath);
	        if (!uploadDir.exists()) uploadDir.mkdir();
	        try {
	            imagePart.write(imagePath + File.separator + fileName);
	        } catch (IOException e) {
	            response.sendRedirect("admin.jsp?status=error&message=Failed to save image. " + e.getMessage());
	            return;
	        }
	        
	        // Save product details to database
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jewelrypalace", "root", "root");
	            String query = "INSERT INTO category (name, product_type, price, image) VALUES (?, ?, ?, ?)";
	            PreparedStatement stmt = conn.prepareStatement(query);
	            stmt.setString(1, name);
	            stmt.setString(2, productType);
	            stmt.setString(3, price);
	            stmt.setString(4, fileName);
	            stmt.executeUpdate();
	            stmt.close();
	            conn.close();
	            
	            response.sendRedirect("admin.jsp?status=success&message=Product added successfully.");
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendRedirect("admin.jsp?status=error&message=Database error occurred: " + e.getMessage());
	        }
	}

}
