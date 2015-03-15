import Ember from 'ember';

export default Ember.Route.extend({
  afterModel: function (players, transition) {
    if (!Ember.isEmpty(players)) {
      this.transitionTo('tavern');
    }
  },
  model: function () {
    console.log("getting model");
    var rememberedPlayer = localStorage.getItem("player_id");
    if (!Ember.isNone(rememberedPlayer)) {
      return this.get('store').find('player', rememberedPlayer);
    }
  },
  actions: {
    startGame: function () {
      this.transitionTo('tavern');
    }
  }
});
