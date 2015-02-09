namespace :tokyo_metro do
  namespace :test do
    namespace :get do

      desc "取得テスト - 列車運行情報"
      task :train_information => :load do
        ::TokyoMetro::Api::TrainInformation.get_test( ::HTTPClient.new )
      end

      desc "取得テスト - 列車ロケーション情報"
      task :train_location => :load do
        ::TokyoMetro::Api::TrainLocation.get_test( ::HTTPClient.new , "TokyoMetro.Ginza" )
      end

      namespace :station_timetable do
        desc "取得テスト - 駅時刻表 小竹向原（有楽町線）"
        task :kotake_m_y => :load do
          ::TokyoMetro::Api::StationTimetable.get( ::HTTPClient.new , station: "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara" , perse_json: true , generate_instance: true , to_inspect: true )
        end
        desc "取得テスト - 駅時刻表 和光市"
        task :wakoshi => :load do
          ::TokyoMetro::Api::StationTimetable.get_test( time_table_of_all_stations , "Wakoshi" , /Wakoshi/ )
        end
        desc "取得テスト - 駅時刻表 氷川台"
        task :hikawadai => :load do
          ::TokyoMetro::Api::StationTimetable.get_test( time_table_of_all_stations , "Hikawadai" , /Hikawadai/ )
        end
        desc "取得テスト - 駅時刻表 小竹向原（すべて）"
        task :kotake_m_all => :load do
          ::TokyoMetro::Api::StationTimetable.get_test( time_table_of_all_stations , "KotakeMukaihara" , /KotakeMukaihara/ )
        end
        desc "取得テスト - 駅時刻表 大手町"
        task :otemachi => :load do
          ::TokyoMetro::Api::StationTimetable.get_test( time_table_of_all_stations , "Otemachi" , /Otemachi/ )
        end
        desc "取得テスト - 駅時刻表 【補足情報】"
        task :notes => :load do
          ::TokyoMetro::Api::StationTimetable.inspect_notes
        end

      end

      namespace :station_facility do

        desc "取得テスト - 駅施設情報 【部分一致検索】"
        task :partial_match => :load do
          [ "Ginza", "Shinjuku" , "Roppongi" , "Ueno" , "Akasaka" , "Yotsuya" , "Nakano" ].each do | region |
            puts "● StationFacility:Test ... #{region}"
            puts "" * 2
            ::TokyoMetro::Api::StationFacility.get_test( ::HTTPClient.new , "TokyoMetro.#{region}" )
            puts "" * 2
          end
        end

        desc "取得テスト - 駅施設情報 新木場"
        task :shin_kiba => :load do
          ::TokyoMetro::Api::StationFacility.get_test( ::HTTPClient.new , "TokyoMetro.ShinKiba" )
        end

      end

      namespace :passenger_survey do

        desc "取得テスト - 駅乗降人員数"
        task :all => :load do
          ::TokyoMetro::Api::PassengerSurvey.get_test( ::HTTPClient.new )
        end

      end

      namespace :fare do
        desc "取得テスト - 運賃 浅草から"
        task :from_asakusa => :load do
          ::TokyoMetro::Api::Fare.get_test( ::HTTPClient.new , "odpt.Station:TokyoMetro.Ginza.Asakusa" )
        end

        desc "取得テスト - 普通運賃表"
        task :static => :load do
          ::TokyoMetro::Static::Fare::Normal.test
        end
      end
      
      namespace :station do
        desc "取得テスト - 駅情報 渋谷（銀座線）"
        task :ginza_line_shibuya => :load do
          ::TokyoMetro::Api::Station.get_test( ::HTTPClient.new , "TokyoMetro.Ginza.Shibuya" )
        end
      end

      namespace :railway_line do
        desc "取得テスト - 路線情報【全路線】"
        task :all => :load do
          ::TokyoMetro::Api::RailwayLine.get_test_for_each_line( ::HTTPClient.new )
        end

        desc "取得テスト - 駅の順序【全路線】"
        task :station_order => :load do
          ::TokyoMetro::Api::RailwayLine.get_station_order_for_each_line( ::HTTPClient.new )
        end
      end

      namespace :point do
        desc "取得テスト - 出入口情報 【すべて】"
        task :all => :load do
          ::TokyoMetro::Api::Point.get_test( ::HTTPClient.new )
        end
      end
      
      # 地理情報
      namespace :geo do
        desc "取得テスト - 駅情報（地理情報から）"
        task :station => :load do
          geo_infos = { long: 139.705678 , lat: 35.678156 , radius: 2000 }
          ::TokyoMetro::Api::Station.get_geo_test( ::HTTPClient.new , *( geo_infos.values ) )
        end
        desc "取得テスト - 路線情報（地理情報から）"
        task :railway_line => :load do
          geo_infos = { long: 139.705678 , lat: 35.678156 , radius: 2000 }
          ::TokyoMetro::Api::RailwayLine.get_geo_test( ::HTTPClient.new , *( geo_infos.values ) )
        end
        desc "取得テスト - 地物情報（地理情報から）"
        task :point => :load do
          geo_infos = { long: 139.705678 , lat: 35.678156 , radius: 2000 }
          ::TokyoMetro::Api::Point.get_geo_test( ::HTTPClient.new , *( geo_infos.values ) )
        end
        desc "取得テスト - 国土交通省国土数値情報-鉄道::路線"
        task :mlit_railway_line => :load do
          geo_infos = { long: 139.705678 , lat: 35.678156 , radius: 2000 }
          ::TokyoMetro::Api::MlitRailwayLine.get_geo_test( ::HTTPClient.new , *( geo_infos.values ) )
        end
        desc "取得テスト - 国土交通省国土数値情報-鉄道::駅"
        task :mlit_station => :load do
          geo_infos = { long: 139.705678 , lat: 35.678156 , radius: 2000 }
          ::TokyoMetro::Api::MlitStation.get_geo_test( ::HTTPClient.new , *( geo_infos.values ) )
        end
      end

    end
  end
end