# Architecture

### User / Identity

- Each real person is a 'user' - this is what authenticates

### Characters

- Sidebar of characters who reside at the place you're at

### Quests

- sidebar of quests
- click a quest to visit that quest location

### Player

Real human beings

- auto-generated without auth, can begin playing with no credentials/etc.
- generate a silent token for non-auth players
- can pick up where they left off by cookie storage
- Save progress by creating an account

### Location

### StoryLine

- Attached to a location
- has many event_templates
- types: linear, random
- locations can have multiple story lines, typically two: the initial linear story line and the random-event phase.
- enter story lines through interactions

### Event Template

### Events
- These are the individual events in the timeline
- instantiation of an action

Types:
  - prompt
  - info

### Story Beats



Actions

- Continue | continue
- Respond |