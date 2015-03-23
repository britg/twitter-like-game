import DS from 'ember-data';

var PlayerEvent = DS.Model.extend({
  character_name: DS.attr(),
  detail: DS.attr(),
  dialogue: DS.attr(),
  actions: DS.hasMany('actions'),
  current_state: DS.attr(),
  actionable: function () {
    return this.get('current_state') == PlayerEvent.STATE_CURRENT;
  }.property('current_state')
});

PlayerEvent.STATE_NEW = "new"
PlayerEvent.STATE_CURRENT = "current"
PlayerEvent.STATE_OLD = "old"

export default PlayerEvent;