# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/controllers/.+\.(rb)$})
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{app/decorators/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg|jsx|scss))).*}) { |m| "/assets/#{m[3]}" }
end

guard 'rails', host: "0.0.0.0", port: 9292 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end
