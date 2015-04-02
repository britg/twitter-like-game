# @cjsx React.DOM

@EventStream = React.createClass
  dispalyName: "EventStream",

  getInitialState: ->
    events: []

  componentDidMount: ->
    @fetchEvents()

  fetchEvents: ->
    fetch("/api/v1/players/current.json?continue_token=eKxKThKXDsxd-cN94-oK")
      .then (response) ->
        console.log(response.json())

  render: ->
    <div>Event Stream React Component {@props.cheese}</div>