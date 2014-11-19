JournalApp.Views.PostsIndexView = Backbone.View.extend({
  template: JST["posts/index"],
  
  render: function(){
    var content = this.template({ posts: this.posts });
    
    $('body').html(content)
    
    return this // ALWAYS!!
  },
  
  events: {
    "click .post-delete-button" : "deletePost"
  },
  
  deletePost: function(event) {
    var $currentTarget = $(event.currentTarget);
    var postId = $currentTarget.data('id');
    var post = this.posts.get(postId);
    
    //delete the post method
  },
  
  initialize: function() {
    this.posts = new JournalApp.Collections.Posts();
    this.posts.fetch();
    this.render();
  },
  
});