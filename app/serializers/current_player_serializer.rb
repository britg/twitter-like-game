class CurrentPlayerSerializer < PlayerSerializer

  attributes :continue_token

  def id
    Player::CURRENT_ID
  end
end
