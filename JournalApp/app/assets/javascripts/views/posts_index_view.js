JournalApp.Views.PostsIndexView = Backbone.View.extend({
  template: JST["posts/index"],
  
  render: function(){
    var content = this.template({ posts: this.collection });
    this.$el.html(content);
    
    return this;
  },
  
  events: {
    "click button.post-delete-button": "deletePost"
  },
  
  deletePost: function(event) {
    var $currentTarget = $(event.currentTarget);
    var postId = $currentTarget.data('id');
    var post = this.collection.get(postId);
    
    post.destroy();
  },
  
  initialize: function(options) {

    this.listenTo(
      this.collection, 
      "remove add change:title reset sync",
      this.render);
      

    this.render();
  }
});