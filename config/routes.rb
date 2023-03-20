Rails.application.routes.draw do
  resources :roles
  resources :users
  root 'pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'teachers', to: 'users#teachers', as: 'teachers_list'
  get 'students', to: 'users#students', as: 'students_list'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
