Rails.application.routes.draw do
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

  # resources :others, controller: :application

  # -------- 運賃

  get 'fare(/index)' , to: 'fare#index' , via: [ :get , :post , :patch ]
  get 'fare/:station/marunouchi_branch_line' => redirect( '/fare/%{station}/marunouchi_line' )
  get 'fare/:station/chiyoda_branch_line' => redirect( '/fare/%{station}/chiyoda_line' )

  match 'fare(/:station(/:railway_line))' , to: 'fare#action_for_station_page' , via: [ :get , :post , :patch ]

  # -------- 駅時刻表

  get 'station_timetable(/index)' , to: 'station_timetable#index'

  match 'station_timetable(/:station(/:railway_line))' , to: 'station_timetable#action_for_station_page' , via: [ :get , :post , :patch ]

  #-------- その他

  match ':controller/:action', via: [ :get , :post , :patch ]
  root to: 'application#index'
end
