$(document).ready(function(){
  var field_keyword      = $(".field_keyword"); //Fields field_keyword
  var add_button_keyword = $(".add_field_keyword"); //Add button ID
  
  $(add_button_keyword).click(function(e){ //on add input button click
      e.preventDefault();
      $(field_keyword).append('<div><input type="text" name="article[keywords][]" id="doc_words_" value="" class="form-word" placeholder="" /><a href="#" class="remove_field_keyword">Remove</a></div>'); //add input box
  });

  $(field_keyword).on("click",".remove_field_keyword", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('div').remove();
  })
});
