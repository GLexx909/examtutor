Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  scope constraints: lambda { |r| r.env['warden'].user.nil? } do
    root 'initials#index'
  end

  scope constraints: lambda { |r| !r.env['warden'].user.nil? } do
    root 'posts#tutor_index'
  end

  resources :initials, only: [:new, :create]
  resources :profiles

  resources :courses, shallow: true do
    resources :moduls do
      post :sort, on: :collection

      resources :topics do
        post :sort, on: :collection
        resources :topic_passages, only: [:update]
        resources :questions do
          resources :question_passages, only: [:create]
          resources :answers, only: [:destroy, :edit, :update]
        end
      end

      resources :essays do
        resources :essay_passages, only: [:new, :show, :create, :update] do
          patch :update_status, on: :member
        end
      end

      resources :tests do
        get :start, on: :member

        resources :test_passages, only: [:show] do
          patch :update_status, on: :member
        end
        resources :questions do
          resources :question_passages, only: [:create]
          resources :answers, only: [:destroy, :edit, :update]
        end
      end
    end
  end

  resources :course_passages, only: [:new, :create]
  resources :modul_passages, only: [:create]
  resources :notifications, only: [:index, :create, :update]

  resources :messages, only: [] do
    get :abonents, on: :collection
  end

  resources :posts do
    get :tutor_index, on: :collection
    get :own_index, on: :collection
    get :guests_index, on: :collection
  end

  namespace :admin do
    resources :mainmenus, only: [:index]
    resources :one_time_passwords, only: [:new, :create]
  end

  mount ActionCable.server => '/cable'
end
