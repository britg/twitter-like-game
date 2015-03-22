import Ember from 'ember';

var PlayerEventComponent = Ember.Component.extend({

  actions: {
    click: function (player_action) {
      this.sendAction('action', player_action);
    }
  }
});

export default PlayerEventComponent;
