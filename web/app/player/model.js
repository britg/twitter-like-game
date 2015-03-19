import DS from 'ember-data';

var Player = DS.Model.extend({
  name: DS.attr(),
  current_location_url: DS.attr()
});

export default Player;
