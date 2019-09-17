document.addEventListener("turbolinks:load", function() {

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

// 	var Shots = {
// 		previewShot() {
// 			if (window.File && window.FileList && window.FileReader) {

// 				function handleFileSelect(evt) {
// 					evt.stopPropagation();
// 					evt.preventDefault();

// 					let files = evt.target.files || evt.dataTransfer.files;
// 					// files is a FileList of File objects. List some properties.
// 					for (var i = 0, f; f = files[i]; i++) {

// 						// Only process image files.
// 						if (!f.type.match('image.*')) {
// 							continue;
// 						}
// 						const reader = new FileReader();

// 						// Closure to capture the file information.
// 						reader.onload = (function(theFile) {
// 							return function(e) {
// 								// Render thumbnail.
// 								let span = document.createElement('span');
// 								span.innerHTML = ['<img class="thumb" src="', e.target.result,
// 									'" title="', escape(theFile.name), '"/>'
// 								].join('');
// 								document.getElementById('list').insertBefore(span, null);
// 							};
// 						})(f);

// 						// Read in the image file as a data URL.
// 						reader.readAsDataURL(f);
// 					}
// 				}

// 				function handleDragOver(evt) {
// 					evt.stopPropagation();
// 					evt.preventDefault();
// 					evt.dataTransfer.dropEffect = 'copy'; // Explicitly show this is a copy.
// 				}

// 				// Setup the dnd listeners.
// 				// https://stackoverflow.com/questions/47515232/how-to-set-file-input-value-when-dropping-file-on-page
// 				const dropZone = document.getElementById('drop_zone');
// 				const target = document.documentElement;
// 				const fileInput = document.getElementById('shot_s3_key');
// 				const previewImage = document.getElementById('previewImage');
// 				const newShotForm = document.getElementById('new_shot');


// 				if (dropZone) {
// 					dropZone.addEventListener('dragover', handleDragOver, false);
// 					dropZone.addEventListener('drop', handleFileSelect, false);

// 					// Drop zone classes itself
// 					dropZone.addEventListener('dragover', (e) => {
// 						dropZone.classList.add('fire');
// 					}, false);

// 					dropZone.addEventListener('dragleave', (e) => {
// 						dropZone.classList.remove('fire');
// 					}, false);

// 					dropZone.addEventListener('drop', (e) => {
// 						e.preventDefault();
// 						dropZone.classList.remove('fire');
// 						fileInput.files = e.dataTransfer.files;
// 						// if on shot/id/edit hide preview image on drop
// 						if (previewImage) {
// 							previewImage.style.display = 'none';
// 						}
// 						// If on shots/new hide dropzone on drop
// 						if(newShotForm) {
// 							dropZone.style.display = 'none';
// 						}
// 					}, false);

// 					// Body specific
// 					target.addEventListener('dragover', (e) => {
// 						e.preventDefault();
// 						dropZone.classList.add('dragging');
// 					}, false);

// 					// removes dragging class to body WHEN NOT dragging
// 					target.addEventListener('dragleave', (e) => {
// 						dropZone.classList.remove('dragging');
// 						dropZone.classList.remove('fire');
// 					}, false);

// 				}
// 			}
// 		},
// 		shotHover() {
// 			$('.shot').hover(function() {
// 				$(this).children('.shot-data').toggleClass('visible');
// 			});
// 		},

// 		updateFile() {

// 			document.getElementById('shot_s3_key').onchange = function () {
// 				document.getElementById('filename').innerHTML = this.value;
// 			};
// 		},
// 	};
// 	Shots.previewShot();
// 	Shots.shotHover();
// 	Shots.updateFile();
});
