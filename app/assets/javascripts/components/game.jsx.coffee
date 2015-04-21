@Game = React.createClass

  getInitialState: ->
    player: @props.player,
    events: @props.events,
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
    fetch Routes.api_v1_actions_path({format: "json"}),
      credentials: 'include'
      method: 'post'
      headers:
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': $('meta[name=csrf-token]').attr("content")
      body: JSON.stringify
        player_action:
          key: key
    .then (response) ->
      response.json()
    .then (json) ->
      $game.setState
        player: json.player,
        events: json.events.concat($game.state.events),
        actions: json.actions

  render: ->

    screen = switch @state.activeScreen
      when "events" then <Story events={this.state.events} actions={this.state.actions} lastActedId={@lastActedId} />
      when "inventory" then <Inventory />
      when "landmarks" then <Landmarks />
      when "stats" then <Stats />
      when "chat" then <Chat />

    <div id="game">
      <NavBar selected={this.state.activeScreen} />
      {screen}
      <Player player={this.state.player} />
    </div>
