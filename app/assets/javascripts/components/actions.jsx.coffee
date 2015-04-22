@Actions = React.createClass
  onActionClick: (key) ->
    if $('.action[name="' + key + '"]').hasClass('disabled')
      return
    PubSub.publish Events.ACTION_TAKEN, key

  onActionToggle: (key) ->
    if $('.action[name="' + key + '"]').hasClass('expanded')
      @onActionUnExpand(key)
    else
      @onActionExpand(key)

  onActionUnExpand: (key) ->
    $('.action[name="' + key + '"]').removeClass('expanded')
    $('.action[name!="' + key + '"]').removeClass('disabled')
    $('.sub-actions.' + key).fadeOut()

  onActionExpand: (key) ->
    $('.action[name="' + key + '"]')
      .removeClass('disabled')
      .addClass('expanded')
    $('.action[name!="' + key + '"]:visible')
      .removeClass('expanded')
      .addClass('disabled')
    $('.sub-actions.' + key).fadeIn()

  hasSubActions: (action) ->
    action.child_actions != undefined && action.child_actions.length > 0

  actionComponent: (action, index) ->
    symbol = ""
    clickFunc = @onActionClick
    if @hasSubActions(action)
      clickFunc = @onActionToggle
      symbol = "+"
      @subActionsComp.push(@subActionsComponent(action))

    <span name=action.key className="action" key=action.label>
      <a onClick={clickFunc.bind(this, action.key)}>{action.label} {symbol}</a>
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
