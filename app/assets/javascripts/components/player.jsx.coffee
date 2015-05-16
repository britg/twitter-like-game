@Player = React.createClass
  getInitialState: ->
    player: @props.player

  componentDidMount: ->
    PubSub.subscribe Events.APPLY_PLAYER, @applyPlayer

  applyPlayer: (json) ->
    @setState
      player: json

  render: ->
    <div id="player-bar" className="player-status">
      <span className="name">{this.state.player.name}</span>
      <div className="stats">
        <span className="stat">lvl</span>
        <span className="value">{this.state.player.level}</span>
        <span className="stat">hp</span>
        <span className="value">{this.state.player.hp}</span>
        <span className="stat">mana</span>
        <span className="value">{this.state.player.mana}</span>
        <span className="stat">g:</span>
        <span className="value">{this.state.player.gold}</span>
      </div>
    </div>
