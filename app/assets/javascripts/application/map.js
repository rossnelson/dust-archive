
  document.load = gmap_init();
  function gmap_init() {

    geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: map, 
          position: results[0].geometry.location
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map, marker);
        });
      } 
    });

    var myOptions = {
      center: new google.maps.LatLng(-34.397, 150.644),
      zoom: 13,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map_canvas"),
        myOptions);

    var infowindow = new google.maps.InfoWindow({
        content: content
    });

  }