class Battle
  include Mongoid::Document

  embeds_many :participants

  def processor
    @processor ||= BattleProcessor.new(self)
  end

  def proceed
    processor.proceed
  end

  def input player, action

  end

end
