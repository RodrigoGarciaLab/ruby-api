Rails.application.routes.draw do

  
  resources :orders, :only => [:show, :index, :create, :update, :destroy] do
    resources :order_products
  end
  
  resources :users, :only => [:show, :index, :create, :update, :destroy] 
  resources :products, :only => [:show, :index, :create, :update, :destroy]
  
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end

