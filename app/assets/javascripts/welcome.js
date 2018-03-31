//= require slideshow_creator.js

$(document).ready(function(){

  var domElements = {
    image_class: '.myslides',
    container: $('.slideshow-container')
  }

  var slideshowCreator = new SlideshowCreator();
  slideshowCreator.init();
});
