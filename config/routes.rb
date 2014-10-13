Rails.application.routes.draw do
  resources :holidays

  resources :users
  resources :indices
  resources :votes
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'login' => 'login#show'
  get 'login2' => 'login#login_with_password'
  post 'login/login' => 'login#login'
  get 'logout' => 'login#logout'
  get 'register' => 'users#new'
  
  get 'profile' => 'users#profile'
  
  get 'vote_:upshot' => 'votes#do_vote'

  get 'admin' => 'admin/home#index'
  get 'update_user_vote'  => 'admin/votes#update_user_vote'
  
  post 'blogs' => 'blogs#create'
  get 'set_p' => 'users#set_password'
  put 'update_password' => 'users#update_password'
  patch 'update_password' => 'users#update_password'
  
  get 'award' => 'users#award'
  get 'about' => 'users#about'
  get 'faq' => 'users#faq'
  
  get ':id' => 'users#show', :constraints => { :id => /\d+/ }

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
