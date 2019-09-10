Rails.application.routes.draw do
  resources :boats, only: [:create, :show, :destroy]
end
