@Player = React.createClass
  render: ->
    <div id="player-bar" className="player-status">
      <span>{this.props.player.status_line}</span>
    </div>
