Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li class='poke-list-item' data-poke-id='"+ pokemon.id +"'>")
    .html(pokemon.get('name') + " " + pokemon.get("poke_type"));
  this.$pokeList.append($li)

};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this
  this.pokes.fetch({
    success: function(){
      this.pokes.forEach(function(poke){
        that.addPokemonToList(poke);
      })
    }.bind(this)
  });
};
