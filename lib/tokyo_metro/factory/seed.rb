module TokyoMetro::Factory::Seed

  extend ::OdptCommon::CalcTime

  # @!group 各種設定

  # @!group 具体的な処理

  def self.process
    h = settings_of_seed

    time_begin = ::Time.now
    inspect_time_begin( time_begin )

    #-------- TokyoMetro::Static.operators
    #-------- TokyoMetro::Static.train_owners
    #-------- TokyoMetro::Static.Fare::Normal.seed
    process_fundamental_static(h)

    #-------- TokyoMetro::Static.railway_lines
    # TokyoMetro::Api.railway_lines の情報も同時に取り込む
    process_static_of_railway_lines(h)

    #-------- TokyoMetro::Api.station_facilities (1)
    process_station_facilities(h)

    #-------- TokyoMetro::Api.stations
    # TokyoMetro::Api.stations の情報も同時に取り込む
    process_stations(h)

    #-------- TokyoMetro::Static.railway_directions
    process_static_railway_directions(h)

    #-------- TokyoMetro::Static.train_types
    process_train_types(h)

    #-------- TokyoMetro::Api.points
    process_points(h)

    #-------- TokyoMetro::Api.railway_lines
    process_sub_info_of_railway_lines(h)

    #-------- TokyoMetro::Api.passenger_surveys
    process_passenger_surveys(h)

    #-------- TokyoMetro::Api.station_facilities (2)
    process_barrier_free_infos_of_station_facilities(h)

    #-------- TokyoMetro::Api.station_facilities (3)
    process_platform_infos_of_station_facilities(h)

    #-------- TokyoMetro::Api.fares
    process_fares(h)

    #-------- TokyoMetro::Api.station_timetables
    #-------- TokyoMetro::Api.train_timetables
    process_timetables(h)

    inspect_time_end( time_begin )
  end

  def self.destroy_all_items( *db_names )
    if db_names.all? { | db_name | db_name.instance_of?( ::String ) or db_name.instance_of?( ::Symbol ) }
      db_names = db_names.map( &:to_s )
      unless db_names.all? { | db_name | /\A[a-z_]+s/ === db_name }
        raise "Error: #{ db_name.to_s } is not valid."
      end
      db_names = db_names.map { | db_name | eval( "::#{db_name.singularize.camelize}" ) }
    end

    db_names.each do | db_name |
      puts "* Destory all items in \'#{ db_name }\'."
      db_name.all.each do | item |
        item.destroy
      end
    end
    return nil
  end

  def self.destroy_all_items_related_to_stations
    destroy_all_items_of(
      ::Station::Info ,
      ::ConnectingRailwayLine
    )
  end

  def self.destroy_all_items_related_to_barrier_free_facilities
    destroy_all_items_of(
      ::BarrierFreeFacility::Info ,
      ::BarrierFreeFacilityServiceDetail ,
      ::BarrierFreeFacilityServiceDetailPattern ,
      ::BarrierFreeFacilityEscalatorDirection ,
      ::BarrierFreeFacilityToiletAssistant ,
      ::BarrierFreeFacilityToiletAssistantPattern
    )
  end

  def self.destroy_all_items_related_to_platform_infos
    destroy_all_items_of(
      ::StationFacilityPlatformInfo ,
      ::StationFacilityPlatformInfoTransferInfo ,
      ::StationFacilityPlatformInfoSurroundingArea ,
      ::StationFacilityPlatformInfoBarrierFreeFacility
    )
  end

  def self.destroy_all_items_related_to_station_timetables
    destroy_all_items_of(
      ::StationTimetable ,
      ::StationTimetableFundamentalInfo
    )
  end

  class << self

    alias :destroy_all_items_of :destroy_all_items

    private

    def settings_of_seed
      h = ::Hash.new

      ::YAML.load_file( "#{ TokyoMetro::PRODUCTION_DIR }/db/seeds/settings.yaml" ).each do | key , value |
        h[ key.intern ] = value
      end

      check_validity(h)
      set_constants(h)
      h
    end

    def check_validity(h)
      if h[ :railway_lines ] and !( h[ :fundamental_static ] )
        h[ :fundamental_static ] = true
      end

      if h[ :train_types ] and !( h[ :railway_lines ] )
        h[ :railway_lines ] = true
      end

      if h[ :stations ] and !( h[ :station_facilities ] and h[ :railway_lines ] )
        h[ :station_facilities ] = true
        h[ :railway_lines ] = true
      end

      if h[ :static_railway_directions ] and !( h[ :railway_lines ] and h[ :stations ] )
        h[ :railway_lines ] = true
        h[ :stations ] = true
      end

      if h[ :points ] and !( h[ :stations ] )
        h[ :stations ] = true
      end

      if h[ :sub_info_of_railway_lines ] and !( h[ :railway_lines ] )
        h[ :railway_lines ] = true
      end

      if h[ :passenger_surveys ] and !( h[ :stations ] )
        h[ :stations ] = true
      end

      if h[ :barrier_free_infos_of_station_facilities ] and !( h[ :station_facilities ] )
        h[ :station_facilities ] = true
      end

      if h[ :platform_infos_of_station_facilities ] and !( h[ :station_facilities ] )
        h[ :station_facilities ] = true
      end

      if h[ :fares ] and !( h[ :stations ] )
        h[ :stations ] = true
      end

      if h[ :timetables ] and !( h[ :fundamental_static ] and h[ :train_types ] and h[ :stations ] and h[ :static_railway_directions ] )
        h[ :fundamental_static ] = true
        h[ :train_types ] = true
        h[ :stations ] = true
        h[ :static_railway_directions ] = true
      end
    end

    def set_constants(h)
      config_of_api_constants = ::Hash.new
      [ :railway_lines , :station_facilities , :passenger_surveys , :stations , :fares , :points ].each do | setting |
        if h[ setting ]
          config_of_api_constants[ setting.singularize ] = true
        end
      end
      if h[ :timetables ]
        config_of_api_constants[ :station_timetable ] = true
        config_of_api_constants[ :train_timetable ] = true
      end
      ::TokyoMetro.set_api_constants( config_of_api_constants )
    end

    def inspect_time_begin( t )
      puts "☆ Begin: #{t.to_s}"
      puts ""
    end

    def inspect_time_end( time_begin )
      time_end = ::Time.now
      t = calc_time( time_begin , time_end )
      puts "☆ End: #{time_end.to_s}"
      puts "※ #{t} sec"
      puts ""
    end

    def process_each_content( h , key , procedure )
      raise "Error" unless h.keys.include?( key )
      if h[ key ]
        procedure.call
      end
    end

    #-------- TokyoMetro::Static.operators
    #-------- TokyoMetro::Static.train_owners
    #-------- TokyoMetro::Static.Fare::Normal.seed
    #-------- TokyoMetro::Static::OperationDay

    def process_fundamental_static(h)

      process_each_content( h , :fundamental_static ,
        Proc.new {
          ::TokyoMetro::Static.operators.seed
          ::TokyoMetro::Static.train_owners.seed
          ::TokyoMetro::Static::Fare::Normal.seed
          ::TokyoMetro::Static.operation_days.seed
          ::TokyoMetro::Static.train_information_statuses.seed
        }
      )
    end

    #-------- TokyoMetro::Static.railway_lines
    # TokyoMetro::Api.railway_lines の情報も同時に取り込む

    def process_static_of_railway_lines(h)
      process_each_content( h , :railway_lines ,
        Proc.new {
          ::TokyoMetro::Static.railway_lines.seed
        }
      )
    end

    #-------- TokyoMetro::Api.station_facilities (1)

    def process_station_facilities(h)
      process_each_content( h , :station_facilities ,
        Proc.new {
          ::TokyoMetro::Api.station_facilities.seed
        }
      )
    end

    #-------- TokyoMetro::Api.stations

    def process_stations(h)
      process_each_content( h , :stations ,
        Proc.new {
          ::TokyoMetro::Api.stations.seed
          ::TokyoMetro::Static.stations.seed
          ::TokyoMetro::Api.stations.seed_connecting_railway_lines
        }
      )
    end

    #-------- TokyoMetro::Static.railway_directions

    def process_static_railway_directions(h)
      process_each_content( h , :static_railway_directions ,
        Proc.new {
          ::TokyoMetro::Static.railway_directions.seed
        }
      )
    end

    #-------- TokyoMetro::Static.train_types

    def process_train_types(h)
      process_each_content( h , :train_types ,
        Proc.new {
          ::TokyoMetro::Static.train_types_in_api.seed
          ::TokyoMetro::Static.train_types.seed
        }
      )
    end

    #-------- TokyoMetro::Api.points

    def process_points(h)
      process_each_content( h , :points ,
        Proc.new {
          ::TokyoMetro::Api.points.seed
          ::TokyoMetro::Api.stations.seed_exits
        }
      )
    end

    #-------- TokyoMetro::Api.railway_lines （補足情報）

    def process_sub_info_of_railway_lines(h)
      process_each_content( h , :sub_info_of_railway_lines ,
        Proc.new {
          # ::TokyoMetro::Api.railway_lines.seed_station_order_infos （使用停止中）
          ::TokyoMetro::Api.railway_lines.seed_travel_time_infos
          ::TokyoMetro::Api.railway_lines.seed_women_only_car_infos
        }
      )
    end

    #-------- TokyoMetro::Api.passenger_surveys

    def process_passenger_surveys(h)
      process_each_content( h , :passenger_surveys ,
        Proc.new {
          ::TokyoMetro::Api.passenger_surveys.seed
          ::TokyoMetro::Api.stations.seed_link_to_passenger_surveys
        }
      )
    end

    #-------- TokyoMetro::Api.station_facilities (2)

    def process_barrier_free_infos_of_station_facilities(h)
      process_each_content( h , :barrier_free_infos_of_station_facilities ,
        Proc.new {
          ::TokyoMetro::Api.station_facilities.seed_barrier_free_facilities
        }
      )
    end

    #-------- TokyoMetro::Api.station_facilities (3)

    def process_platform_infos_of_station_facilities(h)
      process_each_content( h , :platform_infos_of_station_facilities ,
        Proc.new {
          ::TokyoMetro::Api.station_facilities.seed_platform_infos
        }
      )
    end

    #-------- TokyoMetro::Api.fares

    def process_fares(h)
      process_each_content( h , :fares ,
        Proc.new {
          ::TokyoMetro::Api.fares.seed
        }
      )
    end

    #-------- TokyoMetro::Api.station_timetables
    #-------- TokyoMetro::Api.train_timetables

    def process_timetables(h)
      process_each_content( h , :timetables ,
        Proc.new {
          ::TokyoMetro::Api.station_timetables.seed
          ::TokyoMetro::Api.train_timetables.seed
          # ::TokyoMetro::Api::StationTrainTime.seed
        }
      )
    end

  end

end