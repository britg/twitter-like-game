@Player = React.createClass
  render: ->
    <div id="player-bar" className="player-status">
      <span className="name">{this.props.player.name}</span>
      <div className="stats">
        <span className="stat">hp</span>
        <span className="value">{this.props.player.hp}</span>
        <span className="stat">ap</span>
        <span className="value">{this.props.player.ap}</span>
        <span className="stat">mana</span>
        <span className="value">{this.props.player.mana}</span>
      </div>
    </div>
