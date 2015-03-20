import DS from 'ember-data';

var ApplicationSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    "current_location": { embedded: 'always' }
  }
});

export default ApplicationSerializer;