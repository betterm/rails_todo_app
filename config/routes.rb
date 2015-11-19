Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
        patch :not_complete
      end
    end
  end

  root to: 'todo_lists#index'
end
