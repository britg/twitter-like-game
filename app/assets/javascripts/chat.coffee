$ ->
  window.sockets = []
  window.endpoint = "ws://#{window.location.host}/api/v1/chat"

  window.createSocket = () ->
    socket = new WebSocket window.endpoint
    socket.onmessage = (event) ->
      console.log(event, event.data)

    window.sockets.push(socket)

  window.createSockets = (num) ->
    for n in [1..num]
      createSocket()


  msg = 0

  window.interval = () ->
    setInterval =>
      send()
    , 100

  window.send = () ->
    for socket in sockets
      socket.send("another message " + msg)
      msg++


  window.createIntervals = (num) ->
    for n in [1..num]
      interval()

  # interval() for [1..10]