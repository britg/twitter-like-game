class Scene
  EVENT_START_INDEX = 1

  class << self
    attr_accessor :branches, :parse_sequence
  end

  def self.init
    @parse_sequence ||= 0
    @branches ||= {}
  end

  def self.location slug = nil
    if slug
      @location = Location.where(slug: slug).first
      raise "Location not found/created: #{slug}" unless @location.present?
    else
      @location
    end
  end

  def self.main_branch
    init
    return @main_branch if @main_branch.present?
    @main_branch = @branches[EventBranch::MAIN] = EventBranch.new(EventBranch::MAIN, self)
  end

  def self.event opts = {}, &block
    main_branch.event opts, &block
  end

  def self.branch branch_name, opts = {}, &block
    init
    branch_name = branch_name.to_sym
    raise "Branch already exists" if @branches[branch_name].present?
    branch = EventBranch.new(branch_name, opts, self)
    @branches[branch_name] = branch
    branch.parse &block
  end

  def self.marker current_sequence = 1
    SceneMarker.new(self, current_sequence)
  end

  def self.branch_exists? branch_name
    branch_name = branch_name.to_sym
    branches[branch_name].present?
  end

  def self.find_event seq
    branches.each do |name, branch|
      event = branch.events[seq]
      return event if event.present?
    end
    raise "Event not found: seq #{seq}"
  end
end