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
                <input type="text" name="name" id="name" class="w-full p-2 border rounded-sm" required>
            </div>
            <div class="mb-4">
			    <label for="product_type" class="block text-lg font-semibold">Category :</label>
			    <select name="product_type" id="product_type" class="w-full p-2 border rounded-sm" required>
			        <option value="earring">Earring</option>
			        <option value="necklace">Necklace</option>
			        <option value="ring">Ring</option>
			        <option value="bracelet">Bracelet</option>
			    </select>
			</div>
            <div class="mb-4">
                <label for="price" class="block text-lg font-semibold">Price:</label>
                <input type="text" name="price" id="price" class="w-full p-2 border rounded-sm" required>
            </div>
            <div class="mb-4">
			    <label for="image" class="block text-lg font-semibold">Image:</label>
			    <div id="drop-zone" class="w-full p-2 border-dashed border-2 border-gray-300 rounded-sm flex items-center justify-center cursor-pointer bg-gray-50">
			        <span class="text-gray-400">Drag & drop an image here or click to select</span>
			    </div>
			    <input type="file" name="image" id="image" class="hidden" accept="image/*" required>
			</div>
			
			<!--  <div class="mb-4">
                <label for="image" class="block text-lg font-semibold">Image:</label>
                <input type="file" name="image" id="image" class="w-full p-2 border rounded" accept="image/*" required>
            </div> -->
			
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
<script>
    const dropZone = document.getElementById('drop-zone');
    const imageInput = document.getElementById('image');

    dropZone.addEventListener('click', () => {
        imageInput.click();
    });

    dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropZone.classList.add('border-blue-500');
    });

    dropZone.addEventListener('dragleave', () => {
        dropZone.classList.remove('border-blue-500');
    });

    dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropZone.classList.remove('border-blue-500');
        if (e.dataTransfer.files.length) {
            imageInput.files = e.dataTransfer.files;
            updateDropZone();
        }
    });

    imageInput.addEventListener('change', updateDropZone);

    function updateDropZone() {
        dropZone.innerHTML = ''; // Clear the drop zone content
        if (imageInput.files.length) {
            const file = imageInput.files[0];
            const reader = new FileReader();
            reader.onload = (e) => {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = 'Selected Image';
                img.classList.add('w-32', 'h-32', 'object-cover', 'rounded');
                dropZone.appendChild(img); // Display image inside the drop zone
            };
            reader.readAsDataURL(file);
        } else {
            const placeholder = document.createElement('span');
            placeholder.classList.add('text-gray-400');
            placeholder.textContent = 'Drag & drop an image here or click to select';
            dropZone.appendChild(placeholder);
        }
    }
</script>
</html>
