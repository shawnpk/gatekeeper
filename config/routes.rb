Rails.application.routes.draw do
  devise_for :users
  root 'projects#index', via: :get
  resources :projects do
    resources :tickets
  end
end
