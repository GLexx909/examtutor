Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  scope constraints: lambda { |r| r.env['warden'].user.nil? } do
    root 'initials#index'
  end

  root 'posts#tutor_index'

  resources :initials, only: [:new, :create]

  resources :posts do
    get :tutor_index, on: :collection
  end
end
