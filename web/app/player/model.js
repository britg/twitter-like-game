import DS from 'ember-data';

var Player = DS.Model.extend({

  name: DS.attr(),
  continue_token: DS.attr(),
  location: DS.belongsTo('location'),
  user: DS.belongsTo('user'),

  events: DS.hasMany('player-event'),

  current_mode: DS.attr(),

  experience: DS.attr(),
  level: DS.attr(),

  hp: DS.attr(),
  ap: DS.attr(),

  gold: DS.attr(),

  strength: DS.attr(),
  dexterity: DS.attr(),
  stamina: DS.attr(),
  intelligence: DS.attr(),
  luck: DS.attr(),

  selected_action_key: DS.attr()

});

export default Player;
