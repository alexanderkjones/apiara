Apiara::Application.routes.draw do

  resources :hive_events

#  resources :hive_days

  match 'unauthorized', :to => 'home#unauthorized'

  match 'hivedays', :to => 'hive_days#index'
  match 'hivedays/:hiveid/:datetime_low/:datetime_high', :to => 'hive_days#hive_days_range', :as => 'hive_days_range'
  match 'hivedays/dash', :to => 'hive_days#dash', :as => 'hive_days_dash'

  resources :devices
  match 'all_devices', :to => 'devices#all_devices'

  resources :hives
  match 'all_hives', :to => 'hives#all_hives'
  match 'pair_device', :to => 'hives#pair_device'

  devise_for :users
  match 'users', :to => 'users#index'
  match 'user_root', :to => 'hive_days#dash'
  
  match 'data_points', :to => 'data_points#index'

  #get "home/index"
  
  root :to => "home#index"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
