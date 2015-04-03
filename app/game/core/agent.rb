class Agent
  class << self
    attr_accessor :default_name, :default_stats
  end

  attr_accessor :name, :stats, :aliases

  def self.name _name
    @default_name = _name.to_sym
  end

  def self.stat name, value
    @default_stats ||= {}
    @default_stats[name.to_sym] = value
  end

  def initialize
    @name = self.class.default_name
    @stats = self.class.default_stats
  end

  def method_missing m, *args, &block
    super
  rescue
    @stats[m.to_sym]
  end
end