@Story = React.createClass
  componentDidMount: ->
    $('.event.new:hidden').addClass('initial-load')

  componentDidUpdate: ->
    @showNextEvent()

  showNextEvent: ->
    $nextEvent = $('.event.new:hidden:last')
    return unless $nextEvent.length > 0
    id = $nextEvent.attr("data-reactid")
    $nextEvent.fadeIn 200, =>
      randNextTime = Math.random() * 700 + 500;
      setTimeout @showNextEvent, randNextTime

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

  render: ->
    @status = "new"
    <div className="story">
      {this.eventComponent(event, index) for event, index in this.props.events}
    </div>
