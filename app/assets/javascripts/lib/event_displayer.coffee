class window.EventDisplayer

  fadeInTime: 200
  delayPerWord: 0.2 * 1000

  currentlyRunning: false

  start: (callback) ->
    return if @currentlyRunning
    @currentlyRunning = true
    @callback = callback
    @showNextEvent()

  showNextEvent: ->
    $nextEvent = $('.event.new:hidden:last')
    if $nextEvent.length < 1
      @currentlyRunning = false
      return

    nextDelay = @delayForEvent($nextEvent)

    $nextEvent.fadeIn @fadeInTime, =>
      @callback.apply(null, $nextEvent)
      setTimeout =>
        @showNextEvent()
      , nextDelay

  delayForEvent: ($event) ->
    detailCount = $event.find(".detail").html().split(' ').length
    nextDelay = detailCount * @delayPerWord;
    nextDelay
