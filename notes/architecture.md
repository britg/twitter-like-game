# Architecture

### User / Identity

- Each real person is a 'user' - this is what authenticates

### Player

- Each addressable URL is a 'player' -- can be driven by a User or by a Boss or an NPC
- Name
- Health
- Attack
- Defense
- Level

### Events

- These are the individual events in the timeline

### Actions

- Actions are templates for events -- an event is an instantiation of an Action with a player

### Battle

- An instantiation of one enemy and one or many player/fighters battling each other
- keeps its own state of the two players, seeded by their stats.
