Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index] do
    member do
      patch :set_admin
      patch :remove_admin
    end
  end



  resources :projects

  get "home/index"


  get "home/about"
  # root "home#index"
  root "projects#index"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
