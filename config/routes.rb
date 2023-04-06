Rails.application.routes.draw do
  root to: 'home#index'
  resources :posts
  resources :communities do 
    resource :favorite_community, only: [:create, :destroy]
  end
  resources :tags
  # resources :favorite_communities, only: %i[create destroy]
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
