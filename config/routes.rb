Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard", as: :dashboard
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :pets do
    resources :vaccinations, only: %[new create]
    resources :allergies, only: %[new create]
    resources :conditions, only: %[new create]
    resources :tranings, only: %[index new create]
    resources :nutritions, only: %[index new create]
  end

  resources :vaccinations, only: %[edit update destroy]
  resources :allergies, only: %[edit update destroy]
  resources :conditions, only: %[edit update destroy]

  resources :vaccines, except: %i[new create]
  resources :conditions, except: %i[new create]
  resources :allergens, except: %i[new create]
  resources :trainings, except: %i[index new create]
  resources :nutritions, except: %i[index new create]

  resources :veterinaries do
    resources :services, only: %[new create]
  end

  resources :services, except: %[new create] do
    resources :appointments, only: %[new create]
  end

  resources :appointments, except: %[new create] do
    member do
      patch 'update_status'
    end
  end

  get 'profile', to: 'users#profile', as: :profile
end
