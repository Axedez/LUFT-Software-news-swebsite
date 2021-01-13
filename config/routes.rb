Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  namespace :account do
    namespace :admin do
      resources :users, except: %i[show]
    end
  end
end
