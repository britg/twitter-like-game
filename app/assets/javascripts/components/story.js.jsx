var Story = React.createClass({

  eventCount: function () {
    return this.props.events.length;
  },

  createEvent: function (event) {
    return (
      <StoryEvent key={event.id}
        event={event} />
    );
  },

  render: function () {
    return (
      <div>
        <p>Events: {this.eventCount()}</p>
        <ul>
          {this.props.events.map(this.createEvent)}
        </ul>
      </div>
    );
  }

});