class window.EventPresenter

  fadeInTime: 200
  delayPerWord: 0.2 * 1000

  currentlyRunning: false

  speedUpTime: 400
  speedUpClasses: ["attack"]

  start: (callback) ->
    return if @currentlyRunning
    @currentlyRunning = true
    @callback = callback
    @showNextEvent()

  quickDisplay: ->
    clearTimeout(@nextEventTimeout)
    @showNextEvent()

  nextEvent: ->
    $('.event.new:hidden:last')

  showNextEvent: ->
    $_nextEvent = @nextEvent()
    if $_nextEvent.length < 1
      @currentlyRunning = false
      return

    nextDelay = @delayForNextEvent()

    @nextEvent().fadeIn @fadeInTime, =>
      @callback.apply(null, $_nextEvent)
      @nextEventTimeout = setTimeout =>
        @showNextEvent()
      , nextDelay

  delayForNextEvent: () ->
    $_nextEvent = @nextEvent()
    for speedUpClass in @speedUpClasses
      return @speedUpTime if $_nextEvent.hasClass(speedUpClass)

    text = $_nextEvent.find(".detail").html()
    if text?
      detailCount = text.split(' ').length
      nextDelay = detailCount * @delayPerWord;
    else
      nextDelay = @speedUpTime

    nextDelay
