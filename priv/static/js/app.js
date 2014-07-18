App = Ember.Application.create({});

App.Signal = Ember.Object.extend({
    unique : "",
});

App.Item = Ember.Object.extend({
    unique : "",
});

App.IndexRoute = Ember.Route.extend({
  model: function(){
      return App.Signal.create()
  },
    setupController : function(controller, model){
        controller.set("model", model);
    }
});

App.IndexController = Ember.ObjectController.extend({
    submitAction : function(){
        // here you could perform your actions like persisting to the server or so
        alert("now we can submit the model:" + this.get("model"));
    }
});