$(function(){

  function getCookie(c_name)
    {
    var c_value = document.cookie;
    var c_start = c_value.indexOf(" " + c_name + "=");
    if (c_start == -1)
      {
      c_start = c_value.indexOf(c_name + "=");
      }
    if (c_start == -1)
      {
      c_value = null;
      }
    else
      {
      c_start = c_value.indexOf("=", c_start) + 1;
      var c_end = c_value.indexOf(";", c_start);
      if (c_end == -1)
      {
    c_end = c_value.length;
    }
    c_value = unescape(c_value.substring(c_start,c_end));
    }
    return c_value;
  };

  $('#error').hide();

  $(".form-control").focus(function () {
    $(this).closest(".textbox-wrap").addClass("focused");
  }).blur(function () {
    $(this).closest(".textbox-wrap").removeClass("focused");
  });

  $('#text-input').focus();

  $("#new_user").submit(function(event){
    var url = $(this).attr("action");

    $.post(url, $(this).serialize(), function(){
      if (getCookie("error") != null) {
        var errorMessage = getCookie("error").split("+").join(" ");
        $('#error').fadeIn("slow").text(errorMessage+".");
      };
    });

    event.preventDefault();
  });

})