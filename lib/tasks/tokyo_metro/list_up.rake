namespace :tokyo_metro do
  namespace :list_up do

    namespace :connecting_railway_lines do
      desc "乗り換え可能路線の一覧 (API)"
      task :in_api => :load do
        puts ::TokyoMetro::Api::Station.get( ::HTTPClient.new , perse_json: true , generate_instance: true , to_inspect: true ).connecting_railway_lines
        # file = File.open( "connecting_railway_lines.txt" , "w:utf-8" )
        # file.print( connecting_railway_lines.join( "\n" ) )
        # file.close
      end
    end

    namespace :station_names do

      desc "駅名の一覧 (API)"
      task :in_api => :load do
        puts ::TokyoMetro::Api::Station.get( ::HTTPClient.new , perse_json: true , generate_instance: true , to_inspect: true ).basenames
      end

      desc "駅名の一覧（自然言語）"
      task :to_display => :load do
        puts ::TokyoMetro::Api::Station.get( ::HTTPClient.new , perse_json: true , generate_instance: true , to_inspect: true ).basenames_to_display
      end

    end

  end
end