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

def debug *args
  return nil unless Rails.env.development?
  puts args.join(', ')
end

def r
  reload!
  status
end

##
# Rebuilding
##

def rebuild_game!
  r
  @build ||= []
  reset_skills
  reset_npcs
  reset_locations
  @build.each do |proc|
    proc.call
  end
  reset_player
  status
end

def load_manifests type
  Dir["#{Rails.root}/lib/#{type}/*.rb"].each {|file| require file }
end

def reset_npcs
  Npc.delete_all
  load_manifests(:npcs)
end

def reset_locations
  Location.delete_all
  load_manifests(:locations)
end

def reset_skills
  Skill.delete_all
  load_manifests(:skills)
end

def reset_player
  Player.delete_all
  PlayerCreator.new.create
end