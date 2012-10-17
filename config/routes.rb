Boutary::Application.routes.draw do
  devise_for :users
  resources :residents
  resources :sales do
    collection do
      get :list
    end
  end
  resources :product_natures
  resources :products
  get :admin, :to => "admin#index"
  post :authenticate, :controller => :store
  get :select_product, :controller => :store
  get :fill, :controller => :store
  post :pay, :controller => :store
  match "finish/:id", :to => "store#finish", :as => :finish
  match "cancel/:id", :to => "store#cancel", :as => :cancel
  match "refuse/:id", :to => "store#refuse", :as => :refuse
  root :to => "store#index"
end
