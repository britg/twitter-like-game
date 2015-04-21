@Player = React.createClass
  render: ->
    <div className="player-status">
      <span>{this.props.player.name}</span>
    </div>
