Pokedex.RootView.prototype.addToyToList = function (toy) {
  var toyString = "<li>" + toy.get("happiness") + " " + toy.get("name") + " " + toy.get("price") + "</li>"
    $('.detail ul').append(toyString);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  var $money = $("<div class='detail'></div>")
  this.$toyDetail.html($money)
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
};
