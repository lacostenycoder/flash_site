//= require ../../multiple_files_uploader

$(document).ready(function(){
  domElements = {
    body: $('body'),
    remove_class: '.remove_image',
    add_class: '.add_images'
  }
  var imageUploader = new MultipleFilesUploader(domElements);
  imageUploader.init();
});
