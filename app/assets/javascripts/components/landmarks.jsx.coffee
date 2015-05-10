@Landmarks = React.createClass
  getInitialState: ->
    locations: []

  componentWillMount: ->
    # Make call to get landmarks
    Api.get(Routes.api_v1_landmarks_path({format: "json"}), @updateLandmarks)

  updateLandmarks: (json) ->
    @setState
      locations: json["locations"]

  locationComponent: (location) ->
    <li>
      {location.name}
    </li>

  render: ->
    <div id="landmarks">
      <h1>Known Locations</h1>
      <ul>
        {this.locationComponent(location) for location in this.state.locations}
      </ul>
    </div>
