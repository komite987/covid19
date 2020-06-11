Rails.application.routes.draw do

  root  'searches#home'
  get '/search', to: 'searches#new'
  post '/search', to: 'searches#show'
end
