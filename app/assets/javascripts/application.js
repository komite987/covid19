// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require popper
//= require bootstrap
//= require turbolinks
//= require rails-ujs

//= require_tree .

$().ready(function(){
  $('[rel="tooltip"]').tooltip();
});

function rotateCard(btn){
  var $card = $(btn).closest('.card-container');
  console.log($card);
  if($card.hasClass('hover')){
    $card.removeClass('hover');
  } else {
    $card.addClass('hover');
  }
}

$( document ).on('turbolinks:load', function() {
  $("#container1").twentytwenty();
});

$( document ).on('turbolinks:load', function() {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('.img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    $('.img_prev').removeClass('hidden');
    readURL(this);
  });
});

