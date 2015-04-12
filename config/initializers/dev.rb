def pl
  Player.last
end

def ex
  pl.ex
end

def ap
  pl.action_processor
end

def input action_slug
  pl.input action_slug
  y({current_event: pl.current_event,
    available_actions: pl.available_actions})
end

##
# Rebuilding
##

def rebuild_game!
  reset_locations
  create_player
end

def reset_locations
  Location.delete_all
  Dir["#{Rails.root}/app/game/locations/*.rb"].each {|file| require file }
end

def create_player
  PlayerCreator.new.create
end