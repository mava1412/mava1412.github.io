// $(document).ready(function() {
//   $(".menu-icon").on("click", function() {
//     $("nav ul").toggleClass("showing");
//   });
// });
//
// $(window).on("scroll", function() {
//   if($(window).scrollTop()) {
//     $('nav').addClass('black');
//   }
//   else {
//     $('nav').removeClass('black');
//   }
// })


const navSlide = () => {
  const burger = document.querySelector('.burger');
  const nav = document.querySelector('.nav-links');
  const navLinks = document.querySelectorAll('.nav-links li');

  burger.addEventListener('click', () => {
    // toggle nav
    nav.classList.toggle('nav-active');

    // animate links
    navLinks.forEach((link,index) => {
      // 0.3 is the initial delay animation of the 1st li
      if (link.style.animation) {
        link.style.animation = '';
      } else {
        link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.3}s`
      }
    });
    // burger animation
    burger.classList.toggle('toggle');

  });

}

// const app = () => {
  navSlide();
// }