@Game = React.createClass

  getInitialState: ->
    player: @props.story.player
    events: @props.story.events
    actions: @props.story.actions
    activeScreen: "events"

  componentDidMount: ->
    PubSub.subscribe Events.ACTION_TAKEN, @actionTaken
    PubSub.subscribe Events.NAV_SELECTED, @navSelected
    PubSub.subscribe Events.SHOW_STORY, @showStoryAndUpdate


    if @state.events.length < 1
      @requestUpdate()

  navSelected: (key) ->
    if key == "events"
      @showStoryAndUpdate()
    else
      @setState(activeScreen: key)

  lastEvent: ->
    @state.events[0]

  actionByKey: (key) ->
    for action in @state.actions
      return action if action.key == key

  actionTaken: (key) ->
    @lastActedId = @lastEvent().id
    $game = @
    action = @actionByKey(key)
    @localActionEvent(action)
    endpoint = Routes.api_v1_actions_path()
    body =
      player_action:
        key: key
      mark_id: @lastActedId

    setTimeout =>
      Api.post(endpoint, @updateGameState, body)
    , 500

  showStoryAndUpdate: ->
    @setState(activeScreen: "events")
    @requestUpdate()

  requestUpdate: ->
    if @lastEvent()?
      endpoint = Routes.api_v1_story_index_path({mark_id: @lastEvent().id})
    else
      endpoint = Routes.api_v1_story_index_path()

    Api.get(endpoint, @updateGameState)

  updateGameState: (json) ->
    @setState
      events: json.events.concat(@state.events).slice(0, 100),
      actions: json.actions

  localActionEvent: (action) ->
    event = {
      "id": Math.random
      "format": "detail",
      "detail": action.feedback
    }

    @setState(events: [event].concat(@state.events), actions: [])

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
