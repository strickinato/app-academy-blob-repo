Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $('<li class="poke-list-item">');
  $li.data('id', pokemon.get('id'));

  var shortInfo = ['name', 'poke_type'];
  shortInfo.forEach(function (attr) {
    $li.append(attr + ': ' + pokemon.get(attr) + '<br>');
  });

  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this;
  this.pokes.fetch({
    success: (function () {
      that.$pokeList.empty();
      that.pokes.each(function(pokemon) {
        var content = JST["pokemonListItem"]({
           pokemon: pokemon 
        });
        that.$pokeList.append(content)
      });
      callback && callback();
    })
  });

  return this.pokes;
};

