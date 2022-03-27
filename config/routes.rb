# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'home#index'
  get 'all_albums', to: 'albums#all_albums'
  get 'draft_album', to: 'albums#draft_album'
  get 'published_album', to: 'albums#published_album'
  resources :albums do
    resources :likes
    collection do
      delete 'delete_image'
    end
  end
  resources :home do
    collection do
      match 'search' => 'home#search', via: %i[get post], as: :search
    end
  end
  get 'search', to: 'albums#search'
  resources :home
  resources :tags
end
