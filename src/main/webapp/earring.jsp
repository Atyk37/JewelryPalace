<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earrings</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="flex flex-wrap justify-center gap-16 p-20">
    <% 
        ResultSet rs = (ResultSet) request.getAttribute("resultSet");
        if (rs != null) {
            while (rs.next()) {
                String name = rs.getString("name");
                String imagePath = rs.getString("image");
                double price = rs.getDouble("price");
    %>
        <div class="w-80 h-96 relative mb-7 inline-block">
            <div>
                <i class="heart-icon fa-lg fal fa-heart cursor-pointer absolute top-3 right-2 text-white"></i>
                <img class="w-80 h-96 object-cover" src="./<%= imagePath %>" alt="<%= name %>">
            </div>
            <div class="font-mono font-medium">
                <p class="font-bold pt-1"><a href="itemdetails.html"><%= name %></a></p>
                <p><%= price %> kyats</p>
            </div>
        </div>
    <% 
            }
        }
    %>
</body>
</html>
