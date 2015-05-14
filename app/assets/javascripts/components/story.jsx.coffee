@Story = React.createClass

  fadeInTime: 200
  delayPerWord: 0.2 * 1000

  componentDidMount: ->
    $('.event.new:hidden').addClass('initial-load')

  componentDidUpdate: ->
    console.log("component did update")
    @showNextEvent()
    @scrollBottom()

  showNextEvent: ->
    console.log("showing next event")
    $nextEvent = $('.event.new:hidden:last')
    return unless $nextEvent.length > 0
    nextDelay = @delayForEvent($nextEvent)
    $nextEvent.fadeIn @fadeInTime, =>
      @applyPlayer($nextEvent)
      setTimeout @showNextEvent, nextDelay

  scrollBottom: ->
    to = $(document).height()-$(window).height()
    console.log(to)
    $('html, body').animate scrollTop: to

  delayForEvent: ($event) ->
    detailCount = $event.find(".detail").html().split(' ').length
    nextDelay = detailCount * @delayPerWord;
    nextDelay

  applyPlayer: ($event) ->
    id = $event.attr("data-reactid").split('$')[1]
    event = @eventById(id)
    if event? && event.player_state_during_event?
      PubSub.publish(Events.APPLY_PLAYER, event.player_state_during_event)

  eventById: (id) ->
    for event in this.props.events
      return event if event.id == id

  eventComponent: (event, index, lastIndex) ->
    includeActions = (index == lastIndex)

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
      {this.eventComponent(event, index, this.props.events.length-1) for event, index in this.props.events}
    </div>
