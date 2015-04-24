if defined?(Pry) && Rails.env.development?
  Moped.logger = Logger.new($stdout)
end
