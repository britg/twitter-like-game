def y(*args) end
namespace :build do
  desc "TODO"
  task clean: :environment do
    rebuild_game!
  end

end
