function FileUploader(domElements){
  this.body = domElements.body;
}

FileUploader.prototype.init = function(){
  this.onRemoveButtonClick();
  this.onAddButtonClick();
}

FileUploader.prototype.onRemoveButtonClick =function(){
  this.body.on("click", '.remove_image', function(event){
    var $this = $(this);
    $this.prev('input[type=hidden]').val('1');
    $this.closest('fieldset').hide();
    event.preventDefault();
  });
}

FileUploader.prototype.onAddButtonClick = function(){
  this.body.on("click", '.add_images', function(event){
    var $this = $(this);
    time = new Date().getTime();
    regexp = new RegExp($this.data('id'), 'g');
    $this.before($this.data('fields').replace(regexp, time));
    event.preventDefault();
  });
}

$(document).ready(function(){
  domElements = {
    body: $('body')
  }
  var imageCreator = new FileUploader(domElements);
  imageCreator.init();
})
