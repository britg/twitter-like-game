@Story = React.createClass

  eventComponent: (event, index) ->
    includeActions = (index == 0)

    if @props.lastActedId == undefined
      @status = "old" if event.chosen_action_key != null
    else
      @status = "old" if event._id == @props.lastActedId

    event.status = @status

    if includeActions
      <StoryEvent event=event key=event._id actions=this.props.actions />
    else
      <StoryEvent event=event key=event._id actions=[] />

  render: ->
    @status = "new"
    <div className="story">
      {this.props.events.map(this.eventComponent)}
    </div>

  componentDidUpdate: ->
    top = $('.event.new:last').offset().top
    $(window).scrollTop(top)
