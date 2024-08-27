<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>

<%
    // No need to declare 'session' again; it is already available.
    // Retrieve the payment method and account phone from the session
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    String paymentAccountPhone = (String) session.getAttribute("paymentAccountPhone");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receipt</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link your CSS file here -->
</head>
<body>
    <h1>Receipt</h1>
    <p><strong>Payment Method:</strong> <%= paymentMethod != null ? paymentMethod : "N/A" %></p>
    <p><strong>Account Phone:</strong> <%= paymentAccountPhone != null ? paymentAccountPhone : "N/A" %></p>

    <a href="index.jsp">Return to Home</a> <!-- Link to return to home page -->
</body>
</html>
