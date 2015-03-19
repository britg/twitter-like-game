import Ember from 'ember';
import $ from 'jquery';

var ApplicationRoute = Ember.Route.extend({

  player: null,

  model: function () {
    if (this.player == null) {
      this.player = this.store.createRecord("player", {id: "current"})
    }

    if (Ember.isPresent($.cookie("player_id"))) {
      return this.player.reload();
    }
    return this.player;
  },

  afterModel: function (player) {
    if (Ember.isPresent(player.get('current_location_url'))) {
      this.transitionTo('player-location', player.get('current_location_url'));
    } else {
      this.transitionTo('index');
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