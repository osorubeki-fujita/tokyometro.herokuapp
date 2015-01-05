namespace :tokyo_metro do
  namespace :get_and_save_datas_from_api do

    desc "API のデータを取得・保存 - require \'fileutils\'"
    task :require_fileutils => :load do
      require 'fileutils'
    end
    
    desc "API のデータを取得・保存 - 駅時刻表"
    task :station_timetable => :require_fileutils do
      ::TokyoMetro::Api::StationTimetable.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end
    
    desc "API のデータを取得・保存 - 列車時刻表"
    task :train_timetable => :require_fileutils do
      ::TokyoMetro::Api::TrainTimetable.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 駅施設情報"
    task :station_facility => :require_fileutils do
      ::TokyoMetro::Api::StationFacility.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 駅乗降人員数"
    task :passenger_survey => :require_fileutils do
      ::TokyoMetro::Api::PassengerSurvey.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 運賃"
    task :fare => :require_fileutils do
      ::TokyoMetro::Api::Fare.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 駅情報"
    task :station => :require_fileutils do
      ::TokyoMetro::Api::Station.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 出入口情報"
    task :point => :require_fileutils do
      ::TokyoMetro::Api::Point.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 路線情報"
    task :railway_line => :require_fileutils do
      ::TokyoMetro::Api::RailwayLine.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 列車運行情報"
    task :train_information => :require_fileutils do
      ::TokyoMetro::Api::TrainInformation.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API のデータを取得・保存 - 列車ロケーション情報"
    task :train_location => :require_fileutils do
      ::TokyoMetro::Api::TrainLocation.save_datas_of_each_group( ::HTTPClient.new , file_type: :json )
    end

    desc "API からデータを取得し保存 - すべて"
    task :all => :require_fileutils do
      http_client = ::HTTPClient.new
      namespaces = %W( StationTimetable TrainTimetable StationFacility PassengerSurvey Fare Station Point RailwayLine TrainInformation TrainLocation )
      namespaces.each.with_index(1) do | namespace , i |
        eval <<-EVAL
          ::TokyoMetro::Api::#{ namespace }.save_datas_of_each_group( http_client , file_type: :json )
        EVAL
        unless i == namespaces.length
          sleep(1)
        end
      end
    end
  
  end
end