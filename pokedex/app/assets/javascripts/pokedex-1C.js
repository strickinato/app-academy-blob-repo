Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPokemon = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  newPokemon.save({}, {
    success: function(){
      that.pokes.add(newPokemon);
      that.addPokemonToList(newPokemon);
    }
  })
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
};
