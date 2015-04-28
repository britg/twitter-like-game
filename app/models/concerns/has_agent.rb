module HasAgent
  extend ActiveSupport::Concern

  included do
    embeds_one :agent
    delegate :skills, to: :agent
    delegate :stats, to: :agent
    delegate :slots, to: :agent
    field :dead, type: Boolean, default: false
  end

  def method_missing m, *args
    agent.send(m, *args)
  end

  def check_dead
    if agent.dead?
      update_attributes(dead: true)
    end
  end

end
