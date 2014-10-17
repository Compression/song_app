Rails.application.routes.draw do

  get '/search', to: 'recommendations#new'
  get '/results', to: 'recommendations#show'
  post '/search', to: 'recommendations#create'

  root "recommendations#new"
end
