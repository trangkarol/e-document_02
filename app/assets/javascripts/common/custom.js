$(document).ready(function () {
  $('#file-document').bind('change', function() {
    var extensions = ["pdf", "xls"];
    var extension = $(this).val().replace(/^.*\./, '');
    if ($.inArray(extension, extensions) == -1) {
      alert(I18n.t("document.messages_extension_error", {name: extensions.join(', ')}));
    }
  });

  $('#images').bind('change', function() {
    var extensions = ["jpg", "gif", "jpeg", "png"];
    var extension = $(this).val().replace(/^.*\./, '');
    if ($.inArray(extension, extensions) == -1) {
      alert(I18n.t("document.messages_extension_error", {name: extensions.join(', ')}));
    }
  });
  //-- Click on detail
  $("ul.menu-items > li").on("click",function(){
    $("ul.menu-items > li").removeClass("active");
    $(this).addClass("active");
  });

  $(".attr,.attr2").on("click",function(){
    var clase = $(this).attr("class");

    $("." + clase).removeClass("active");
    $(this).addClass("active");
  });

  //-- Click on QUANTITY
  $(".btn-minus").on("click",function(){
    var now = $(".section > div > input").val();
    if ($.isNumeric(now)){
        if (parseInt(now) -1 > 0){ now--;}
        $(".section > div > input").val(now);
    }else{
        $(".section > div > input").val("1");
    }
  });

  $(".btn-plus").on("click",function(){
    var now = $(".section > div > input").val();
    if ($.isNumeric(now)){
      $(".section > div > input").val(parseInt(now)+1);
    }else{
      $(".section > div > input").val("1");
    }
  });
});
