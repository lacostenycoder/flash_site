function ImageCreator(domElements){
  this.form = domElements.form;
  this.removeButton = domElements.removeButton;
  this.addButton = domElements.addButton;
}

ImageCreator.prototype.init = function(){
  this.addRemoveButtonFunctionality();
  this.addAddButtonFunctionality();
}

ImageCreator.prototype.addRemoveButtonFunctionality =function(){
  this.removeButton.on("click", function(event){
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault();
  });
}

ImageCreator.prototype.addAddButtonFunctionality = function(){
  this.addButton.on("click", function(event){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault();
  });
}


$(document).ready(function(){
  domElements = {
    form: $('form'),
    removeButton: $('form').find('.remove_image'),
    addButton: $('form').find('.add_images')
  }

  var imageCreator = new ImageCreator(domElements);
  imageCreator.init();
})



