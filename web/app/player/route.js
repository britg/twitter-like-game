import Ember from 'ember';
import $ from 'jquery';

var PlayerRoute = Ember.Route.extend({

  model: function () {
    return this.modelFor('application');
  },

  setupController: function(controller, player){
    this._super(controller, player);
    Ember.run.schedule('afterRender', this, function () {
      $('#player').fadeIn();
    });

    controller.attr = {};
    controller.set('attr.player', player);
  },

  actions: {
    chooseAction: function (player_action) {
      console.log("Player route choose action ", player_action.get('key'));
      var action = this.store.createRecord("action", {
        key: player_action.get('key'),
        "event": player_action.get('event')
      });
      action.save();
    }
  }
});
export default PlayerRoute;
