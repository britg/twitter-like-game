import DS from 'ember-data';

var Player = DS.Model.extend({
  name: DS.attr(),
  current_location_url: DS.attr(),
  continue_token: DS.attr(),
  location: DS.belongsTo('location'),
  user: DS.belongsTo('user'),
  events: DS.hasMany('player-event')
});

export default Player;
