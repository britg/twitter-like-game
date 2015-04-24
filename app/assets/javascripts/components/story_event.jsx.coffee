@StoryEvent = React.createClass
  render: ->
    eventClasses = ["event", @props.event.status].join(' ')

    <div className=eventClasses>
      <p className="detail">{this.props.event.detail}</p>
      <Actions actions=this.props.actions />
    </div>
