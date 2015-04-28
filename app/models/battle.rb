class Battle
  include Mongoid::Document

  DEFAULT_INITIATIVE = 100

  has_and_belongs_to_many :players, inverse_of: nil
  has_and_belongs_to_many :npcs, inverse_of: nil

  field :combined_initiative, type: Integer, default: DEFAULT_INITIATIVE

  def victory?
    # TODO determine if any npcs are still alive
    !npcs.where(dead: false).any?
  end

  def participants
    players | npcs
  end

  def active_participants
    players.where(dead: false) | npcs.where(dead: false)
  end

end
