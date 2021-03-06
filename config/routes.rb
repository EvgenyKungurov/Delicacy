Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/brainstorage', as: 'rails_admin'
  # mount ActionCable.server => '/cable'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'menu#index'
  resources :orders, only: [:create, :new]
  resources :order_items, only: [:update, :destroy]
  resources :orders_panel, only: [:index]
  resources :menu, only: [:index, :show]
  resources :statistics, only: [:index]

  get '/...', to: 'menu#index'
end
