namespace :tokyo_metro do
  namespace :test do
    namespace :save do

      namespace :station_timetable do
        desc "保存テスト - 駅時刻表 【すべて】"
        task :all => :load do
          ::TokyoMetro::Api::StationTimetable.save( ::HTTPClient.new , "timetables_of_all_stations" , file_type: :json )
        end
      end

      namespace :railway_line do
        desc "保存テスト - 路線情報【すべて】"
        task :all => :load do
          ::TokyoMetro::Api::RailwayLine.save( ::HTTPClient.new , "info_of_all_railway_lines" , file_type: :json )
        end
      end

    end
  end
end