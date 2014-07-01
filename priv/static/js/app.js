App = Ember.Application.create();

$.getJSON('/api/get/castle', function(json) {
	items = $.parseJSON(json);
	$.each(items, function(index, item) {
		$("#page").append('<div class="row"><a class="" href="'+ item +'">'+ item +'</a></div>');
	});
});

