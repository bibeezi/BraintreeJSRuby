Rails.application.routes.draw do
  # get 'payments/checkout'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'payments#checkout'
  post '/payments/transaction'
  post '/payments/subscription'
end
