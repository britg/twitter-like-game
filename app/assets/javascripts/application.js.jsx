//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require react
//= require react_ujs
//= require react-router
//= require constants
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

  getInitialState: function () {
    var playerString = $('#current_player_seed').val();
    var player = JSON.parse(playerString);
    return player;
  },

  componentDidMount: function () {
    PubSub.subscribe(Events.ACTION_TAKEN, this.actionTaken);
  },

  actionTaken: function (key) {
    var $this = this;
    fetch(Endpoints.PLAYER, {
      method: 'PATCH',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': $('meta[name=csrf-token]').attr("content")
      },
      body: JSON.stringify({ player: {selected_action_key: key} })
    }).then(function (response) {
      return response.json();
    }).then(function (player_json) {
      $this.setState(player_json);
    });
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
