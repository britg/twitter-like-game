class StorySerializer < ActiveModel::Serializer
  # attributes :player, :events, :actions

  # attribute :player, serializer: PlayerSerializer
  has_one :player
  has_many :events
  has_many :actions

  # def player
  #   PlayerSerializer.new(object, root: false)
  # end

  def events
    player.new_events
  end

  def actions
    player.available_actions
  end

end
