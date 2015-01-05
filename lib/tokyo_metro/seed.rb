module TokyoMetro::Seed

  # @!group 各種設定

  class << self

    private

    def settings_of_seed
      h = Hash.new

      ::YAML.load_file( "#{ TokyoMetro::PRODUCTION_DIR }/db/seeds/settings.yaml" ).each do | key , value |
        h[ key.intern ] = value
      end

      check_validity(h)
      set_constants(h)
      h
    end

    def check_validity(h)
      if h[ :railway_lines ] and !( h[ :fundamental_static_datas ] )
        h[ :fundamental_static_datas ] = true
      end

      if h[ :train_types ] and !( h[ :railway_lines ] )
        h[ :railway_lines ] = true
      end

      if h[ :stations ] and !( h[ :station_facilities ] and h[ :railway_lines ] )
        h[ :station_facilities ] = true
        h[ :railway_lines ] = true
      end

      if h[ :static_datas_of_railway_directions ] and !( h[ :railway_lines ] and h[ :stations ] )
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

      if h[ :timetables ] and !( h[ :fundamental_static_datas ] and h[ :train_types ] and h[ :stations ] and h[ :static_datas_of_railway_directions ] )
        h[ :fundamental_static_datas ] = true
        h[ :train_types ] = true
        h[ :stations ] = true
        h[ :static_datas_of_railway_directions ] = true
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
      ::TokyoMetro.set_constants( config_of_api_constants )
    end

  end

  # @!group 具体的な処理

  class << self

    def process
      h = settings_of_seed

      time_begin = Time.now
      inspect_time_begin( time_begin )

      #-------- TokyoMetro::StaticDatas.operators
      #-------- TokyoMetro::StaticDatas.train_owners
      #-------- TokyoMetro::StaticDatas.Fare::Normal.seed
      process_fundamental_static_datas(h)

      #-------- train_information_status.yaml
      process_train_information_status(h)

      #-------- TokyoMetro::StaticDatas.railway_lines
      # TokyoMetro::Api.railway_lines の情報も同時に取り込む
      process_static_datas_of_railway_lines(h)

      #-------- TokyoMetro::Api.station_facilities (1)
      process_station_facilities(h)

      #-------- TokyoMetro::Api.stations
      # TokyoMetro::Api.stations の情報も同時に取り込む
      process_stations(h)

      #-------- TokyoMetro::StaticDatas.railway_directions
      process_static_datas_of_railway_directions(h)

      #-------- TokyoMetro::StaticDatas.train_types
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

    private

    def inspect_time_begin( t )
      puts "☆ Begin: #{t.to_s}"
      puts ""
    end

    def inspect_time_end( time_begin )
      time_end = Time.now
      puts "☆ End: #{time_end.to_s}"
      puts "※ #{time_end - time_begin} sec"
      puts ""
    end

    def process_each_content( h , key , procedure )
      raise "Error" unless h.keys.include?( key )
      if h[ key ]
        procedure.call
      end
    end

    #-------- TokyoMetro::StaticDatas.operators
    #-------- TokyoMetro::StaticDatas.train_owners
    #-------- TokyoMetro::StaticDatas.Fare::Normal.seed

    def process_fundamental_static_datas(h)

      process_each_content( h , :fundamental_static_datas ,
        Proc.new {
          ::TokyoMetro::StaticDatas.operators.seed
          ::TokyoMetro::StaticDatas.train_owners.seed
          ::TokyoMetro::StaticDatas::Fare::Normal.seed
          # puts "=" * 64 + "Finish: #{__method__}"
          # puts ""
        }
      )
    end

    #-------- train_information_status.yaml

    def process_train_information_status(h)
      process_each_content( h , :train_information_status ,
        Proc.new {
          ::YAML.load_file( "#{ TokyoMetro::dictionary_dir }/train_information/status.yaml" ).each do | information_status |
            ::TrainInformationStatus.create( in_api: information_status[ "in_api" ] , name_ja: information_status[ "name_ja" ] )
          end
        }
      )
    end

    #-------- TokyoMetro::StaticDatas.railway_lines
    # TokyoMetro::Api.railway_lines の情報も同時に取り込む

    def process_static_datas_of_railway_lines(h)
      process_each_content( h , :railway_lines ,
        Proc.new {
          # puts "=" * 64 + "Begin: #{__method__}"
          # puts ""
          # puts ::TokyoMetro::StaticDatas.railway_lines
          # puts ""
          ::TokyoMetro::StaticDatas.railway_lines.seed
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
    # TokyoMetro::Api.stations の情報も同時に取り込む

    def process_stations(h)
      process_each_content( h , :stations ,
        Proc.new {
          ::TokyoMetro::Api.stations.seed
          ::TokyoMetro::StaticDatas.stations.seed
          ::TokyoMetro::Api.stations.seed_optional_infos_of_connecting_railway_lines
        }
      )
    end

    #-------- TokyoMetro::StaticDatas.railway_directions

    def process_static_datas_of_railway_directions(h)
      process_each_content( h , :static_datas_of_railway_directions ,
        Proc.new {
          ::TokyoMetro::StaticDatas.railway_directions.seed
        }
      )
    end

    #-------- TokyoMetro::StaticDatas.train_types

    def process_train_types(h)
      process_each_content( h , :train_types ,
        Proc.new {
          ::TokyoMetro::StaticDatas.train_types_in_api.seed
          ::TokyoMetro::StaticDatas.train_types.seed
        }
      )
    end

    #-------- TokyoMetro::Api.points

    def process_points(h)
      process_each_content( h , :points ,
        Proc.new {
          ::TokyoMetro::Api.points.seed
          ::TokyoMetro::Api.stations.seed_exit_list
        }
      )
    end

    #-------- TokyoMetro::Api.railway_lines

    def process_sub_info_of_railway_lines(h)
      process_each_content( h , :sub_info_of_railway_lines ,
        Proc.new {
          # ::TokyoMetro::Api.railway_lines.seed_index_of_stations
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
          ::TokyoMetro::Api.stations.seed_station_passenger_survey
        }
      )
    end

    #-------- TokyoMetro::Api.station_facilities (2)

    def process_barrier_free_infos_of_station_facilities(h)
      process_each_content( h , :barrier_free_infos_of_station_facilities ,
        Proc.new {
          ::TokyoMetro::Api.station_facilities.seed_barrier_free_facility_infos
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

  end

end

# seed/operation_day_processer.rb
# seed/train_type_scss.rb
# seed/inspection.rb