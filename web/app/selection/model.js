import DS from 'ember-data';

var Selection = DS.Model.extend({
  key: DS.attr(),
  event_id: DS.attr()
});

export default Selection;