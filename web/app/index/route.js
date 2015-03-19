import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    createPlayer: function () {
      this.player = this.modelFor('application');
      this.player.save();
    },

    startGame: function () {
      this.transitionTo('player-location',
        this.player.get('current_location_url'));
    }
  }
});
