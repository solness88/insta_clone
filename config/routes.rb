Rails.application.routes.draw do
  resources :contacts
  get 'sessions/new'
  resources :posts do
    collection do
      post :confirm
    end
    member do
      get :favorite
    end
  end
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :favorites, only: [:create, :destroy, :index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
