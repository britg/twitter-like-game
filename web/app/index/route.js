import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
  },
  actions: {
    startGame: function () {
      this.transitionTo('tavern');
    }
  }
});
