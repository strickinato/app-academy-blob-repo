$.Thumbnail = function (el) {
  this.$el = $(el)
  this.$activeImg = this.$el.find(".gutter-images > img:first");
  this.activate(this.$activeImg);
  this.eventBinder();
  this.gutterIdx = 0;
  this.$images = this.$el.find(".gutter-images > img");
  this.fillGutterImages();
};

$.Thumbnail.prototype.eventBinder = function() {
  var that = this;
  this.$el.find(".gutter-images").on("click", "img", function(event) {
    $newActiveImage = $(event.currentTarget)
    that.$activeImg = $newActiveImage;
    that.activate($newActiveImage);
  });
  
  this.$el.find(".gutter-images").on("mouseenter", "img", function(event) {
    $newActiveImage = $(event.currentTarget)
    that.activate($newActiveImage);
  });
  
  this.$el.find(".gutter-images").on("mouseleave", "img", function(event) {
    $newActiveImage = $(event.currentTarget)
    that.activate(that.$activeImg);
  });
};

$.Thumbnail.prototype.activate = function($img) {
  var $cloneImg = $img.clone();
  $(".active").html($cloneImg);
};

$.fn.thumbnail = function () {
  return this.each(function () {
    new $.Thumbnail(this);
  });
};

$.Thumbnail.prototype.fillGutterImages = function() {
  this.$el.find(".gutter-images").html("");
  debugger;
  for (var i = this.gutterIdx;)
  this.$images.each(function(img) {
    this.$el.find(".gutter-images").append(img)
  })
}