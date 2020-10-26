Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "homepage#index"

  get "/books", to: "books#index"
  get "/books/new", to: "books#new"
  get "books/:id", to: "books#show"
  post "/books", to: "books#create"
  delete "/books/:id", to: "books#destroy"

  namespace :api do
    namespace :v1 do
      get "/authors/:id", to: "authors#show"
      get "/books", to: "books#index"
      get "/books/:id", to: "books#show"
    end
  end
end
