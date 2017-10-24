Rails.application.routes.draw do
  root "home_pages#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "sign_up_users#new"
  post "/signup", to: "sign_up_users#create"
  get "/document_new", to: "documents#new"
  post "/document_new", to:"documents#create"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :document
      get :firend
      get :upload
      post :upload
    end
  end
  resources :documents
end
