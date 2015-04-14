module HasAgent
  extend ActiveSupport::Concern

  included do
    embeds_one :agent
    delegate :skills, to: :agent
    delegate :stats, to: :agent
    index({"agent.stats.slug": 1}, {unique: true})
    delegate :slots, to: :agent

    # Convenience methods
    delegate :str, to: :agent
    delegate :dex, to: :agent
    delegate :stam, to: :agent
    delegate :int, to: :agent
    delegate :luck, to: :agent
    delegate :hp, to: :agent
    delegate :ap, to: :agent
    delegate :mana, to: :agent


  end


end