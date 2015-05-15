class Location
  include Mongoid::Document
  include HasSlug

  belongs_to :zone

  field :name, type: String
  field :description, type: String

  field :story, type: Array
  field :entrance_details, type: Array
  field :explore_details, type: Array
  field :observe_details, type: Array

  embeds_many :landmarks
  index({"landmarks.slug" => 1})

  embeds_many :mobs # A reference to an NPC Blueprint with attached rarity
  embeds_many :resource_nodes

  def to_s
    name
  end

  def add_landmark obj
    l = landmarks.new
    l.set_object!(obj)
  end

  def entrance_detail
    return default_entrance_detail unless entrance_details.present?
    entrance_details.sample
  end

  def default_entrance_detail
    "You enter #{name}..."
  end

  def explore_detail
    return default_explore_detail unless explore_details.present?
    explore_details.sample
  end

  def default_explore_detail
    "You explore the surrounding area..."
  end

end
