class Player
  include Mongoid::Document

  has_one :user

  field :name, type: String

end
