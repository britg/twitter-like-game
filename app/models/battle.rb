class Battle
  include Mongoid::Document

  embeds_many :participants

  has_and_belongs_to_many :players, inverse_of: nil

end
