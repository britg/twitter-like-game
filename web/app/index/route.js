import Ember from 'ember';

export default Ember.Route.extend({
  afterModel: function (player, transition) {
    if (!player.get('new_record')) {
      this.transitionTo('tavern');
    }
  },
  model: function () {
    console.log("getting model");
    return this.store.find('player', 'current');
  },
  actions: {
    startGame: function () {
      this.transitionTo('tavern');
    }
  }
});
