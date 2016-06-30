Rails.application.routes.draw do
  root 'projects#index', via: :get

  resources :projects
end
