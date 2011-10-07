Translations::Application.routes.draw do
  resources :keys do
    resources :translations
  end
  
  get "login" => "sessions#new", :as => :login
  get "logout" => "sessions#destroy", :as => :logout
  post "sessions/create" => "sessions#create", :as => :create_session

end
