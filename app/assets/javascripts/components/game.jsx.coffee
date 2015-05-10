@Game = React.createClass

  getInitialState: ->
    player: @props.player
    events: @props.events
    actions: @props.actions
    activeScreen: "events"

  componentDidMount: ->
    PubSub.subscribe Events.ACTION_TAKEN, @actionTaken
    PubSub.subscribe Events.NAV_SELECTED, @navSelected

  navSelected: (key) ->
    @setState(activeScreen: key)

  lastEvent: ->
    @state.events[0]

  actionTaken: (key) ->
    @lastActedId = @lastEvent()._id
    $game = @
    endpoint = Routes.api_v1_actions_path({format: "json"})
    body =
      player_action:
        key: key
    Api.req(endpoint, @updateGameState, "post", body)

  updateGameState: (json) ->
    @setState
      player: json.player,
      events: json.events.concat(@state.events).slice(0, 100),
      actions: json.actions

  screen: ->
    screen = switch @state.activeScreen
      when "events" then <Story events={this.state.events} actions={this.state.actions} lastActedId={@lastActedId} />
      when "landmarks" then <Landmarks />
      when "inventory" then <Inventory />
      when "crafting" then <Crafting />
      when "stats" then <Stats />
      when "chat" then <Chat />

  render: ->
    <div id="game">
      <NavBar selected={this.state.activeScreen} />
      {this.screen()}
      <Player player={this.state.player} />
    </div>
