class AgentDelta < ActiveHash::Base

  field :hp

  def to_s
    parts = []
    attributes.each do |name, value|
      parts << "#{name}: #{value}"
    end
    parts.join(' ')
  end

end
