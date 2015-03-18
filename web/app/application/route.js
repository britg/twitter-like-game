import Ember from 'ember';
import $ from 'jquery';

var ApplicationRoute = Ember.Route.extend({

  model: function () {
    if (Ember.isPresent($.cookie("player_id"))) {
      return this.store.find('player', 'current');
    }
  },

  afterModel: function (player) {
    if (Ember.isPresent(player)) {
      this.transitionTo(player.get('current_location_url'));
    }
  },

  setupController: function () {
  },

  actions: {
    error: function() {
      console.log("Application route error: ", arguments);
      this.transitionTo('player-location');
    }
  }

});

export default ApplicationRoute;