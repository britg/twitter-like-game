import DS from 'ember-data';

var Player = DS.Model.extend({
  name: DS.attr(),
  current_location_url: DS.attr(),
  continue_token: DS.attr(),
  current_location: DS.belongsTo('player-location'),
  user: DS.belongsTo('user')
});

export default Player;
