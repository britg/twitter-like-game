@Story = React.createClass

  getInitialState: ->
    lastEventId: @lastEventMarker()

  lastEventMarker: ->
    this.props.events[this.props.events.length - 1].time_marker

  eventComponent: (event, index) ->
    includeActions = (index == 0)
    if includeActions
      <StoryEvent event=event key=event._id actions=this.props.actions />
    else
      <StoryEvent event=event key=event._id actions=[] />

  render: ->

    <div className="story">
      {this.props.events.map(this.eventComponent)}
    </div>
