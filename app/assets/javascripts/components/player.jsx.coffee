@Player = React.createClass
  render: ->
    <div id="player-bar" className="player-status">
      <span>{this.props.player.name}</span>
    </div>
