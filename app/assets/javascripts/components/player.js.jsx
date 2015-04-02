var Player = React.createClass({
  propTypes: {
    name: React.PropTypes.string,
    health: React.PropTypes.node
  },

  render: function() {
    return (
      <div>
        <div>Name: {this.props.name}</div>
        <div>Health: {this.props.health}</div>
      </div>
    );
  }
});
