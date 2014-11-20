JournalApp.Views.PostFormView = Backbone.View.extend({
  template: JST["posts/post_form"],
  
  render: function(){
    var content = this.template();
    
    this.$el.html(content)
    return this;
  },
  
  events: {
    "click #new-post-form": "createPost"
  },
  
  createPost: function(event) {
    event.preventDefault();
    var that = this;
    var $form = $('#form-div form');
    var formData = $form.serializeJSON();
    $.ajax({
      url: "/posts",
      type: "POST",
      data: formData,
      dataType: 'JSON',
      success: function(resp) {
        var respModel = new JournalApp.Models.Post(resp);
        // debugger
        JournalApp.posts.add(resp)
        Backbone.history.navigate("#", {trigger: true});
        
      }
    })
  },
  
  initialize: function(options) {
    
    this.render();
  }
});