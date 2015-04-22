@Actions = React.createClass
  getInitialState: ->
    activeKey: null

  onActionClick: (key) ->
    $sel = $('.action[name="' + key + '"]')
    return if $sel.hasClass('disabled')
    if $sel.hasClass('group')
      if $sel.hasClass('expanded')
        @setState(activeKey: null)
      else
        @setState(activeKey: key)
    else
      PubSub.publish Events.ACTION_TAKEN, key

  hasSubActions: (action) ->
    action.child_actions != undefined && action.child_actions.length > 0

  actionComponent: (action, index) ->
    classNames = ["action"]
    symbol = ""

    if @hasSubActions(action)
      classNames.push "group"
      symbol = "+"
      @subActionsComp.push(@subActionsComponent(action))

    if @state.activeKey?
      if @state.activeKey == action.key
        classNames.push "expanded"
      else if !action.key.match('->')? # it's a sub-action
        classNames.push "disabled"

    classStr = classNames.join(' ')

    <span name=action.key className=classStr key=action.label>
      <a onClick={this.onActionClick.bind(this, action.key)}>{action.label} {symbol}</a>
    </span>

  subActionsComponent: (action) ->
    classNames = ["sub-actions", action.key]
    if @state.activeKey == action.key
      classNames.push('active')

    className = classNames.join(' ')

    <div className=className key=action.label>
      {action.child_actions.map(this.actionComponent)}
    </div>

  render: ->
    @subActionsComp = []
    <div className="actions">
      {this.props.actions.map(this.actionComponent)}
      {@subActionsComp}
    </div>
