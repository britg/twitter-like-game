class SceneAnchor
  include Mongoid::Document

  field :scene_slug, type: String
  field :sequence, type: Integer
  field :waypoint, type: String

end