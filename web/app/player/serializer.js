import DS from 'ember-data';

var PlayerSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    "location": { embedded: 'always' },
    "user": { embedded: 'always' },
    "events": { embedded: 'always' },
  },
  serialize: function (snapshot, options) {
    var json = this._super(snapshot, options);
    return {
      "selected_action_key": json.selected_action_key
    }
  }
});

export default PlayerSerializer;