EmberCLI.configure do |c|
  c.app :web
  c.app :web, build_timeout: 10
end
