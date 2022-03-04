Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get 'all_albums', to: 'albums#all_albums'
  resources :albums do
    collection do
      delete "delete_image"
    end
  end
  resources :home do
    collection do
      match 'search' => 'home#search', via: [:get, :post], as: :search
    end
  end
  get 'search',to: 'albums#search'
  resources :home
  resources :tags
end
