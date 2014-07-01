window.App = Ember.Application.create();


// Store

App.ApplicationAdapter = DS.FixtureAdapter;


// Item

App.Item = DS.Model.extend({
  name         : DS.attr(),
  code    		 : DS.attr(),
	data				 : DS.attr(),
  creationDate : DS.attr()
});

App.Item.FIXTURES = [{
  id: 1,
  name: 'program.dab',
  code: '#todo',
  data: '.todo',
  creationDate: 'Mon, 26 Aug 2013 20:23:43 GMT'
}];


// Router

App.Router.map(function(){
	this.resource('items', function(){
		this.resource('item', { path:'/:item_id'}, function() {
			this.route('edit');
		});
		this.route('create');
	});
});


App.ItemsRoute = Ember.Route.extend({
	model: function(){
		return this.store.find('item');
	}
});

// itemsController
App.ItemsController = Ember.ArrayController.extend({
	sortProperties: ['name'],
	sortAscending: true,
	itemsCount: function() {
		return this.get('model.length');
	}.property('@each')
});

App.IndexRoute = Ember.Route.extend({
	redirect: function(controller) {
		controller.set('content', Ember.$.ajax('http://localhost:8080/api/get/castle', {type: 'GET',
			dataType: 'json',
			data: { name: name },
			context: this,
			success: function(data) {
				var item = App.Items.createRecord(data);
				this.modelFor('items').pushObject(item);
				this.get('controller').set('newName', '');
				this.transitionTo('items', item);
			},
			error: function() {
				alert('Failed to save item');
			}
		);
	}
		
});
