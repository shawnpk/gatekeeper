Rails.application.routes.draw do
  root 'projects#index', via: :get

  resources :projects do
    resources :tickets
  end
end
