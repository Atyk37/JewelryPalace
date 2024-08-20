<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Jewelry Palace</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="fontawesomepro/css/all.min.css">
  <link rel="icon" href="./logo/logo7.png">
  
  <style>

    /* Hide horizontal scrollbar for WebKit browsers (Chrome, Safari) */
    .scrollbar-hidden::-webkit-scrollbar {
      display: none;
    }

    /* Hide scrollbar for Firefox */
    .scrollbar-hidden {
      overflow-x: auto;
      scrollbar-width: none;
    }

    /* Hide scrollbar for IE and Edge */
    
    .scrollbar-hidden {
      -ms-overflow-style: none;
    }

  </style>
  
</head>
<body>

  <!-- nav bar & loginForm -->
  <div id="nav"></div>

  <!-- home page -->
  <div id="home"></div>
  
  <!-- BEST SELLERS -->  
    <section>
        <div class="py-10 ml-10 tracking-widest rounded-2xl">
            <p class="text-5xl ml-10 font-semibold font-mono">BEST SELLERS</p>
            <div class="scrollbar-hidden flex py-10 px-0 ml-10 bg-slate-50 overflow-x-auto">
                <div id="bestsellers" class="flex whitespace-nowrap space-x-12">

                    <%
                        String url = "jdbc:mysql://localhost:3306/jewelrypalace"; 
                        String user = "root"; 
                        String password = "root"; 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(url, user, password);
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM product ORDER BY id LIMIT 10"; 
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String productId = rs.getString("name");
                                String productImage = rs.getString("image");
                                String productPrice = rs.getString("price");
                    %>
                                <div class="w-80 h-96 relative mb-7 inline-block">
                                    <div>
                                        <i class="heart-icon fa-lg fal fa-heart cursor-pointer absolute top-3 right-2 text-white"></i>
                                        <img class="w-80 h-96 object-cover" src="./product_image/<%= productImage %>" alt="<%= productId %>">
                                    </div>
                                    <div class="font-mono font-medium">
                                        <p class="font-bold pt-1"><a href="itemDetail.jsp"><%= productId %></a></p>
                                        <p><%= productPrice %> kyats</p>
                                    </div>
                                </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace(); 
                        } finally {

                        	try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </section>

  <!-- footer section  -->
  <div id="footer"></div>
  
  <!-- elf sight  -->
  <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
  <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
	

</body>
<script src="navi.js"></script>
<script src="home.js"></script>
<!-- <script src="bestseller.js"></script> -->
<script>


	
</script>

</html>