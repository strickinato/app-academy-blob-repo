window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');
  }
};

$(document).ready(function(){
  JournalApp.initialize();
  var view = new JournalApp.Views.PostsIndexView();
  view.initialize();
});
