# Items

An item is anything that can be picked up, equipped, sold. Quest items are a different class and are handled differently.

## Item Types

- Vendor: varying degrees of sale price
- Consumable: potions, bandages, buffs, scrolls
- Equipment: Armor, Weapons, Accessories, anything that goes in a slot
- Quest: turn-ins

### Equipment

- belongs_to :slot
- has_many :stat_bonuses
- has_many :skill_bonuses
- field :level_requirement
- has_many :stat_requirements
- has_many :skill_requirements

### Equipment Blueprint

Equipment blueprints are ranges of attributes and bonuses that are randomly generated.

- Blueprint for each equipment type, level range, rarity?


### Item Generation

Determine the following, then use that to figure out which blueprint to access?
- Type
- Level
- Rarity
