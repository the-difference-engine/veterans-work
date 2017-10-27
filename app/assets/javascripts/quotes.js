$(document).ready(function() {
  // var startDate = document.getElementById('quote_start_date');
  // var endDate = document.getElementById('quote_completion_date_estimate');

  // startDate.addEventListener('change', function() {
  //   endDate.min = startDate.value;
  // })
  // Broken code

  // Get the modal
  var declinedModal = document.getElementById('declined');
  var completedModal = document.getElementById('completed');

  // Get the button that opens the modal
  var declinedBtn = document.getElementById("declinedBtn");
  var completedBtn = document.getElementById("completedBtn");

  // Get the <span> element that closes the modal
  var declinedSpan = document.getElementsByClassName("close")[0];
  var completedSpan = document.getElementsByClassName("close")[1];

  // When the user clicks on the button, open the modal 
  declinedBtn.onclick = function() {
    declinedModal.style.display = "block";
  };
  completedBtn.onclick = function() {
    completedModal.style.display = "block";
  };

  // When the user clicks on <span> (x), close the modal
  declinedSpan.onclick = function() {
    declinedModal.style.display = "none";
  };
  completedSpan.onclick = function() {
    completedModal.style.display = "none";
  };

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == declinedModal) {
      declinedModal.style.display = "none";
    } else if (event.target == completedModal) {
      completedModal.style.display = "none";
    }
  };

});

