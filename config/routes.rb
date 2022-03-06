Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  scope "(:locale)", locale: /en|ar/ do 
    resources :sessions
    resources :homes
    resources :books do 
      get :setting, on: :member
    end
    resources :booths do
      get :setting, on: :member
    end
    resources :operations
    resources :categories  do
      get :setting, on: :member
    end
    resources :users do 
      get :setting, on: :member
      get :change_status, on: :member      
    end
    get 'change_password/:auth_token',to: 'sessions#change_password', as: "change_password"
    get 'login', to: "sessions#new"
  end
end
