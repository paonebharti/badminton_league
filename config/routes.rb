Rails.application.routes.draw do
  resources :players
  resources :matches, except: :show

  root 'players#index'
end
