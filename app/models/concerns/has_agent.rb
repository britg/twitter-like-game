module HasAgent
  extend ActiveSupport::Concern

  included do
    embeds_one :agent
    delegate :skills, to: :agent
    delegate :stats, to: :agent
    delegate :slots, to: :agent
  end

  def method_missing m, *args
    agent.send(m)
  end


end