// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery.turbolinks

$(document).ready(function(){
  var field_keyword      = $(".field_keyword"); //Fields field_keyword
  var add_button_keyword = $(".add_field_keyword"); //Add button ID
  
  $(add_button_keyword).click(function(e){ //on add input button click
      $(field_keyword).append('<div><input type="text" name="article[keywords][]" id="doc_words_" value="" class="form-word" placeholder="" /><a href="#" class="remove_field_keyword">Remove</a></div>'); //add input box
  });

  $(field_keyword).on("click",".remove_field_keyword", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('div').remove();
  })
});
