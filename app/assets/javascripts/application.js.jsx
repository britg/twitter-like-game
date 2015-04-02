//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require react
//= require react_ujs
//= require react-router
//= require components
//= require moment
//= require pubsub
//= require fetch

var Router = ReactRouter;
var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var Game = React.createClass({

  propTypes: {
  },

  render: function() {
    return (
      <div id="game">
        <Player />
        <EventStream />
      </div>
    );
  }
});

var routes = (
  <Route name="game" path="/" handler={Game}>
    <DefaultRoute handler={Game}/>
  </Route>
);

Router.run(routes, Router.HistoryLocation, function (Handler) {
  React.render(<Handler/>, document.getElementById('game'));
});