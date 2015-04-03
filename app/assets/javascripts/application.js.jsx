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

var Events = {
  ACTION_TAKEN: "action:taken"
}

var Router = ReactRouter;
var DefaultRoute = Router.DefaultRoute;
var Link = Router.Link;
var Route = Router.Route;
var RouteHandler = Router.RouteHandler;

var Game = React.createClass({

  playerEndpoint: function () {
    return "/api/v1/players/current.json?continue_token=" + this.state.player.continue_token;
  },

  getInitialState: function () {
    var playerString = $('#current_player_seed').val();
    var player = JSON.parse(playerString);
    return player;
  },

  componentDidMount: function () {
    $this = this;
    PubSub.subscribe(Events.ACTION_TAKEN, this.actionTaken);
  },

  actionTaken: function (key) {
    console.log("Application pubsub", key);
  },

  render: function() {
    return (
      <div id="game">
        <Player id="player" player={this.state.player} />
        <Story id="story"
               events={this.state.player.events} />
      </div>
    );
  }
});

var routes = (
  <Route name="game" path="/" handler={Landing}>
    <Route name="location" path="/*" handler={Game} />
    <DefaultRoute handler={Landing}/>
  </Route>
);

var mountPoint = document.getElementById('mount-point');

if (mountPoint != null) {
  Router.run(routes, Router.HistoryLocation, function (Handler) {
    React.render(<Handler/>, mountPoint);
  });
}
