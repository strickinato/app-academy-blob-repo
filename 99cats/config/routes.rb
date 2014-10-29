NinetyNineCats::Application.routes.draw do
  resources :cats  #, only: [:index]
  resources :cat_rental_requests do
    patch '/approve' => 'cat_rental_requests#approve'
    patch '/deny' => 'cat_rental_requests#deny'
  end
  resource :session, only: [:create, :new, :destroy]
  resource :user, only: [:create, :new]
end
