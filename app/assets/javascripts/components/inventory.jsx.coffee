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
          <th>L Hand</th>
          <th>R Hand</th>
          <th></th>
        </tr>
        <tr>
        </tr>
        <tr>
          <th>Head</th>
          <th>Shoulders</th>
          <th>Back</th>
        </tr>
        <tr>
        </tr>
        <tr>
          <th>Chest</th>
          <th>Legs</th>
          <th>Feet</th>
        </tr>
        <tr>
        </tr>
        <tr>
          <th>L Ring</th>
          <th>R Ring</th>
          <th>Neck</th>
        </tr>
        <tr>
        </tr>

      </table>


    </div>
