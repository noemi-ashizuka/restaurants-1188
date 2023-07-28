Rails.application.routes.draw do
  devise_for :users
  root to: 'restaurants#index'
  resources :restaurants do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:destroy]
end

# get '/restaurants/top', to: 'restaurants#top', as: :top_restaurants
# collection do
#   get :top
# end
# member do
#   get :chef
# end
# collection -> all restaurants aka don't need an id
# member -> one restaurant aka need the restaurant id


# link_to '', restaurants_path, method: :post
# link_to '', restaurants_path, method: :get
