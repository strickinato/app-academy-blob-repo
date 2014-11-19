Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
    //need to finish Toy Stuff
  },

  pokemonDetail: function (id, callback) {
    if(!this._pokemonIndex) {
      // this.pokemonIndex(function () {
      //   this.pokemonDetail(id, callback)
      // }.bind(this));

      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
      return;
    }
    var poke = this._pokemonIndex.collection.get(id)
    var pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: poke
    });
    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    pokemonDetail.refreshPokemon(callback);
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
