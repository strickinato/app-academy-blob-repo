Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $el = $("<div class='detail'>").html("<img src='" + pokemon.get("image_url") + "'></img>");
  this.$pokeDetail.html($el);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {

  var pokeId = event.target.dataset['pokeId'];
  this.renderPokemonDetail(this.pokes.get(pokeId));
};
