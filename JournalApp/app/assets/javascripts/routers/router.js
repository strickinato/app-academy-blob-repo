JournalApp.Routers.AppRouter = Backbone.Router.extend({
  initialize: function(options) {
    // this.$indexEl = options.$indexEl;
    this.$showEl = options.$showEl;
    this.$formEl = options.$formEl;
  },
  routes: {
    // "": "index",
    "posts/:id": "postShow",
    "new": "postForm"
  },
  
  index: function() {
    var nc = new JournalApp.Collections.Posts();
    nc.fetch();
    var view = new JournalApp.Views.PostsIndexView({
      collection: nc
    });

    this.$indexEl.html(view.render().$el)
  },
  
  postShow: function(){
    var postId = Backbone.history.location.hash.split('/')[1]
    var nc = new JournalApp.Collections.Posts();
    var targetPost = nc.getOrFetch(postId);
    
    var view = new JournalApp.Views.PostShowView({
      model: targetPost
    });
    this.$showEl.html(view.render().$el)
  },
  
  postForm: function(){
    var formModel = new JournalApp.Models.Post();
    var view = new JournalApp.Views.PostFormView({
      model: formModel
    })
    this.$formEl.html(view.render().$el)  
  },

  
});