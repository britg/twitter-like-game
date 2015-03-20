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
  }
});
export default PlayerRoute;
