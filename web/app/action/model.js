import DS from 'ember-data';

var Action = DS.Model.extend({
  key: DS.attr(),
  label: DS.attr(),
  event: DS.belongsTo('player-event')
});

export default Action;
