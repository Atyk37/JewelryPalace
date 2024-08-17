<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Product</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="fontawesomepro/css/all.min.css">
<link rel="icon" href="./logo/logo7.png">
</head>
<body class="bg-gray-100">
    <!-- nav bar & loginForm -->
    <div id="nav"></div>
    <section class="px-10 py-10 pt-20 pb-5">
        <h1 class="text-4xl font-bold mb-4">Add New Product</h1>
        <form action="AddProductServlet" method="post" enctype="multipart/form-data">
            <div class="mb-4">
                <label for="name" class="block text-lg font-semibold">Product Name:</label>
                <input type="text" name="name" id="name" class="w-full p-2 border rounded" required>
            </div>
            <div class="mb-4">
                <label for="product_type" class="block text-lg font-semibold">Product Type:</label>
                <input type="text" name="product_type" id="product_type" class="w-full p-2 border rounded" required>
            </div>
            <div class="mb-4">
                <label for="price" class="block text-lg font-semibold">Price:</label>
                <input type="text" name="price" id="price" class="w-full p-2 border rounded" required>
            </div>
            <div class="mb-4">
                <label for="image" class="block text-lg font-semibold">Image:</label>
                <input type="file" name="image" id="image" class="w-full p-2 border rounded" accept="image/*" required>
            </div>
            <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded">Add Product</button>
        </form>
    </section>
    
    <!-- footer section -->
    <div id="footer"></div>
  
    <!-- elf sight -->
    <script src="https://static.elfsight.com/platform/platform.js" data-use-service-core defer></script>
    <div class="elfsight-app-28c6dc95-5400-49df-a698-6341ed374307" data-elfsight-app-lazy></div>
</body>
<script src="navi.js"></script>
</html>
