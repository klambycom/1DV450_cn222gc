ToerhClient::Application.routes.draw do
  resources :home
  get 'auth/toerh_doorkeeper/callback', to: 'home#callback'
  root 'home#index'
  get '*path', to: 'home#index'
end
