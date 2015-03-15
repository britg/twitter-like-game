import Ember from 'ember';
import $ from 'jquery';

export default Ember.Route.extend({

  model: function () {
    console.log("Accessing model here");
    return this.get('store').find('location', 'tavern');
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
