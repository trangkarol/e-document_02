Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post 'sign_up', to: 'users/sessions#create'
  end
  root "home_pages#index"
  post "/add_firend", to:"friends#create"
  get "home_pages/search"
  get "documents/search"
  get "users/search"
  post "coins/number_coins"
  get "comments/index/:document_id", to:"comments#index", :as => "comment"
  post "comments/create", to:"comments#create", :as => "comment_create"
  get "documents/statictis/:document_id", to:"documents#statictis", :as => "list_statictis"
  get "likes/index/:document_id", to:"likes#index", :as => "list_members_liked"
  match "documents/download/:id" => "documents#download",via: [:get, :post], :as => "download"
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
