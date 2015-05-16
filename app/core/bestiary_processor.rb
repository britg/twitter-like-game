class BestiaryProcessor

  def initialize player, npc
    @player = player
    @npc = npc
  end

  def npc_blueprint
    @npc_blueprint ||= @npc.npc_blueprint
  end

  def bestiary_state
    @bestiary_state ||= @player.bestiary_states.where(npc_blueprint: npc_blueprint).first
  end

  def observe
    # TODO assign beast lore based on some algorithm
    if !bestiary_state.present?
      create_bestiary_state
      @player.use_skill(:beast_lore)
    end

    @player.add_event(
      detail: @npc.observation_details.sample
    )
  end

  def ensure_bestiary_state
    create_bestiary_state unless bestiary_state.present?
  end

  def create_bestiary_state
    @bestiary_state = @player.bestiary_states.create(
      npc_blueprint: npc_blueprint
    )
  end

end