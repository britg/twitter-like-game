@NavBar = React.createClass
  navOptionSelected: (key) ->
    PubSub.publish Events.NAV_SELECTED, key
  render: ->

    switch @props.selected
      when "events" then eventsClass = "selected"
      when "inventory" then inventoryClass = "selected"
      when "crafting" then craftingClass = "selected"
      when "landmarks" then landmarksClass = "selected"
      when "stats" then statsClass = "selected"
      when "chat" then chatClass = "selected"

    <div id="navbar">
      <a className=eventsClass onClick={this.navOptionSelected.bind(this, 'events')}>
        <i className="pe-7s-angle-right"></i>
      </a>
      <a className=inventoryClass onClick={this.navOptionSelected.bind(this, 'inventory')}>
        <i className="pe-7s-hammer"></i>
      </a>
      <a className=craftingClass onClick={this.navOptionSelected.bind(this, 'crafting')}>
        <i className="pe-7s-box2"></i>
      </a>
      <a className=landmarksClass onClick={this.navOptionSelected.bind(this, 'landmarks')}>
        <i className="pe-7s-map-2"></i>
      </a>
      <a className=statsClass onClick={this.navOptionSelected.bind(this, 'stats')}>
        <i className="pe-7s-user"></i>
      </a>
      <a className=chatClass onClick={this.navOptionSelected.bind(this, 'chat')}>
        <i className="pe-7s-chat"></i>
      </a>
    </div>
