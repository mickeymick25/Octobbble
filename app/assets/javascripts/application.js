// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree .

document.addEventListener('DOMContentLoaded', () => {

  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach( el => {
      el.addEventListener('click', () => {

        // Get the target from the "data-target" attribute
        const target = el.dataset.target;
        const $target = document.getElementById(target);

        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        el.classList.toggle('is-active');
        $target.classList.toggle('is-active');

      });
    });
  }

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
        paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
        dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
        replaceFileInput: false,
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


