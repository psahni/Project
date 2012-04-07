// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function(){
        $('#search1 input#search').bind('focus', function(){
          if( jQuery(this).val() == "Search.."){
              jQuery(this).val('')
          }    
      });
})
