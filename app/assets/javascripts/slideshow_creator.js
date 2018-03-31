function SlideshowCreator(domElements){
  this.currentIndex = 0;
  this.image_class = domElements.image_class;
  this.container = domElements.container;
}

SlideshowCreator.prototype.hideOtherImagesExcept = function(images){
  images.hide();
  images.eq(this.currentIndex).show();
}

SlideshowCreator.prototype.onClickFunction = function(index, direction){
  images = this.getImages(index);
  this.currentIndex = (this.currentIndex + direction) % images.length;
  if (this.currentIndex < 0) {
    this.currentIndex += images.length
  }
  this.hideOtherImagesExcept(images);
}

SlideshowCreator.prototype.clickArrowButtonsFunctionality = function(index){
  var _this = this;
  var prevButton = this.parents.eq(index).children(".prev");
  var nextButton = this.parents.eq(index).children(".next");

    prevButton.on("click", function(){
      _this.onClickFunction(index, -1);
    });

  nextButton.on("click", function(){
      _this.onClickFunction(index, 1);
  })
}

SlideshowCreator.prototype.getImages = function(index){
  return this.parents.eq(index).children(this.image_class);
}

SlideshowCreator.prototype.init = function(){
  var prevButton = $("<a>").html("&#10094;").addClass("prev");
  var nextButton = $("<a>").html("&#10095;").addClass("next");
  this.container.append(prevButton).append(nextButton);
  this.parents = $(".prev").parent();

  for(var i = 0; i < this.parents.length; i++){
    this.hideOtherImagesExcept(this.getImages(i));
    this.clickArrowButtonsFunctionality(i);
  }
}
