import Ember from 'ember';

var ApplicationRoute = Ember.Route.extend({

  model: function () {
    return this.store.find('player', 'current');
  },

  afterModel: function (player) {
    console.log("Application after model");
    if (!player.get('new_record')) {
      this.transitionTo('player-location', player.get('current_location_url'));
    }
  },

  setupController: function () {
  },

  actions: {
    error: function() {
      console.log(arguments);
      this.transitionTo('player-location');
    }
  }

});

export default ApplicationRoute;