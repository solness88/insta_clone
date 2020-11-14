Rails.application.routes.draw do
  get 'sessions/new'
  resources :posts do
    collection do
      post :confirm
    end
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
end
