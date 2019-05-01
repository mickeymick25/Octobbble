Rails.application.routes.draw do
  resources :projects
  resources :shots

  #devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "projects#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
