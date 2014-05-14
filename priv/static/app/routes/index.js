export default Ember.Route.extend({
  this.resource('players', function(){
    this.resource('player', { path:'/:player_id' }, function() {
      this.route('edit');
    });
    this.route('create');
  });
});
