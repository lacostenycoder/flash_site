function MultipleFilesUploader(domElements){
  this.body = domElements.body;
  this.remove_class = domElements.remove_class;
  this.add_class = domElements.add_class;
}

MultipleFilesUploader.prototype.init = function(){
  this.onRemoveButtonClick();
  this.onAddButtonClick();
};

MultipleFilesUploader.prototype.onRemoveButtonClick = function(){
  this.body.on("click", this.remove_class, function(event){
    var $this = $(this);
    $this.prev('input[type=hidden]').val('1');
    $this.closest('fieldset').hide();
    event.preventDefault();
  });
};

MultipleFilesUploader.prototype.onAddButtonClick = function(){
  this.body.on("click", this.add_class, function(event){
    var $this = $(this);
    var time = new Date().getTime();
    var regexp = new RegExp($this.data('id'), 'g');
    $this.before($this.data('fields').replace(regexp, time));
    event.preventDefault();
  });
};
