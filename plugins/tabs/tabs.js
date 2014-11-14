$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"))
  this.$activeTab = $(".tab-pane.active")
  var that = this;
  this.$el.on('click', 'a', function(event) {
    that.clickTab(event);
  });
};

//ask about one and on?

$.Tabs.prototype.clickTab = function(event) {
  event.preventDefault();
  var $oldActiveTab = this.$activeTab
  var $newActiveTab = $($(event.currentTarget).attr('href'));
  
  $('a.active').removeClass('active');
  $(event.currentTarget).addClass('active');
  
  $oldActiveTab.addClass('transitioning');
  
  $oldActiveTab.on("transitionend", function() {
    $oldActiveTab.removeClass('transitioning').removeClass("active");
    $newActiveTab.addClass("transitioning").addClass("active");
    window.setTimeout(function() {
      $newActiveTab.removeClass("transitioning");
    }, 0);
  })

  this.$activeTab = $newActiveTab;
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
