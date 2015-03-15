Rails.application.routes.draw do

  root to: "application#ember_start"

  match '*path', via: :all, to: "application#ember_start"

end
