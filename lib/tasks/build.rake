require "#{Rails.root}/build/build"

def y(*args) end
namespace :build do
  desc "TODO"

  task clean: :environment do
    rebuild_game!
  end

  task complete: :environment do
    b = Build.new
    b.load_all
    b.hashes
  end

end
