$(document).ready(function(){
  $('form').on('click', '.remove_image', function(event){
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()
  });

  $('form').on('click', '.add_images', function(event){
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
  });
});
