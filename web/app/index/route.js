import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    startGame: function () {
      this.transitionTo('player-location', 'tavern');
    }
  }
});
