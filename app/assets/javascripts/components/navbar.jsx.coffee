@NavBar = React.createClass
  navOptionSelected: (key) ->
    PubSub.publish Events.NAV_SELECTED, key
  render: ->
    <div id="navbar">
      <a onClick={this.navOptionSelected.bind(this, 'events')}>Events</a>
      <a onClick={this.navOptionSelected.bind(this, 'inventory')}>Inventory</a>
      <a onClick={this.navOptionSelected.bind(this, 'landmarks')}>Landmarks</a>
      <a onClick={this.navOptionSelected.bind(this, 'stats')}>Stats</a>
      <a onClick={this.navOptionSelected.bind(this, 'chat')}>Chat</a>
    </div>
