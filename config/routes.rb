Poorpeoplebank::Application.routes.draw do

  resources :home, only: [:index]

  devise_for :users

  devise_for :admins do
    get "admin", :to => "devise/sessions#new"
    get "admins", :to => "devise/sessions#new"
  end

  namespace :admin do
    resources :admins, only: [:index,:create,:destroy] do
      collection do
        get :settings
        get :suspended
        post :update_settings
        post :update_password
      end
      member do
        post :desuspend
      end
    end
    resources :organizations, only: [:index,:create,:destroy] do
      collection do
        get :suspended
      end
      member do
        post :desuspend
      end
    end
    resources :users, only: [:index,:destroy] do
      collection do
        get :suspended
      end
      member do
        post :desuspend
      end
    end
    resources :borrowers, only: [:index,:create,:destroy]
    resources :cases, only: [:index,:show,:create,:destroy] do
      collection do
        get :suspended
      end
      member do
        post :desuspend
        post :add_installment
        get :installment
      end
    end
    resources :loans, only: [:index,:destroy]
  end


  resources :cases, only: [:index,:show] do
    member do
      get :lend
      post :lender
      post :like
      post :unlike
    end
  end
  
  resources :users, only: [:show] do
    collection do
      get :settings
      post :update_settings
      post :update_password
      get :credit
    end
    member do
      post :withdraw
    end
  end

  # devise_for :users


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end