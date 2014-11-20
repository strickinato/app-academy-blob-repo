JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",
  
  model: JournalApp.Models.Post,
  
  getOrFetch: function(id){
    var postId = Number(id);
    var hopefulPost = this.get(postId)
    if (hopefulPost) {
      hopefulPost.fetch()
      this.add(hopefulPost)
      return hopefulPost
    } else {
      var newPost = new JournalApp.Models.Post({id: postId});
      newPost.fetch()
      this.add(newPost)
      return newPost
    }
  }
});