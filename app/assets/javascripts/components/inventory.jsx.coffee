@Inventory = React.createClass
  render: ->
    <div id="inventory">
      <table className="stats">
        <tr>
          <td className="stat-name">str</td><td className="stateValue">10</td>
          <td className="stat-name">dex</td><td className="stateValue">145</td>
          <td className="stat-name">int</td><td className="stateValue">10</td>
          <td className="stat-name">stam</td><td className="stateValue">10</td>
          <td className="stat-name">luck</td><td className="stateValue">10</td>
        </tr>
      </table>

      <table className="equipment">
        <tr>
          <td className="slot-name">Main Hand</td>
          <td></td>
        </tr>
        <tr>
          <td className="slot-name">Off Hand</td>
          <td></td>
        </tr>
      </table>


    </div>
