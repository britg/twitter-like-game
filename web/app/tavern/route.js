import Ember from 'ember';

export default Ember.Route.extend({
  setupController: function(controller, model){
    this._super('controller', model);
    Ember.run.schedule('afterRender', this, function () {
      $('#tavern').fadeIn();
    });

    this.controller.attr = {}
    this.controller.attr.character = "Otto, the tavern keep"
  }
});
