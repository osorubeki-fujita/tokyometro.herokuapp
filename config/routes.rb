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

  #-------- 列車運行情報

  get 'train_operation(/index)' ,
    to: 'train_operation#index'

  get 'train_operation/:railway_line' ,
    # constraints: OnlyRailwayLineRequestConstraint.new ,
    constraints: { railway_line: /[a-z]+_line/ } ,
    to: 'train_operation#action_for_railway_line_page'

  get 'train_operation/:station' ,
    to: 'train_operation#action_for_station_page'

  #-------- 列車位置情報

  get 'train_location(/index)' ,
    to: 'train_location#index'

  get 'train_location/:railway_line' ,
    constraints: { railway_line: /(?:[a-z]+|yurakucho_and_fukutoshin)_line/ } ,
    to: 'train_location#action_for_railway_line_page'
    # constraints: OnlyRailwayLineRequestIncludingYurakuchoAndFukutoshinLineConstraint.new

  #-------- 路線情報

  get 'railway_line(/index)' ,
    to: 'railway_line#index'

  get 'railway_line/:railway_line' ,
    constraints: { railway_line: /(?:[a-z]+|yurakucho_and_fukutoshin)_line/ } ,
    to: 'railway_line#action_for_railway_line_page'
    # constraints: OnlyRailwayLineRequestIncludingYurakuchoAndFukutoshinLineConstraint.new

  # -------- 駅施設

  get 'station_facility(/index)' ,
    to: 'station_facility#index'

  get 'station_facility/:station' ,
    to: 'station_facility#action_for_station_page'

  # -------- 運賃

  get 'fare(/index)' ,
    to: 'fare#index'

  get 'fare/:station/marunouchi_branch_line' => redirect( '/fare/%{station}/marunouchi_line' )
  get 'fare/:station/chiyoda_branch_line' => redirect( '/fare/%{station}/chiyoda_line' )

  get 'fare(/:station(/:railway_line))' ,
    to: 'fare#action_for_station_page'

  # -------- 駅の時刻表

  get 'station_timetable(/index)' ,
    to: 'station_timetable#index'

  get 'station_timetable(/:railway_line)' ,
    constraints: { railway_line: /(?:[a-z]+|yurakucho_and_fukutoshin)_line/ } ,
    to: 'station_timetable#action_for_railway_line_page'

  get 'station_timetable(/:station(/:railway_line))' ,
    to: 'station_timetable#action_for_station_page'

  # -------- 乗降客数

  get 'passenger_survey(/index)' ,
    to: 'passenger_survey#index'

  get 'passenger_survey/:railway_line(/:survey_year)' ,
    constraints: { railway_line: /(?:all|[a-z]+_line)/ , survey_year: /\d{4}/ } ,
    to: 'passenger_survey#action_for_railway_line_or_year_page'

  get 'passenger_survey/:survey_year' => redirect( '/passenger_survey/all/%{survey_year}' ) ,
    constraints: { survey_year: /\d{4}/ }

  get 'passenger_survey/:station' ,
    to: 'passenger_survey#action_for_station_page'

  #-------- Document

  get 'document(/index)' ,
    to: 'document#index'

  get 'document/:action' ,
    controller: :document ,
    constraints: { action: /(?:operators|train_owners|railway_lines|railway_directions|train_types)/ }

  get 'document/table/:model_namespace_in_url.csv' ,
    to: 'document#csv_table'

  get 'document/table/:model_namespace_in_url(/:page)' ,
    to: 'document#table'

  #-------- Update
  post 'update/real_time_infos' , to: 'update#real_time_infos'

  #-------- その他

  get ':controller/:action' , constraints: { action: /(?:all|[a-z]+_line|index)/ }

  # match ':controller/:action', via: [ :get , :post , :patch ]

  get '/index' , to: 'application#index'
  root to: 'application#index'
end
