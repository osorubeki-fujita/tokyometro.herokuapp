namespace :tokyo_metro do
  namespace :test do
    namespace :check do

      desc "確認 - Static datas"
      task :static do
        system( "rspec -c test\\tokyo_metro\\static_spec.rb" )
      end

      desc "確認 - 路線情報"
      task :railway_line do
        system( "rspec -c test\\tokyo_metro\\railway_line_spec.rb" )
      end

      desc "確認 - 駅情報"
      task :station do
        system( "rspec -c test\\tokyo_metro\\station_spec.rb" )
      end
      
      desc "確認 - 駅施設情報"
      task :station_facility do
        system( "rspec -c test\\tokyo_metro\\station_facility_spec.rb" )
      end

      desc "確認 - 運賃"
      task :fare do
        system( "rspec -c test\\tokyo_metro\\fare_spec.rb" )
      end

      desc "確認 - 駅時刻表・列車時刻表"
      task :timetable do
        system( "rspec -c test\\tokyo_metro\\timetable_spec.rb" )
      end

    end
  end
end