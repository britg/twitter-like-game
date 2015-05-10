class window.Api

  @get: (endpoint, callback) ->
    @req(endpoint, callback, "get")

  @req: (endpoint, callback, method, body) ->
    params =
      credentials: 'include'
      method: method
      headers:
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-Token': $('meta[name=csrf-token]').attr("content")

    if body
      params["body"] = JSON.stringify(body)

    fetch endpoint, params
    .then (response) ->
      if response.status != 200
        console.log(response)
      response.json()
    .then (json) ->
      callback.call(null, json)
    .catch (err) ->
      console.log(err)
