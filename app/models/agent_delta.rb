class AgentDelta
  include Mongoid::Document

  field :hp, type: Integer

  def to_s
    parts = []
    attributes.each do |name, value|
      parts << "#{name}: #{value}"
    end
    parts.join(' ')
  end

end
