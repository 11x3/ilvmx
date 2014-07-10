App = Ember.Application.create();

$.getJSON('/lolnub', function(json) {
  $("#page").append('<div class="row">'+ json +'</div>');
});

