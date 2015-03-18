import Ember from 'ember';

export default Ember.Route.extend({
  actions: {
    createPlayer: function () {
      console.log("Index route createAction");
      var newPlayer = this.store.createRecord("player", {id: "current"});
      newPlayer.save();
    },

    startGame: function () {
      this.transitionTo('player-location', 'tavern');
    }
  }
});
