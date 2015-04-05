class AbilityHandler

  attr_accessor :player, :ability, :metadata

  def initialize _player, _ability, _metadata
    @player = _player
    @ability = _ability
    @metadata = _metadata
  end

  def metadata
    @ability.first
  end

  def extract_agent slug
    return @player if slug == :player
    Agent.where(slug: slug).first || raise "Agent #{slug} not found"
  end

  def apply
    @from = extract_agent(@ability)
  end

end