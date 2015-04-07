class EventBranch
  MAIN = :main

  attr_accessor :name,
                :opts,
                :events,
                :max_sequence

  def initialize name, _opts = {}, context
    @name = name.to_sym
    @opts = opts||{}
    @context = context
    @events = {}
  end

  def parse &block
    instance_eval(&block)
  end

  def event opts = {}, &block
    sequence = @context.parse_sequence += 1
    opts.merge!(sequence: sequence,
                branch_name: @name)
    @building_event = EventTemplate.new(opts)
    instance_eval(&block)
    @events[sequence] = @building_event
    @max_sequence = sequence
    @buidling_event = nil
  end

  def agent name
    @building_event.agent_name = name.to_sym
  end

  def detail text
    @building_event.detail = text
  end

  def dialogue text
    @building_event.dialogue = text
  end

  def action key, metadata = {}
    @building_event.actions[key] = { key: key }.merge(metadata)
  end

  def result key, metadata = {}
    @building_event.results[key] ||= []
    @building_event.results[key] << metadata
  end

  def battle metadata
    @building_event.battle = metadata
  end

  def exit_branch
    @opts[:exit] || MAIN
  end

  def seq int
    if int > max_sequence
      puts "Out of branch bounds: #{name} #{int} / #{max_sequence}. Most likely this context did not end with an action!"
      return exit_branch
      # raise "Out of branch bounds: #{name} #{int} / #{max_sequence}"
    end
    found = @events[int]
    return found if found.present?
    seq(int+1)
    end

end