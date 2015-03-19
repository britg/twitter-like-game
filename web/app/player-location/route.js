import Ember from 'ember';
import $ from 'jquery';

var PlayerLocationRoute = Ember.Route.extend({

  model: function () {
    return this.modelFor('application');
  },

  setupController: function(controller, model){
    this._super(controller, model);
    Ember.run.schedule('afterRender', this, function () {
      $('.player-location').fadeIn();
    });

    controller.attr = {};
    controller.attr.character = "Otto, the tavern keep";
    controller.set('attr.location', model);
  }
});
export default PlayerLocationRoute;
