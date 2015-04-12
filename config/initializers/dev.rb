def pl
  @player ||= Player.last
end

def ex
  pl.ex
end

def ap
  pl.action_processor
end

def status
  out = y({new_events: pl.new_events.map(&:to_s).reverse,
    available_actions: pl.available_actions})
  @player = nil
  out
end

def input action_slug
  pl.input action_slug
  status
end

def sk slug, metadata = {}
  pl.sk slug, metadata
  status
end

##
# Rebuilding
##

def rebuild_game!
  reset_locations
  reset_skills
  create_player
end

def load_manifests type
  Dir["#{Rails.root}/app/game/#{type}/*.rb"].each {|file| require file }
end

def reset_locations
  Location.delete_all
  load_manifests(:locations)
end

def reset_skills
  Skill.delete_all
  load_manifests(:skills)
end

def create_player
  PlayerCreator.new.create
end