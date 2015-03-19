import Ember from 'ember';

var IndexRoute = Ember.Route.extend({
  actions: {
    createPlayer: function () {
      var $player = this.player = this.modelFor('application');
      this.player.save().then(function () {
        console.log("After player save");
        localStorage["continue_token"] = $player.get('continue_token')
      });
    },

    startGame: function () {
      this.transitionTo('player-location',
        this.player.get('current_location_url'));
    }
  }
});

export default IndexRoute;