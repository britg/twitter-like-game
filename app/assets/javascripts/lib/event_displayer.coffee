class window.EventDisplayer

  fadeInTime: 200
  delayPerWord: 0.2 * 1000

  currentlyRunning: false

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
    detailCount = @nextEvent().find(".detail").html().split(' ').length
    nextDelay = detailCount * @delayPerWord;
    nextDelay
