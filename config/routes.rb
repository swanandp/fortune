Rails.application.routes.draw do
  resources :subscription_requests, only: [ :create ]

  root to: "site#index"
end
