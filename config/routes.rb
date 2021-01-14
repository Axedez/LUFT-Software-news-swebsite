Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root 'home#index'
  namespace :account do
    namespace :admin do
      resources :users, except: %i[show]
    end
  end

  resources :articles, param: :reference
end
