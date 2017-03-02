Rails.application.routes.draw do

  root to: 'static_pages#home'
  
  get 'signup', to:'users#new'
  get 'login', to:'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  
  #操作や表示を行えるようにリソースメソッドを行う
  #resources :users
  #マイクロポストを使えるようにリソースメソッドを行う
  #ポストHTTPメソッドとリツイートアクションを追加
  resources :microposts do
    member do
      post 'retweet'
    end
  end
  
  #操作や表示を行えるようにリソースメソッドを行う
  #作成と削除のみ可能。アップデートやエディットは使わない
  resources :relationships, only: [:create, :destroy]
  
  #操作や表示、followings,followers一覧のために新アクション追加
  resources :users do
    member do
      get 'followings'
      get 'followers'
    end
  end
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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