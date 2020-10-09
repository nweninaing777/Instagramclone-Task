Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'users#new'
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only: [:new, :create, :show, :edit, :update]
    resources :favorites, only: [:create, :destroy]
    get '/users/:id/favorites', to: 'users#favorites'
    resources :pictures do
      collection do
        post :confirm
      end
    end
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  end
