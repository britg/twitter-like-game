@Actions = React.createClass
  onActionClick: (key) ->
    PubSub.publish Events.ACTION_TAKEN, key

  onActionExpand: (key) ->
    $('.sub-actions.' + key).toggle()

  hasSubActions: (action) ->
    action.child_actions != undefined && action.child_actions.length > 0

  actionComponent: (action, index) ->
    clickFunc = @onActionClick
    if @hasSubActions(action)
      clickFunc = @onActionExpand
      @subActionsComp.push(@subActionsComponent(action))

    <span className="action" key=action.label>
      <a onClick={clickFunc.bind(this, action.key)}>{action.label}</a>
    </span>

  subActionsComponent: (action) ->
    className = ["sub-actions", action.key].join(' ')
    <div className=className key=action.label>
      {action.child_actions.map(this.actionComponent)}
    </div>

  render: ->
    @subActionsComp = []
    <div className="actions">
      {this.props.actions.map(this.actionComponent)}
      {@subActionsComp}
    </div>
