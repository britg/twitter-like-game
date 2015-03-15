class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  check_class_collision

  def copy_service_file
    template 'service.rb', "app/services/#{file_name}.rb"
    template 'service_spec.rb', "spec/services/#{file_name}_spec.rb"
  end
end
