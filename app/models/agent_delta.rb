class AgentDelta
  include Mongoid::Document

  field :type, type: String
  field :slug, type: String
  field :amount, type: Integer

  def to_s
    "#{slug}: #{amount}"
  end

end
