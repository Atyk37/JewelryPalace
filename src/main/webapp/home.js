/**
 * 
 */
 
 const navContainer = document.getElementById("home");
 
 const navInnerHTML = `
 	<section>

    <!-- Carousel Banner -->
    <div class="carousel">
      <div class="carouselItem">
        <img class=" w-full h-[800px]" src="./item/background1.jpg" alt="Logo 1">
      </div>
      <div class="carouselItem">
        <img class=" w-full h-[800px]" src="./item/background3.jpg" alt="Logo 2">
      </div>
      <div class="carouselItem">
        <img class=" w-full h-[800px]" src="./item/background2.jpg" alt="Logo 3">
      </div>
    </div>

    <!-- item list -->
    <div class=" flex pb-10">

      <!-- Best Sellers -->
      <div class=" relative w-96 h-96 border border-slate-950 overflow-hidden group">
        <a href="bestseller.jsp">

        <img class="object-cover w-full h-full transition-opacity duration-300 ease-in-out group-hover:opacity-0" src="./item/bestseller.jpg" alt="BestSeller">
      
        <div class="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <img class="object-cover w-full h-full" src="./item/bestseller1.jpg" alt="BestSeller Hover">
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 bg-slate-950 py-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <span class="text-xl text-slate-50 font-bold tracking-[10px]">BESTSELLERS</span>
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 text-left py-4">
          <span class="text-xl text-slate-950 font-bold tracking-[10px] transition-opacity duration-300 ease-in-out group-hover:opacity-0">
            BESTSELLERS
          </span>
        </div>
        </a>
      </div>

      <!-- Earrings -->
      <div class="relative w-96 h-96 border border-slate-950 overflow-hidden group">
        <a href="earring.jsp">

        <img class="object-cover w-full h-full transition-opacity duration-300 ease-in-out group-hover:opacity-0" src="./item/earring.jpg" alt="Earrings">
      
        <div class="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <img class="object-cover w-full h-full" src="./item/earring1.jpg" alt="Earrings Hover">
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 bg-slate-950 py-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <span class="text-xl text-slate-50 font-bold tracking-[10px]">EARRINGS</span>
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 text-left py-4">
          <span class="text-xl text-slate-950 font-bold tracking-[10px] transition-opacity duration-300 ease-in-out group-hover:opacity-0">
            EARRINGS
          </span>
        </div>
        </a>
      </div>

      <!-- Rings -->
      <div class="relative w-96 h-96 border border-slate-950 overflow-hidden group">
        <a href="ring.jsp">

        <img class="object-cover w-full h-full transition-opacity duration-300 ease-in-out group-hover:opacity-0" src="./item/ring.jpg" alt="Rings">
      
        <div class="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <img class="object-cover w-full h-full" src="./item/ring1.jpg" alt="Rings Hover">
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 bg-slate-950 py-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <span class="text-xl text-slate-50 font-bold tracking-[10px]">RINGS</span>
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 text-left py-4">
          <span class="text-xl text-slate-950 font-bold tracking-[10px] transition-opacity duration-300 ease-in-out group-hover:opacity-0">
            RINGS
          </span>
        </div>
        </a>
      </div>

      <!-- Bracelets -->
      <div class="relative w-96 h-96 border border-slate-950 overflow-hidden group">
        <a href="bracelet.jsp">

        <img class="object-cover w-full h-full transition-opacity duration-300 ease-in-out group-hover:opacity-0" src="./item/bracelet.jpg" alt="Bracelets">
      
        <div class="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <img class="object-cover w-full h-full" src="./item/bracelet1.jpg" alt="Bracelets Hover">
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 bg-slate-950 py-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <span class="text-xl text-slate-50 font-bold tracking-[10px]">BRACELETS</span>
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 text-left py-4">
          <span class="text-xl text-slate-950 font-bold tracking-[10px] transition-opacity duration-300 ease-in-out group-hover:opacity-0">
            BRACELETS
          </span>
        </div>
        </a>
      </div>

      <!-- Necklaces -->
      <div class="relative w-96 h-96 border border-slate-950 overflow-hidden group">
        <a href="necklace.jsp">

          <img class="object-cover w-full h-full transition-opacity duration-300 ease-in-out group-hover:opacity-0" src="./item/necklace.jpg" alt="Necklaces">
      
        <div class="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <img class="object-cover w-full h-full" src="./item/necklace1.jpg" alt="Necklaces Hover">
        </div>
        
        <div class="pl-2 absolute inset-x-0 bottom-0 bg-slate-950 py-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
          <span class="text-xl text-slate-50 font-bold tracking-[10px]">NECKLACES</span>
        </div>
        
        <div class=" pl-2 absolute inset-x-0 bottom-0 text-left py-4">
          <span class="text-xl text-slate-950 font-bold tracking-[10px] transition-opacity duration-300 ease-in-out group-hover:opacity-0">
            NECKLACES
          </span>
        </div>
        </a>
      </div>

    </div>

  </section>
 `;
 
navContainer.innerHTML = navInnerHTML;
 

// carousel banner
document.addEventListener('DOMContentLoaded', function() {
  const slides = document.getElementsByClassName('carouselItem');
  if (slides.length === 0) {
    console.error('No elements with class "carouselItem" found.');
    return;
  }

  let curSlide = 1;

  function carousel() {
    if (curSlide > slides.length) {
      curSlide = 1;
    } else if (curSlide < 1) {
      curSlide = slides.length;
    }

    for (let i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
    }

    slides[curSlide - 1].style.display = "block";
  }

  carousel();

  function nextSlide() {
    curSlide++;
    carousel();
  }

  setInterval(nextSlide, 3000);
});



