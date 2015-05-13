@Game = React.createClass

  getInitialState: ->
    player: @props.player
    events: @props.events
    actions: @props.actions
    activeScreen: "events"

  componentDidMount: ->
    PubSub.subscribe Events.ACTION_TAKEN, @actionTaken
    PubSub.subscribe Events.NAV_SELECTED, @navSelected
    PubSub.subscribe Events.SHOW_STORY, @showStoryAndUpdate

  navSelected: (key) ->
    if key == "events"
      @showStoryAndUpdate()
    else
      @setState(activeScreen: key)

  lastEvent: ->
    @state.events[0]

  actionTaken: (key) ->
    @lastActedId = @lastEvent().id
    $game = @
    endpoint = Routes.api_v1_actions_path()
    body =
      player_action:
        key: key
      mark_id: @lastActedId
    Api.post(endpoint, @updateGameState, body)

  showStoryAndUpdate: ->
    @setState(activeScreen: "events")
    @requestUpdate()

  requestUpdate: ->
    endpoint = Routes.api_v1_story_index_path({mark_id: @lastEvent().id})
    Api.get(endpoint, @updateGameState)

  updateGameState: (json) ->
    @setState
      events: json.events.concat(@state.events).slice(0, 100),
      actions: json.actions

  screen: ->
    screen = switch @state.activeScreen
      when "events" then <Story events={this.state.events} actions={this.state.actions} lastActedId={@lastActedId} />
      when "map" then <Map />
      when "equipment" then <Equipment />
      when "inventory" then <Inventory />
      when "quests" then <Quests />
      when "stats" then <Stats />
      when "chat" then <Chat />

  render: ->
    <div id="game">
      <NavBar selected={this.state.activeScreen} />
      {this.screen()}
      <Player player={this.state.player} />
    </div>
