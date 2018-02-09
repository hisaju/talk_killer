Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations:      "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: %i[index show]
  resources :tasks
  resources :talks do
    resources :comments do
      resources :replies, only: %i[index create edit update destroy]
    end
    resources :summaries
  end
  resources :conversations do
    resources :messages
  end
  root 'home#index'
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
