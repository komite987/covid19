Rails.application.routes.draw do

  devise_for :users, path: '',path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :users
  root  'searches#home'
  get '/search', to: 'searches#new'
  post '/search', to: 'searches#show'

  get '/404', to: "errors#not_found"
  get "/500", to: "errors#internal_error"
  get '/testing', to: 'searches#testing'

end
