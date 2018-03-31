function PaymentHandler(domElements){
  this.form = domElements.form;
}

PaymentHandler.prototype.init = function(){
  this.onFormSubmit();
};

PaymentHandler.prototype.onFormSubmit = function(){
  var _this = this;
  this.form.on("submit", function(event){
    var $this = $(this);
    $this.find('.submit').prop('disabled', true);
    Stripe.card.createToken($this, _this.stripeResponseHandler);
    return false;
  });
};

PaymentHandler.prototype.stripeResponseHandler = function(status, response){
  var form = $('#payment-form');
  if(response.error) {
    form.find('.payment-errors').text(response.error.message);
    form.find('.submit').prop('disabled', false);
  } else {
    var stripe_token_field = $('<input type="hidden" name="stripeToken">').val(response.id)
    form.append(stripe_token_field);
    form.get(0).submit();
  }
};

$(document).ready(function(){
  var domElements = {
    form: $('#payment-form')
  };

  var payment_handler = new PaymentHandler(domElements);
  payment_handler.init();
});
