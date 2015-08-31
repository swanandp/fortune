Rails.application.routes.draw do
  resources :subscription_requests, only: [:create] do
    member do
      get "confirm"
    end
  end

  root to: "site#index"
end
