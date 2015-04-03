var StoryEvent = React.createClass({

  createAction: function (action) {
    return (
      <button key={action.key}
        onClick={this.onActionClick.bind(this, action.key)}>{action.label}</button>
    );
  },

  onActionClick: function (key) {
    PubSub.publish(Events.ACTION_TAKEN, key);
  },

  render: function() {
    return (
      <div className="event">
        <p className="detail">{this.props.event.detail}</p>
        <p className="dialogue">{this.props.event.dialogue}</p>
        {this.props.event.actions.map(this.createAction)}
      </div>
    );
  }
});
