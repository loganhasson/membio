$(function(){

  $(".form-control").focus(function () {
    $(this).closest(".textbox-wrap").addClass("focused");
  }).blur(function () {
    $(this).closest(".textbox-wrap").removeClass("focused");
  });

  $("#new_user").submit(function(event){
    var url = $(this).attr("action");

    $.post(url, $(this).serialize(), function(){});

    event.preventDefault();
  });

})