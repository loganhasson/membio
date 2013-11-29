$(function(){

  $("#new_user").submit(function(event){
    var url = $(this).attr("action");

    $.post(url, $(this).serialize(), function(){});

    event.preventDefault();
  });

})