import DS from 'ember-data';

var PlayerEvent = DS.Model.extend({
  character_name: DS.attr(),
  detail: DS.attr(),
  dialogue: DS.attr(),
  actions: DS.hasMany('actions')
});

export default PlayerEvent;