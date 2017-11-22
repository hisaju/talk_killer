Rails.application.routes.draw do
  resources :talks
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  #resources :talks, only: %i[index update destroy edit new create]
  #root 'talks#index'
end
