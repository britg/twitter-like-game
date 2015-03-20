import DS from 'ember-data';

var User = DS.Model.extend({
  email: DS.attr(),
  password: DS.attr(),
  password_confirmation: DS.attr()
});

export default User;