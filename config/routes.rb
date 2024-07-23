Rails.application.routes.draw do
  resources :data_changes, only: [:create, :update]
end
