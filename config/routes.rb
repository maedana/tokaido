Rails.application.routes.draw do
  root 'todos#index'
  resources :todos, only: %i[index edit] do
    member do
      post :save_elapsed_time
    end
  end
  resources :overdue_todos, only: %i[index]
  resources :due_soon_todos, only: %i[index]
  resources :projects do
    resources :todos, only: %i[index], module: :projects
  end
end
