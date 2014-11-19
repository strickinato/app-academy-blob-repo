Pokedex.Views = {};

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({
      pokemon: pokemon 
    });
    this.$el.append(content)

    return this.collection;
  },


  refreshPokemon: function (callback) {
    // debugger
    var that = this;
    this.collection.fetch({
      success: function(){
        that.render();
        if (callback) {
          callback();
        }
      }
    })
  },

  render: function () {
    var that = this;
    this.$el.empty();
    that.collection.each(function(poke){
      that.addPokemonToList(poke);
    })
  },

  selectPokemonFromList: function (event) {
    $currentTarget = $(event.currentTarget);
    var pokeId = $currentTarget.data('id');
    var poke = this.collection.get(pokeId);
    Backbone.history.navigate("/pokemon/" + pokeId, { trigger: true });

  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (callback) {
    var pokemon = this.model
    pokemon.fetch({
      success: (function(){
        this.render();
      }).bind(this)
    });
  },

  render: function () {
    var pokemon = this.model;
    var content = JST["pokemonDetail"]({
      pokemon: pokemon
    })
    this.$el.html(content)
    
    var toys = pokemon.toys();
    var $toyUl = this.$el.find(".toys")
    toys.each((function(toy) {
      var toyContent = JST["toyListItem"]({
        toy: toy
      });
      
      $toyUl.append(toyContent)
      
    }).bind(this))
  },

  selectToyFromList: function (event) {
    var $currentTarget = $(event.currentTarget);
    var toyId = $currentTarget.data("id");
    console.log(toyId)
    var toy = this.model.toys().get(toyId);
      
    var toyDetail = new Pokedex.Views.ToyDetail({
      model: toy,
      el: $('#pokedex .toy-detail') 
    });
    toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var toy = this.model
    this.$el.empty();
    var content = JST["toyDetail"]({
      toy: toy,
      pokemon: new Pokedex.Collections.Pokemon()
    })
    this.$el.html(content);
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });

