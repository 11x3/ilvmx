$.getJSON("http://localhost:8080/signals", function( data ) {
  $.each( data, function( item ) {
    $("ul#signals").append( "<li>" + item + "</li>" );
  });
});

