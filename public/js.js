// smooth scroll
// Select all links with hashes
$('a[href*="#"]')
  // Remove links that don't actually link to anything
  .not('[href="#"]')
  .not('[href="#0"]')
  .click(function(event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
      &&
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top-100
        }, 800, function() {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });


// collapse navbar upon clicking link
$(document).on('click','.navbar-collapse.in',function(e) {
    if( $(e.target).is('a') ) {
        $(this).collapse('hide');
    }
});


// collapse navbar upon clicking outside of menu
$(document).click(function(e) {
    if (!$(e.target).is('a')) {
        $('.collapse').collapse('hide');
    }
});



// var path = document.querySelector('.animated-spiral');
// var length = path.getTotalLength();
// // Clear any previous transition
// path.style.transition = path.style.WebkitTransition =
//   'none';
// // Set up the starting positions
// path.style.strokeDasharray = length + ' ' + length;
// path.style.strokeDashoffset = length;
// // Trigger a layout so styles are calculated & the browser
// // picks up the starting position before animating
// path.getBoundingClientRect();
// // Define our transition
// path.style.transition = path.style.WebkitTransition =
//   'stroke-dashoffset 2s ease-in-out';
// // Go!
// path.style.strokeDashoffset = '0';
//
// @keyframes.style.stroke-dashoffset = {
//   0%   { stroke-dashoffset: 1230;}
//   50%  { stroke-dashoffset: 0;}
//   100% { stroke-dashoffset: 1230; }
// }
