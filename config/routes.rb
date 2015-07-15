Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:index]
  end

  resources :cat_rental_requests, except: [:index] do
    post '/approve', to: "cat_rental_requests#approve", as: 'approve'
    post '/deny', to: "cat_rental_requests#deny", as: 'deny'
  end

end
