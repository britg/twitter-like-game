class BattleTemplate

  attr_accessor :participants

  def initialize template
    @participants = template[:participants]
  end

end