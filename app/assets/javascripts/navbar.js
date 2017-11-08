function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
  var overlays = document.getElementsByClassName("overlay");
  for (var i = 0; i < overlays.length; i++) {
    overlays[i].style.backgroundColor = "rgba(0,0,0,0.5)";
  }
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
  var overlays = document.getElementsByClassName("overlay");
  for (var i = 0; i < overlays.length; i++) {
    overlays[i].style.backgroundColor = "transparent";
  }
}


