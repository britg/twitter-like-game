class StatBlueprint
  include Mongoid::Document

  embedded_in :npc_blueprint

  field :slug, type: String
  field :range, type: Range

  def stat
    Stat.slug(slug)
  end

end
