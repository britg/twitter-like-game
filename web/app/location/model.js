import DS from 'ember-data';

var Location = DS.Model.extend({
  name: DS.attr(),
  slug: DS.attr()
});

export default Location;
