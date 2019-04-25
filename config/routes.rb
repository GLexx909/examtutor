Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'oauth_callbacks' }

  scope constraints: lambda { |r| r.env['warden'].user.nil? } do
    root 'initials#index'
  end

  scope constraints: lambda { |r| !r.env['warden'].user.nil? } do
    root 'posts#tutor_index'
  end

  concern :votable do
    member do
      post :vote_up
      post :vote_down
    end
  end

  resources :initials, only: [:new, :create] do
    get :get_availability, on: :collection
  end

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

  resources :mailers, only: [:create]
  resources :preregistrations, only: [:new, :create]
  resources :searches, only: [:index]
  resources :attachments, only: :destroy
  resources :attendances
  resources :characteristics
  resources :progresses
  resources :feedbacks, except: [:show, :new]
  resources :course_passages, only: [:new, :create]
  resources :modul_passages, only: [:create]
  resources :notifications, only: [:index, :create, :update] do
    put :update_all, on: :collection
    delete :destroy_all, on: :collection
    post :send_for_all, on: :collection
  end

  resources :messages, only: [:create, :index, :destroy] do
    get :abonents, on: :collection
  end

  resources :posts, concerns: [:votable], shallow: true do
    resources :comments, concerns: [:votable], except: [:index, :show]

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
