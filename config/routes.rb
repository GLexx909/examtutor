Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'initials#index'

  resources :initials, only: [:new, :create]

  resources :posts do
    get :tutor_index, on: :collection
  end
end
