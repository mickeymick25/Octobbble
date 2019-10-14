document.addEventListener("turbolinks:load", function() {

  $(".zoomable").click(function() {
    var clickedImageSource = $(this).attr('src')
    $("#modal_image").attr("src", clickedImageSource);
    $(".modal").addClass("is-active");
    $("html").addClass("is-clipped");
  });

  $(".modal-close").click(function() {
     $(".modal").removeClass("is-active");
     $("html").removeClass("is-clipped");
  });

  $(".modal-background").click(function() {
     $(".modal").removeClass("is-active");
     $("html").removeClass("is-clipped");
  });

  $(function() {
    $('.directUpload').find("input:file").each(function(i, elem) {

      var fileInput    = $(elem);
      var form         = $(fileInput.parents('form:first'));
      var submitButton = form.find('input[type="submit"]');
      var progressBar  = $("<div class='bar'></div>");
      var barContainer = $("<div class='progress'></div>").append(progressBar);

      fileInput.after(barContainer);
      fileInput.fileupload({

        fileInput:       fileInput,
        url:             form.data('url'),
        type:            'POST',
        autoUpload:       true,
        formData:         form.data('form-data'),
        paramName:        'file',
        dataType:         'XML',
        replaceFileInput: false,
        imageOrientation: true,

        progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          progressBar.css('width', progress + '%')
        },

        start: function (e) {
          submitButton.prop('disabled', true);
          progressBar.
            css('background', 'green').
            css('display', 'block').
            css('width', '0%').
            text("Upload en cours...");
        },

        done: function(e, data) {

          var fileMimeTypeInput = $("<input />", { type:'hidden', name: 'shot[mime_type]', value: data.files[0].type })
          form.append(fileMimeTypeInput);

          submitButton.prop('disabled', false);
          progressBar.text("Upload fini");

          // extract key and generate URL from response
          var key   = $(data.jqXHR.responseXML).find("Key").text();

          // create hidden field
          var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: key })
          form.append(input);
        },

        fail: function(e, data) {
          submitButton.prop('disabled', false);
          progressBar.
            css("background", "red").
            text("Failed");
        }
      });
    });
  });
});
