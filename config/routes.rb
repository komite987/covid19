Rails.application.routes.draw do

  devise_for :users, path: '',path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users
  root  'searches#home'
  get '/search', to: 'searches#new'
  post '/search', to: 'searches#show'

end
