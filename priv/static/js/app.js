$.getJSON('/api/get/castle', function(json) {
	items = $.parseJSON(json);
	$.each(items, function(index, item) {
		$("#page").append('<a href="'+ item +'">'+ item +'</a><br>');
	});
});

