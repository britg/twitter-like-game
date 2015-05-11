class AgentDelta
  include Mongoid::Document

  field :type, type: String, default: "Stat"
  field :slug, type: String
  field :range, type: Range
  field :amount, type: Float

  def to_s
    "#{slug}: #{value}"
  end

  def value
    return amount if amount.present?
    rand(range)
  end

  def stat?
    type == "Stat"
  end

  def skill?
    type == "Skill"
  end


end
