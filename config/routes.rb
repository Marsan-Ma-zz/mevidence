Rails.application.routes.draw do

  mount_roboto
  root to: 'home#index'

  resources :doctors
  resources :hospitals
  resources :tracks, :only => ['index']

end
