class SceneChange

  attr_accessor :scene_slug,
                :battle_template

  def to_battle?
    @scene_slug == :battle
  end

end