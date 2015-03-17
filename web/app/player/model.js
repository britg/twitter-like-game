import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr(),
  new_record: DS.attr(),
  current_location_url: DS.attr()
});
