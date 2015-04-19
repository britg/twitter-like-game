class Location
  include Mongoid::Document
  include HasSlug

  field :name, type: String
  field :path, type: String
  field :entrance_details, type: Array
  field :explore_details, type: Array
  field :observe_details, type: Array
  field :event_timing_range, type: Range, default: 1..10

  embeds_many :landmarks
  index({"landmarks.slug" => 1}, {unique: true})

  def to_s
    name
  end

  def next_event_delay
    rand(event_timing_range)
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
    "You explore the surrounding area"
  end

end
