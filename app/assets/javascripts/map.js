/* global $, google */
$(document).ready(function() {
  initMap;
});

var initMap = function(lat, lng, hasPermissions) {
  var requestCoords = new google.maps.LatLng(lat, lng);
  var map = new google.maps.Map(document.getElementById('customer-request-map'), {
    zoom: 14,
    center: requestCoords
  });
  if (hasPermissions) {
    var marker = new google.maps.Marker({
      position: requestCoords,
      map: map
    });
  } else {
    marker = new google.maps.Circle({
      center: requestCoords,
      radius: 1000,
      map: map
    });
  }
};