### Combat

- Combat skills are based on the combo of main-hand and off-hand equipped

  - One-handed - MH: weapon, OH: shield
  - Dual-wield - MH: weapon, OH: weapon
  - Two-handed - MH + OH: weapon
  - Ranged - MH + OH: ranged
  - Magic - MH: spellbook, OH: focus
    - special case: remove attack from available options and replace "skills" with "spells"

- Your available skills are based what you have equipped.

### NPC combat

- NPCs have the same setup as players
- Automated combat by them is based on what they're holding.

#### Combat Profiles

- A manifest of conditions and reactions
- Given the current state of the agent, find the first matching condition and then execute the action on it.

  Examples:

  Aggressive Melee Profile
  - Attack at all times!

  Defensive
  - any condition: 50% block, 50% attack

  CombatProfile
    HasSlug
    field :name
    embeds_many CombatProfileCondition


  - Result of a condition match can be:
    - :attack - a basic attack
    - :skill - a random available skill
    - :skill_* - a specific skill

### Processing an attack

  1. Determine if a hit was made by checking the [hit_chance] versus the enemies [dodge]
  2. Determine if it's a critical hit
  3. Determine damage by comparing [attack] against enemies [armor]
      - if critical hit, 2x damage
