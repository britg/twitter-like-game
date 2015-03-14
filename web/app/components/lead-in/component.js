import Ember from 'ember';

export default Ember.Component.extend({
  didInsertElement: function () {
    console.log("lead-in component did insert element");
  },
  actions: {
    startGame: function () {
      console.log("Starting game!");
    }
  }
});
