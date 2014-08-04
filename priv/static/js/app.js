window.App = Ember.Application.create({
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


// routes

App.Router.map(function() {
  
});

// controllers

App.IndexController = Ember.ObjectController.extend({
  signals : ["nub", "obj"],
});