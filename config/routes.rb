Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: "login", sign_up: "register", sign_out: "logout"}
  resources :meals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'about', to: 'welcome#about'
  get 'search_meals', to: 'meals#search'
  get 'result', to: 'meals#result'
  resources :users do
    member do
      get :make_admin
      get :make_default_user
      get :make_manager
    end
  end
end
