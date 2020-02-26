Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: "login", sign_up: "register", sign_out: "logout"}
  resources :meals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'about', to: 'welcome#about'
  resources :users, only: [:index, :show]
end
