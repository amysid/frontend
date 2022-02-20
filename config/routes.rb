Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  scope "(:locale)", locale: /en|ar/ do 
    resources :sessions
    resources :homes
    resources :books
    resources :booths
    resources :operations
    resources :categories
    resources :users
    get 'change_password/:auth_token',to: 'sessions#change_password', as: "change_password"
    get 'login', to: "sessions#new"
  end
end
