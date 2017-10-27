$(document).ready(function() {
  // var startDate = document.getElementById('quote_start_date');
  // var endDate = document.getElementById('quote_completion_date_estimate');

  // startDate.addEventListener('change', function() {
  //   endDate.min = startDate.value;
  // })
  // Broken code

  // Get the modal
  var declineModal = document.getElementById('declined');

  var completedModal = document.getElementById('declined');

  // Get the button that opens the modal
  var declinedBtn = document.getElementById("declinedBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks on the button, open the modal 
  declinedBtn.onclick = function() {
    declineModal.style.display = "block";
  }

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
       modal.style.display = "none";
    }
  }

});

