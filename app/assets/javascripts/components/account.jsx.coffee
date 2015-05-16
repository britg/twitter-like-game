@Account = React.createClass
  render: ->
    <div id="account">
      <h1>Account</h1>
      <form method="post" action=Routes.reset_path()>
        <input type="hidden" name="authenticity_token" value=Api.token() />
        <button type="submit">Reset</button>
      </form>
      <form method="post" action=Routes.rebuild_path()>
        <input type="hidden" name="authenticity_token" value=Api.token() />
        <button type="submit">Rebuild</button>
      </form>
    </div>