JournalApp.Views.PostShowView = Backbone.View.extend({
  template: JST["posts/show"],

  render: function(){
    var content = this.template({ post: this.model });
    this.$el.html(content)

    return this;
  },

  events: {
    "dblclick .title": "editTitle",
    "dblclick .bodyText": "editBodyText",
    "blur .titleEdit": "saveRecentTitleEdit"
  },

  editTitle: function(event) {
    var $currentTarget = $(event.currentTarget);
    var string = '<input type="text" name="post[title]" value="' + this.model.get("title") +'" class="titleEdit">'
    $currentTarget.replaceWith(string)
  },

  saveRecentTitleEdit: function(event){
    var $currentTarget = $(event.currentTarget);
    var formData = $currentTarget.serializeJSON();
    var theUrl = "/posts/" + this.model.id;
    $.ajax({
      url: theUrl ,
      type: "PUT",
      data: formData,
      dataType: 'JSON',
      success: function(resp) {
        var $replaceItem = $('.titleEdit');
        var string = '<h2 class="title">' + resp.title + '</h2>'
        $replaceItem.replaceWith(string);
      }
    })
  },


  initialize: function(options) {
    this.listenTo(this.model, "sync", this.render);
  }
});
