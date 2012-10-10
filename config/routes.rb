Boutary::Application.routes.draw do
  devise_for :users
  resources :residents
  resources :sales
  resources :product_natures
  resources :products
  get :admin, :to => "admin#index"
  post :authenticate, :controller => :store
  get :select_product, :controller => :store
  get :fill, :controller => :store
  root :to => "store#index"
end
