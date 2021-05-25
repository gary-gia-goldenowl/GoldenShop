# frozen_string_literal: true

Rails.application.routes.draw do
  get 'order_items/create'
  get 'order_items/update'
  get 'order_items/destroy'
  get 'carts/show'
  get 'carts/destroy'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  devise_for :users,
             path: '',
             path_names: { sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'resgistration' },
             controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :products do
    collection do
      match 'search' => 'products#search', via: %i[get post], as: :search
    end
  end
  resources :categories do
    resources :products do
      collection do
        match 'search' => 'products#search', via: %i[get post], as: :search
      end
    end
  end
  resource :cart
  resources :order_items
  root to: 'home#index'
end
