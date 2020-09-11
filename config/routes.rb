Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "homepage#index"

  get "/books", to: "books#index"
  get "/books/new", to: "books#new"
  get "books/:id", to: "books#show"
  post "/books", to: "books#create"
end
