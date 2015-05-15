@Story = React.createClass

  getInitialState: ->
    displayer: new EventDisplayer

  componentDidMount: ->
    $('.event.new:hidden').addClass('initial-load')

  componentDidUpdate: ->
    @state.displayer.start @publishPlayerState

  eventById: (id) ->
    for event in this.props.events
      return event if event.id == id

  publishPlayerState: (event) ->
    id = $(event).attr("data-reactid").split('$')[1]
    event = @eventById(id)
    if event? && event.player_state_during_event?
      PubSub.publish(Events.APPLY_PLAYER, event.player_state_during_event)

  eventComponent: (event, index) ->
    includeActions = (index == 0)

    if !@props.lastActedId?
      @status = "old" if event.chosen_action_key != null
    else
      @status = "old" if event.id == @props.lastActedId

    event.status = @status

    if includeActions
      <StoryEvent event=event key=event.id actions=this.props.actions />
    else
      <StoryEvent event=event key=event.id actions=[] />

  quickDisplay: ->
    @state.displayer.quickDisplay()

  render: ->
    @status = "new"
    <div className="story" onClick={this.quickDisplay} >
      {this.eventComponent(event, index) for event, index in this.props.events}
    </div>
