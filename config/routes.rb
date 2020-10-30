Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get "/", to: "sessions#auto_login"
      get "/auto_login", to: "sessions#auto_login"
      get '/flowers', to: 'plants#flowers'
      get '/food', to: 'plants#food'
      get '/getImage', to: 'plants#getImage'
      post '/userplants', to: 'plants#userplants'
      post '/identifier', to: 'identifier#getImageId'
      map.connect 'identifier/:getImageId', :controller => 'indentifier'
      resources :plants, :user_plant_comments, :user_plants, :users, :sessions
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
