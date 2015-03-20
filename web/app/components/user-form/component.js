import Ember from 'ember';
import $ from 'jquery';

var UserFormComponent = Ember.Component.extend({

  actions: {
    submit: function () {
      this.sendAction();
    }
  }
});

export default UserFormComponent;
