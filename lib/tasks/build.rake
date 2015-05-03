require "#{Rails.root}/build/build"

def y(*args) end
namespace :build do
  desc "TODO"

  task clean: :environment do
    rebuild_game!
  end

  task update: :environment do
    b = Build.new
    b.update_all
  end

end
