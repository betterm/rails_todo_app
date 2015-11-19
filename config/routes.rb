Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_items
  end

  root to: 'todo_lists#index'
end
