class BattleAction
  include Mongoid::Document

  ATTACK = "attack"
  DECISION = "decision"

  field :type, type: String
  field :participant_class, type: String
  field :participant_id, type: BSON::ObjectId

  def attack?
    type == ATTACK
  end

  def decision?
    type == DECISION
  end

  def participant= val
    self.participant_class = val.class
    self.participant_id = val.id
  end

  def participant
    participant_class.constantize.find(participant_id)
  end

  def player?
    participant.player?
  end

  def npc?
    !participant.player?
  end

  def npc_decision?
    npc? && decision?
  end

  def player_decision?
    player? && decision?
  end

end
