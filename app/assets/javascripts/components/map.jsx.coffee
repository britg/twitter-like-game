@Map = React.createClass
  getInitialState: ->
    map:
      id: ""
      discoveries: []
      can_travel: false

  componentWillMount: ->
    # Make call to get landmarks
    Api.get(Routes.api_v1_map_index_path(), @updateLandmarks)

  updateLandmarks: (json) ->
    @setState
      map: json["map"]

  onLocationClick: (location_state) ->
    if @state.map.can_travel && !location_state.current_location
      Api.patch(Routes.api_v1_map_path(location_state.slug), @onTravelConfirmation)

  onTravelConfirmation: () ->
    PubSub.publish(Events.SHOW_STORY)

  zoneComponent: (zone) ->
    <li key=zone.zone.id>
      {zone.zone.name}
      <ul className="location-list">
        {this.locationComponent(location_state) for location_state in zone.locations}
      </ul>
    </li>

  locationComponent: (location_state) ->
    if location_state.current_location
      @currentLocationComponent(location_state)
    else
      @travellableLocationComponent(location_state)

  currentLocationComponent: (location_state) ->
    <li key=location_state.id className="current">
      {location_state.name}
    </li>

  travellableLocationComponent: (location_state) ->
    <li key=location_state.id className="travellable">
      <a onClick={this.onLocationClick.bind(this, location_state)}> {location_state.name}</a>
    </li>

  travelDisabledMessage: ->
    <p>You can not travel at this time</p>

  render: ->
    if @state.map.can_travel
      travelMessage = ""
    else
      travelMessage = @travelDisabledMessage()

    <div id="map">
      <h1>Map</h1>
      {travelMessage}
      <ul>
        {this.zoneComponent(zone) for zone in this.state.map.discoveries}
      </ul>
    </div>
