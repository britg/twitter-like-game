var Player = React.createClass({

  render: function() {
    return (
      <div>
        <div>Name: {this.props.player.name}</div>
        <div>hp: {this.props.player.hp}</div>
      </div>
    );
  }
});
