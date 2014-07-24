App = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_BINDINGS: true,
  LOG_VIEW_LOOKUPS: true,
  LOG_STACKTRACE_ON_DEPRECATION: true,
  LOG_VERSION: true,
  debugMode: true
});

// models

App.Signal = Ember.Object.extend({
    unique  : "",
    path    : ""
});

App.Item = Ember.Object.extend({
    unique : "",
});

// routes
App.Router.map(function() {
  this.resource("photos", function(){
    this.route("edit", { path: "/:photo_id" });
  });
});

// controllers

App.IndexController = Ember.ObjectController.extend({
  signals : ["nub", "obj"],
  submitAction : function(){
        // here you could perform your actions like persisting to the server or so
        alert("now we can submit the model:" + this.get("model"));
  }
});