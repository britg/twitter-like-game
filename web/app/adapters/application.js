import DS from 'ember-data';
import $ from 'jquery';

var ApplicationAdapter = DS.ActiveModelAdapter.extend({
  namespace: 'api/v1',
  headers: {
    "X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
  }
});

export default ApplicationAdapter;