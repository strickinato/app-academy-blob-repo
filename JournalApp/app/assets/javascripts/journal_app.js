window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new JournalApp.Routers.AppRouter({ 
      $indexEl: $('#index'),
      $showEl: $('#show-div'),
      $formEl: $('#form-div')
      }
    );
    Backbone.history.start();
    var index = new JournalApp.Views.PostsIndexView({collection: JournalApp.posts});
    $("#sidebar").html(index.render().$el);
  }
};

$(document).ready(function(){
  JournalApp.posts = JournalApp.posts || new JournalApp.Collections.Posts();
  JournalApp.posts.fetch();
  JournalApp.initialize();
});