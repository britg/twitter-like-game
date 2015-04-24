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
      if response.status != 200
        window.location.reload()
        return
      response.json()
    .then (json) ->
      $game.setState
        player: json.player,
        events: json.events.concat($game.state.events).slice(0, 100),
        actions: json.actions
    .catch (err) ->
      console.log(err)

  screen: ->
    screen = switch @state.activeScreen
      when "events" then <Story events={this.state.events} actions={this.state.actions} lastActedId={@lastActedId} />
      when "inventory" then <Inventory />
      when "crafting" then <Crafting />
      when "landmarks" then <Landmarks />
      when "stats" then <Stats />
      when "chat" then <Chat />

  render: ->
    <div id="game">
      <NavBar selected={this.state.activeScreen} />
      {this.screen()}
      <Player player={this.state.player} />
    </div>
