$.Carousel = function (el) {
  this.$el = $(el);
  this.$items = this.$el.find(".items");
  this.activeIdx = 0;
  this.createClickHandlers();
};


$.Carousel.prototype.createClickHandlers = function () {
  var that = this;
  $(".slide-left").on("click", function(event) {
    that.slideLeft()
  })
  $(".slide-right").on("click", function(event) {
    that.slideRight()
  })
}

$.Carousel.prototype.slide = function(dir) {
  if (this.transitioning) {return;}
  this.transitioning = true
  var that = this
  var oldActiveIdx = this.activeIdx;
  this.activeIdx += dir;
  var newActiveIdx = this.wrap((this.activeIdx));
  
  var oldActiveImg = this.$el.find("img").eq(oldActiveIdx);
  var newActiveImg = this.$el.find("img").eq(newActiveIdx);
  oldActiveImg.addClass("left");
  newActiveImg.addClass("active right");
  setTimeout(function(){newActiveImg.removeClass("right")});
    newActiveImg.one('transitionend', function(){
      oldActiveImg.removeClass('active left');
      that.transitioning = false
  })
  this.activeIdx = newActiveIdx;
}

$.Carousel.prototype.wrap = function(num) {
  var numElements = this.$el.find("img").length
  if (num < 0) {
    num = numElements - 1;
  } else if (num > (numElements - 1)) {
    num = 0;
  }
  return num
}

$.Carousel.prototype.slideLeft = function () {
  this.slide(1)
}

$.Carousel.prototype.slideRight = function () {
  this.slide(-1)  
}

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
