@Inventory = React.createClass
  changeTab: (tab) ->

  render: ->
    <div id="inventory">
      <h1>Inventory</h1>

      <ul className="inventory-tabs">
        <li>
          <a onClick={this.changeTab.bind(this, "consumables")}>Consumables</a>
        </li>
        <li>
          <a onClick={this.changeTab.bind(this, "equipment")}>Equipment</a>
        </li>
        <li>
          <a onClick={this.changeTab.bind(this, "quest")}>Quest</a>
        </li>
        <li>
          <a onClick={this.changeTab.bind(this, "vendor")}>Vendor</a>
        </li>
      </ul>
    </div>
