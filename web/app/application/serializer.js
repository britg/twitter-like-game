import DS from 'ember-data';

var ApplicationSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    "current_location": { embedded: 'always' },
    "user": { embedded: 'always' },
    "events": { embedded: 'always' }
  }
});

export default ApplicationSerializer;