import Ember from 'ember';

var ApplicationRoute = Ember.Route.extend({

  model: function () {
    console.log("Application model here");
    return this.store.find('player', 'current');
  },

  afterModel: function (player, transition) {
    if (!player.get('new_record')) {
      this.transitionTo(player.get('current_location_url'));
    }
  },

  setupController: function (controller, model) {
  },

  actions: {
    error: function() {
      this.transitionTo('index');
    }
  }

});

export default ApplicationRoute;