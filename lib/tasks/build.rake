require "#{Rails.root}/build/build"

def y(*args) end
namespace :build do
  desc "Tasks for build the game"
  task update: :environment do
    b = Build.new
    b.update_all
  end

  task clean: :environment do
    Build.whipe!
    b = Build.new
    b.update_all
  end

end
