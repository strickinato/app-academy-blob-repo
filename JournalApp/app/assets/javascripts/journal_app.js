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
    
    var postsIdxCol = new JournalApp.Collections.Posts();
    postsIdxCol.fetch()
    var index = new JournalApp.Views.PostsIndexView({collection: postsIdxCol});
    $("#sidebar").html(index.render().$el)

  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
