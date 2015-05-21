@StoryEvent = React.createClass

  eventClasses: ->
    ["event", this.props.event.format, this.props.event.status].join(' ')

  detailEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  discoveryEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p className="detail">{this.props.event.detail}</p>
      <p>Discovered: {this.props.event.landmark_name}</p>
      <Actions actions=this.props.actions />
    </div>

  aggroEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{this.props.event.attacker} {ent_aggro} {ent_rightArrow} {this.props.event.target}</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  attackEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{this.props.event.attacker} {ent_crossedSwords} {ent_rightArrow} {this.props.event.target} ({this.props.event.delta})</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  npcDeathEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{ent_skullCrossbones} {this.props.event.target}</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  mobApproachEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{ent_aggro} {this.props.event.target}</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  entranceEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{ent_rightArrow} {this.props.event.location_name}</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  resourceEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p><span dangerouslySetInnerHTML={{__html: icon_resource}} /> [{this.props.event.resource_name}]</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>

  itemEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>[{this.props.event.equipment_name}]</p>
      <Actions actions=this.props.actions />
    </div>

  goldEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>+ {this.props.event.gold}g</p>
      <Actions actions=this.props.actions />
    </div>


  render: ->

    switch @props.event.format
      when "detail" then return @detailEvent()
      when "discovery" then return @discoveryEvent()
      when "attack" then return @attackEvent()
      when "aggro" then return @aggroEvent()
      when "npc_death" then return @npcDeathEvent()
      when "mob_approach" then return @mobApproachEvent()
      when "entrance" then return @entranceEvent()
      when "resource" then return @resourceEvent()
      when "item" then return @itemEvent()
      when "gold" then return @goldEvent()
      else
        <div>
          <p>Event type #{@props.event.format} is not defined</p>
        </div>
