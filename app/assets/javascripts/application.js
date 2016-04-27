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
//= require jquery-ui
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require autocomplete-rails
//= require jquery_nested_form

$(document).ready(function(){

  var field_keyword      = $(".field_keyword"); //Fields field_keyword
  var add_button_keyword = $(".add_field_keyword"); //Add button ID
  
  $(add_button_keyword).click(function(e){ //on add input button click
      $(field_keyword).append('<div><input type="text" name="article[keywords][]" id="doc_words_" value="" class="form-word" placeholder="" /><a href="#" class="remove_field_keyword">Remove</a></div>'); //add input box
  });

  $(field_keyword).on("click",".remove_field_keyword", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('div').remove();
  })

  //////// author ////////////
  var author_field      = $(".author_field"); //Fields field_keyword
  var add_field_author  = $(".add_field_author"); //Add button ID
  
  $(add_field_author).on("click", null, function () {
    count_author++;
    $(author_field).append('<div class="form-group"><input type="text" name="article[author_name][]" id="author_'+count_author+'" value="" class="text-search-query form-word" /> <input type="hidden" name="article[author_ids][]" id="val_author_'+count_author+'" class ="val-search-query" ><a href="#" class="remove_field_author">Remove</a></div>'); //add input box
     action_autocomeplete();
  });

  $(author_field).on("click",".remove_field_author", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('div').remove();
  })

  action_autocomeplete();
  console.log(count_author);
  /////// auto-complete ///////

  function action_autocomeplete(){
    for(var i = 0 ; i < count_author ; i++){
      $('#author_'+count_author).autocomplete({
        source : function (request, response) {

          var text_search = $("#author_" + i ).val();
          console.log($("#author_" + i ));
          console.log(text_search);

          $.ajax({
            dataType: "json",
            type: 'Get',
            url: "/articles/autocomplete_article_name?term=" + text_search,
            success: function(data){
              // console.log(data);
              response($.map( data, function(item) {
                return {
                    label: item.author_name,
                    value: item.id
                };
              })); 
            }
          });
        },
        select: function( event, ui ) {
          console.log(ui);
          $("#author_" + i).val( ui.item.label);
          $("#val_author_" + i ).val( ui.item.value);
          return false;
        },
        focus: function(event, ui) {
          $("#author_" + i ).val(ui.item.label);
          $("#val_author_" + i ).val( ui.item.value);
          return false;
        }
      });
    } //for
  }



});
  function remove_fields(link) {  
      // $(link).previous("input[type=hidden]").value = "1";  
      // $(link).up(".fields").hide();  
    // 1
    $(link).prevAll("input[type=hidden]").first().val("1");

    // 2
    $(link).closest(".fields").hide();
    // Or: $(link).parents(".fields").first().hide();
    // Or: $(link).parent().closest(".fields").first().hide();

  }