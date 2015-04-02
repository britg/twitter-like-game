# @cjsx React.DOM
Route = ReactRouter.Route

routes = (
  <Route name="app" path="/" handler={EventStream}>
    <Route name="test" path="/test" handler={EventStream} />
  </Route>
)

ReactRouter.run routes, ReactRouter.HistoryLocation, (Handler) ->
  React.render <Handler/>, $('#test')[0]
