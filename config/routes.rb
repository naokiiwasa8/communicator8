Rails.application.routes.draw do
  root to: 'home#index'
  get :active, to: 'home#active'
  get :favorites, to: 'home#favorites'
  get :follows, to: 'home#follows'

  resources :posts
  resources :communities do 
    resource :favorite_community, only: [:create, :destroy]
    resources :posts, module: :communities do
      collection do
        get :cancel
      end
    end
  end
  resources :tags
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show] 
  resource :setting, only: [:update] do
    get :profile
    get :sns_links
    get :email
    get :password
  end
  devise_for :users,
    path: '',
    path_names: {
      sign_up: '',
      sign_in: 'login',
      sign_out: 'logout',
      registration: "signup",
    },
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      passwords: "users/passwords"
    }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
