if defined?(Pry) && Rails.env.development?
  def debug_mongo!
    Moped.logger = Logger.new($stdout)
  end
end
