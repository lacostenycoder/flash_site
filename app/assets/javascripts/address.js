function DynamicStateFinder(domElements){
  this.states_dropdown = domElements.state;
  this.country_dropdown = domElements.country;
}

DynamicStateFinder.prototype.init = function(){
  this.onSelectChange();
};

DynamicStateFinder.prototype.onSelectChange = function(){
  var _this = this;
  var states = this.states_dropdown.html();
  this.country_dropdown.on("change", function(event){
    var $this = $(this);
    var selected_country = $this.find(":selected").text();
    $(".state_text_field").remove();
    var options = $(states).filter("optgroup[label='" + selected_country + "']").html();
    if(options){
      _this.states_dropdown.attr('id', 'address_state_id');
      _this.states_dropdown.show().html(options);
    } else {
      _this.states_dropdown.removeAttr('id').hide();
      _this.states_dropdown.parents('div').eq(0).append($("<input type='text'>").addClass('state_text_field').attr('id', 'address_state_id'));
    }
  });
};


$(document).ready(function(){
  var domElements = {
    state: $('#address_state_id'),
    country: $('#address_country_id')
  };

  var dynamicStateFinder = new DynamicStateFinder(domElements);
  dynamicStateFinder.init();
});
