Rails.application.routes.draw do
  root to: 'home#index'
  get :active, to: 'home#active'
  get :favorites, to: 'home#favorites'
  get :followings, to: 'home#followings'
  get :about, to: 'home#about'

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
  resources :users, only: [:edit, :update, :show] do
    get :favorites
    get :followings
    get :joins
    resource :relationships, only: [:create, :destroy]
  end
  resource :setting, only: [:update] do
    get :profile
    get :sns_links
    get :email
    get :password
    patch :update_profile
    patch :update_sns_links
    patch :update_email
    patch :update_password
  end
  resources :job_sites do
    member do
      post :recommend, to: 'job_site_recommends#recommend'
      post :not_recommend, to: 'job_site_recommends#not_recommend'
    end
  end
  resources :feedbacks, only: [:new, :create]
  
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
