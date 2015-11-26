Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :user_sessions, only: [:new, :create, :destroy]


  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
        patch :not_complete
      end
    end
  end

  namespace :api do
    resources :todo_lists do
      resources :todo_items, only: [:create, :update, :destroy, :complete, :not_complete] do
        member do
          patch :complete
          patch :not_complete
        end
      end
    end
  end


  root to: 'todo_lists#index'
end
