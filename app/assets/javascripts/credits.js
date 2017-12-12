$(document).ready(function() {

  // Get the modal
  var creditModal = document.getElementById('credit');

  // Get the button that opens the modal
  var creditBtn = document.getElementById("creditBtn");

  // Get the <closedModal> element that closes the modal
  var closedModals = document.getElementsByClassName("close");

  // When the user clicks on the button, open the modal
  if (creditBtn != null) {
    creditBtn.onclick = function() {
      creditModal.style.display = "block";
    };
  }

  // When the user clicks on <closedModal> (x), close the modal

  for (var i = 0; i < closedModals.length; i++) {
    closedModals[i].onclick = function() {
      this.closest(".modal").style.display = "none";
    };
  }

  var checkoutTotal = 5;

  // When the user clicks anywhere outside of the modal, close it

  window.onclick = function(event) {
    if (event.target == creditModal) {
      creditModal.style.display = "none";
    }
  };

  var quantity = document.getElementById('credit-quantity');
  var subtotal = document.getElementById('credit-subtotal');
  // var creditCost = window.creditCost = '{{env('CREDIT_COST')}}';

  quantity.addEventListener('change', function() {
    checkoutTotal = quantity.value * quantity.dataset.creditCost;
    console.log(quantity.dataset.companyId);
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })
  quantity.addEventListener('keyup', function() {
    checkoutTotal = quantity.value * quantity.dataset.creditCost;
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })
  quantity.addEventListener('click', function() {
    checkoutTotal = quantity.value * quantity.dataset.creditCost;
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })
// THIS IS WHAT COMMUNICATES WITH PAYPAL

paypal.Button.render({
  env: 'sandbox', // Or 'sandbox',

  client: {
    sandbox:    'AahhvpJhVNinS5Rw9NZxLToVPGGTIMeO4ANQou-h5OpiAoOmtr1eQ_zVAccpj4tLbtmCdmC7GurpaRhg',
    production: 'PAYPAL_PRODUCTION_CLIENT_ID'
  },

  payment: function(data, actions) {
    return actions.payment.create({
      payment: {
        transactions: [{
          amount: {
            total: checkoutTotal,
            currency: 'USD'
          }
        }]
      }
    });
  },

  onAuthorize: function(data, actions) {
    console.log("Company ID = " + quantity.dataset.companyId);
    console.log("Credit Quantity = " + quantity.value);
    console.log((checkoutTotal).toFixed(2));

    $.post('/orders', {
      companyId: quantity.dataset.companyId,
      quantity: quantity.value,
      total: (checkoutTotal).toFixed(2)
    });
    creditModal.style.display = "none";
    window.alert('Yay, credits were added');
    // You'll implement this callback later when you're
    // ready to execute the payment
  }
}, '#paypal-button');

});

