Rails.application.routes.draw do
  root "home_pages#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "sign_up_users#new"
  post "/signup", to: "sign_up_users#create"
  post "/add_firend", to:"friends#create"
  get "home_pages/search"
  get "documents/search"
  get "users/search"
  post "coins/number_coins"
  get "comments/:document_id", to: "comments#index", as: "comment"
  post "comments/create", to: "comments#create", as: "comment_create"
  match "documents/download/:id" => "documents#download",via: [:get, :post], as: "download"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :likes
  resources :users do
    member do
      get :upload
      post :upload
    end
    get "histories/index"
    get "payments/index"
    get "payments/new"
    post "payments/create"
    delete "payments/destroy"
    resources :documents
    resources :friends
  end
end
