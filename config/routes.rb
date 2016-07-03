Rails.application.routes.draw do
  namespace :admin do
    root 'application#index', via: :get
  end

  devise_for :users

  root 'projects#index', via: :get

  resources :projects do
    resources :tickets
  end
end
