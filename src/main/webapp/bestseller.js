/**
 * 
 */
 
 const bestSeller = document.getElementById("bestseller");
 
 const bestSellerInnerHTML = `
 	<section>
    <div class="py-10 ml-10 tracking-widest rounded-2xl">
      <p class="text-5xl ml-10 font-semibold font-mono">BEST SELLERS</p>
      <div class="scrollbar-hidden flex py-10 px-0 ml-10 bg-slate-50 overflow-x-auto">
        <div id="bestsellers" class="flex whitespace-nowrap space-x-12">

        
          <div class="w-80 h-96 relative mb-7 inline-block">
              <div>
                <i class="heart-icon fa-lg fal fa-heart cursor-pointer absolute top-3 right-2 text-white"></i>
                <img class="w-80 h-96 object-cover" src="./product_image/earring1.jpg" alt="Earrings DE-3426">
              </div>
              <div class="font-mono font-medium">
              	<p class="font-bold pt-1"><a href="itemDetail.jsp">ER-0001</a></p>
                <p>3130000 kyats</p>
              </div>
          </div>

        </div>
      </div>
    </div>
  </section>
 `;
 
 bestSeller.innerHTML = bestSellerInnerHTML;
 
 