@StoryEvent = React.createClass

  onActionClick: (key) ->
    PubSub.publish Events.ACTION_TAKEN, key

  actionComponent: (action, index) ->
    <span className="action" key=action.label>
      <a onClick={this.onActionClick.bind(this, action.key)}>{action.label}</a>
    </span>

  render: ->
    eventClasses = ["event", @props.event.status].join(' ')

    <div className=eventClasses>
      <p className="detail">{this.props.event.detail}</p>
      {this.props.actions.map(this.actionComponent)}
    </div>
