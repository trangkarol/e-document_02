$(document).ready(function () {
  $(document).on('keypress', '.commet-form', function (e) {
    e.preventDefault();
    if(e.which == 13) {
      var content = $('.commet-form').val();
      var url = $('.url_comment').val();
      var document_id = $('.document_id').val();
      $.ajax({
        type: 'POST',
        url: url,
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name='csrf-token']').attr('content'))},
        dataType: 'json',
        data: {
          content: content,
          document_id: document_id,
        },
        success:function(data) {
          if (data.status) {
            $('#form_comment').prepend(data.html);
            $('.commet-form').prop('value', '');
          } else {
            alert(I18n.t("comment.create_fail"))
          }
        }
      });
    }
  });
});
