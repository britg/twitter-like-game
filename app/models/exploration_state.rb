class ExplorationState
  include Mongoid::Document

  embedded_in :player

  field :last_event_time, type: DateTime, default: ->{ Time.now }
  field :current_event_count, type: Integer
  field :current_battle_count, type: Integer

  def in_battle?
    player.in_battle?
  end

end