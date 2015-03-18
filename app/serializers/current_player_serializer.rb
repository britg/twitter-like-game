class CurrentPlayerSerializer < PlayerSerializer

  def id
    Player::CURRENT_ID
  end
end
