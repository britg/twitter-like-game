# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# guard 'livereload' do
#   watch(%r{public/.+\.(css|js|html)})
#   watch %r{web/app/.+\.(js|hbs|html|scss|css|coffee|emblem)}
#   # Rails Assets Pipeline
#   watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
# end

guard 'rails', port: 9292 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

