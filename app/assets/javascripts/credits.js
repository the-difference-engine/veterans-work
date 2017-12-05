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
    console.log(quantity.value * quantity.dataset.creditCost);
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })
  quantity.addEventListener('keyup', function() {
    console.log(quantity.value * quantity.dataset.creditCost);
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })
  quantity.addEventListener('click', function() {
    console.log(quantity.value * quantity.dataset.creditCost);
    subtotal.innerHTML = '$' + (quantity.value * quantity.dataset.creditCost).toFixed(2);
  })

});

