# Architecture

### User / Identity

- Each real person is a 'user' - this is what authenticates

### Characters

- Sidebar of characters who reside at the place you're at


### Places in Town

- sidebar of places known
- discover places by talking to characters

### Quests

- sidebar of quests
- click a quest to visit that quest location

### Player

Real human beings

- auto-generated without auth, can begin playing with no credentials/etc.
- generate a silent token for non-auth players
- can pick up where they left off by cookie storage
- Save progress by creating an account

### Events
embedded in player

- These are the individual events in the timeline
- instantiation of an action

Types:
  - prompt
  - info