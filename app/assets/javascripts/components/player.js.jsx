var Player = React.createClass({

  render: function() {
    return (
      <div>
        <div>Name: {this.props.player.name}</div>
        <div>Health: {this.props.player.health}</div>
      </div>
    );
  }
});
