@StoryEvent = React.createClass

  eventClasses: ->
    ["event", this.props.event.type, this.props.event.status].join(' ')

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

  attackEvent: ->
    <div className={this.eventClasses(this.props.event)}>
      <p>{this.props.event.attacker} {ent_crossedSwords} {ent_rightArrow} {this.props.event.target} ({this.props.event.delta})</p>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>


  render: ->
    switch @props.event.type
      when "detail" then return @detailEvent()
      when "discovery" then return @discoveryEvent()
      when "attack" then return @attackEvent()
      else
        <div>
          <p>Event type #{@props.event.type} is not defined</p>
        </div>
