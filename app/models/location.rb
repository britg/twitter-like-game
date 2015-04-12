class Location
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String
  field :path, type: String
  field :entrance_description, type: String
  field :event_timing_range, type: Range, default: 1..10

  embeds_many :landmarks

  index({ slug: 1 }, { unique: true })

  def next_event_delay
    rand(event_timing_range)
  end

  def add_landmark obj
    l = landmarks.new
    l.set_object!(obj)
  end

end