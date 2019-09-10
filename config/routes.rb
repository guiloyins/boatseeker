Rails.application.routes.draw do
  resource :boats, only: [:create]
end
