Rails.application.routes.draw do
  resources :projects do
    resources :shots
  end

  #devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
