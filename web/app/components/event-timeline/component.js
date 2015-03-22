import Ember from 'ember';

var EventTimelineComponent = Ember.Component.extend({
  actions: {
    chooseAction: function (player_action) {
      console.log("Event timeline choose action", player_action);
      this.sendAction('action', player_action);
    }
  }
});

export default EventTimelineComponent;