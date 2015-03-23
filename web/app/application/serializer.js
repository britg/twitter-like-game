import DS from 'ember-data';

var ApplicationSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    "location": { embedded: 'always' },
    "user": { embedded: 'always' },
    "events": { embedded: 'always' },
    "actions": { embedded: 'always' }
  },
  serialize: function (snapshot, options) {
    var json = this._super(snapshot, options);
    return json;
  }
});

export default ApplicationSerializer;