Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  scope constraints: lambda { |r| r.env['warden'].user.nil? } do
    root 'initials#index'
  end

  scope constraints: lambda { |r| !r.env['warden'].user.nil? } do
    root 'posts#tutor_index'
  end

  resources :initials, only: [:new, :create]

  resources :posts do
    get :tutor_index, on: :collection
  end

  namespace :admin do
    resources :mainmenus, only: [:index]
    resources :one_time_passwords, only: [:new, :create]
  end
end
