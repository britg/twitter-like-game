import Ember from 'ember';

var ApplicationRoute = Ember.Route.extend({

  player: null,

  model: function () {
    if (this.player == null) {
      this.player = this.store.createRecord("player", {id: "current"});
    }

    if (Ember.isEmpty(this.player.get('continue_token')) &&
      Ember.isPresent(localStorage["continue_token"])) {
      return this.player.reload();
    }

    return this.player;
  },

  afterModel: function (player) {
    var loc = player.get('current_location_url');
    if (Ember.isPresent(loc)) {
      this.transitionTo('player', loc);
    } else {
      this.transitionTo('index');
    }
  },

  setupController: function () {
  },

  actions: {
    error: function() {
      console.log("Application route error: ", arguments);
      this.transitionTo('player');
    },

    createUser: function () {
      console.log("Create user called at application level ", this.store.find('user'));
    }
  }

});

export default ApplicationRoute;