### Initiative

Initiative, among other things, determines the who goes first in a battle.

A battle queue has 100 point markers.


- The player with the highest ap goes first.
- If there is a tie in ap, use dexterity.
- if there is a tie in dexterity, then random.
- Loop over each participant in a battle and add their AP to their previous AP value
- If that value is > 100, loop back around to 0 + overhang and it becomes that participants turn.
