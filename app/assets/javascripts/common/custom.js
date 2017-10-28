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
});
