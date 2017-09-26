$(document).ready(function() {
  var startDate = document.getElementById('quote_start_date');
  var endDate = document.getElementById('quote_completion_date_estimate');

  startDate.addEventListener('change', function() {
    endDate.min = startDate.value;
  })
});