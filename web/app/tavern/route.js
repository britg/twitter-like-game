import Ember from 'ember';
import $ from 'jquery';

export default Ember.Route.extend({

  model: function () {
    return this.get('store').find('player_location', 'tavern');
  },

  setupController: function(controller, model){
    this._super(controller, model);
    Ember.run.schedule('afterRender', this, function () {
      $('#tavern').fadeIn();
    });

    controller.attr = {};
    controller.attr.character = "Otto, the tavern keep";
    console.log("model is ", model);
    controller.set('attr.location', model);
  }
});
