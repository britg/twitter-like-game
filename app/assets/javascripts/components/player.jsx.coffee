@Player = React.createClass
  render: ->
    <div id="player-bar" className="player-status">
      <span className="status-line">{this.props.player.status_line}</span>
    </div>
