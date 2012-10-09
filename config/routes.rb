Boutary::Application.routes.draw do
  devise_for :users
  resources :residents
  resources :sales
  resources :products
  post :authenticate, :controller => :store
  get :select_product, :controller => :store
  root :to => "store#index"
end
