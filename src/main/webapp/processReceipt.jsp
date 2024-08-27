<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    String paymentMethod = request.getParameter("paymentMethod");
    String paymentAccountPhone = request.getParameter("paymentAccountPhone");

    // Store the receipt details in session
    session.setAttribute("paymentMethod", paymentMethod);
    session.setAttribute("paymentAccountPhone", paymentAccountPhone);
    
    // Redirect to the receipt page
    response.sendRedirect("receipt.jsp");
%>
</body>
</html>