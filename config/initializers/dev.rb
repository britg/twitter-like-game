def pl
  @player ||= Player.last
end

def ex
  pl.ex
end

def ap
  pl.action_processor
end

def recent
  y pl.recent_events.map(&:to_s).reverse
  status
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
  @build ||= []
  reset_stats
  reset_skills
  reset_resources
  reset_npcs
  reset_locations
  reset_battles
  @build.each do |proc|
    proc.call
  end
  sleep 1
  reset_player
  status
end

def clean
  @build = []
end

def load_manifests type
  Dir["#{Rails.root}/lib/#{type}/**/*.rb"].each {|file| require file }
end

def reset_npcs
  Npc.delete_all
  load_manifests(:npcs)
end

def reset_locations
  Location.delete_all
  load_manifests(:locations)
end

def reset_resources
  Resource.delete_all
  load_manifests(:resources)
end

def reset_stats
  Stat.delete_all
  load_manifests(:stats)
end

def reset_skills
  Skill.delete_all
  load_manifests(:skills)
end

def reset_battles
  Battle.delete_all
end

def reset_player
  Player.delete_all
  PlayerCreator.new.create
end
