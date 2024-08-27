package Submit;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SubmitReviewServlet
 */
@WebServlet("/SubmitReviewServlet")
public class SubmitReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/jewelrypalace";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public SubmitReviewServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loadReviews(request, response, "id DESC"); // Load reviews in ascending order by ID
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            if ("delete".equals(action)) {
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                String deleteSql = "DELETE FROM review WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, reviewId);
                pstmt.executeUpdate();
                out.println("Deleted review with ID: " + reviewId);
            } else {
                String reviewContent = request.getParameter("reviewContent");
                String username = session.getAttribute("username").toString();

                String insertSql = "INSERT INTO review (user_name, content) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, username);
                pstmt.setString(2, reviewContent);
                pstmt.executeUpdate();
                out.println("Inserted review for user: " + username);
            }

            loadReviews(request, response, "id DESC"); // Reload reviews after insert or delete

        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred: " + e.getMessage());
        } finally {
            closeResources(pstmt, conn);
        }
    }

    // Load reviews method with dynamic sorting
    private void loadReviews(HttpServletRequest request, HttpServletResponse response, String orderBy) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM review ORDER BY " + orderBy; // Use orderBy parameter for flexibility
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            List<Review> reviews = new ArrayList<>();

            while (rs.next()) {
                Review review = new Review();
                review.setId(rs.getInt("id"));
                review.setUserName(rs.getString("user_name"));
                review.setContent(rs.getString("content"));
                review.setCreatedAt(rs.getTimestamp("created_at"));
                reviews.add(review);
            }

            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(rs, pstmt, conn);
        }
    }

    // Helper method to close database resources
    private void closeResources(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            try {
                if (resource != null) resource.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
