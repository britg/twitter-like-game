@NavBar = React.createClass
  navOptionSelected: (key) ->
    PubSub.publish Events.NAV_SELECTED, key
  render: ->

    switch @props.selected
      when "events" then eventsClass = "selected"
      when "map" then mapClass = "selected"
      when "equipment" then equipmentClass = "selected"
      when "inventory" then inventoryClass = "selected"
      when "stats" then statsClass = "selected"
      when "quests" then questsClass = "selected"
      when "bestiary" then bestiaryClass = "selected"
      when "chat" then chatClass = "selected"
      when "account" then accountClass = "selected"

    <div id="navbar">
      <a className=eventsClass onClick={this.navOptionSelected.bind(this, 'events')} dangerouslySetInnerHTML={{__html: icon_story}}></a>
      <a className=mapClass onClick={this.navOptionSelected.bind(this, 'map')}>
        <i className="pe-7s-map-2"></i>
      </a>
      <a className=equipmentClass onClick={this.navOptionSelected.bind(this, 'equipment')}>
        <i className="pe-7s-hammer"></i>
      </a>
      <a className=inventoryClass onClick={this.navOptionSelected.bind(this, 'inventory')}>
        <i className="pe-7s-box2"></i>
      </a>
      <a className=statsClass onClick={this.navOptionSelected.bind(this, 'stats')}>
        <i className="pe-7s-user"></i>
      </a>
      <a className=questsClass onClick={this.navOptionSelected.bind(this, 'quests')}>
        <i className="pe-7s-notebook"></i>
      </a>
      <a className=bestiaryClass onClick={this.navOptionSelected.bind(this, 'bestiary')}>
        <i className="pe-7s-bookmarks"></i>
      </a>
      <a className=chatClass onClick={this.navOptionSelected.bind(this, 'chat')}>
        <i className="pe-7s-chat"></i>
      </a>
      <a className=accountClass onClick={this.navOptionSelected.bind(this, 'account')}>
        <i className="pe-7s-settings"></i>
      </a>
    </div>
