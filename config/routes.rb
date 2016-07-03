Rails.application.routes.draw do
  namespace :admin do
    root 'application#index', via: :get

    resources :projects, only: [:new, :create, :destroy]
    resources :users
  end

  devise_for :users

  root 'projects#index', via: :get

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets
  end
end
