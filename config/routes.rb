Translations::Application.routes.draw do
  resources :keys do
    resources :translations
  end
end
