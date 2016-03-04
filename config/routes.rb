Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'journals#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :journals do
    resources :years do
      resources :issues do
        resources :articles
      end
    end
  end

  resources :authors
  resources :users
  get 'login'    => 'users#login'
  get 'users/:id/edit_admin' => 'users#edit_admin', as: :edit_admin
  post 'logged'  => 'users#logged'
  delete 'destroy_user_session' => 'users#destroy_user_session'

  namespace :api do
    namespace :v1 do
      # get 'journals' => 'journals#index'
      get 'journals/:textSearch/page/:page'  => 'journals#search'
      get 'journals/suggestion/:textSuggest' => 'journals#suggestion'
      post 'journals/:textSearch/facet/page/:page' => 'journals#facet'
      # get 'getarticle/:article_id' => 'journals#get_article'
      # get 'getauthor/:author_id' => 'journals#get_author'
    end
  end

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
