Rails.application.routes.draw do
  devise_for :users
  root 'initials#main'
end
