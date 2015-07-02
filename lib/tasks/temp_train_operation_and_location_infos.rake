def train_operation_and_location_infos( railway_line , access_token )
    puts Time.now.to_s

    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:TrainInformation" , "odpt:railway" => "odpt.Railway:TokyoMetro.#{ railway_line }" , "acl:consumerKey"=> access_token } )
    puts JSON.parse( response.body ).to_s

    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:Train" , "odpt:railway" => "odpt.Railway:TokyoMetro.#{ railway_line }" , "acl:consumerKey"=> access_token } )
    puts JSON.parse( response.body ).to_s
end

def romance_car( access_token )
    puts Time.now.to_s

    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:Train" , "odpt:railway" => "odpt.Railway:TokyoMetro.Chiyoda" , "acl:consumerKey"=> access_token } )
    ary = JSON.parse( response.body )
    if ary.present?
      romance_cars = ary.select { | item | [ "odpt.TrainType:TokyoMetro.LimitedExpress" , "odpt.TrainType:TokyoMetro.RomanceCar" ].include?( item[ "odpt:trainType" ] ) }
      puts romance_cars.to_s
    end
end

namespace :temp do
  desc "TrainLocation infos on Hanzomon Line"
  task :train_location_infos_on_hanzomon_line_20150625 do
    require 'httpclient'
    require 'json'

    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV[ 'ACCESS_TOKEN' ]
    train_operation_and_location_infos( "Hanzomon" , ACCESS_TOKEN )
  end

  desc "TrainLocation infos on Hbiya Line"
  task :train_location_infos_on_hibiya_line_20150630 do
    require 'httpclient'
    require 'json'

    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV[ 'ACCESS_TOKEN' ]
    train_operation_and_location_infos( "Hibiya" , ACCESS_TOKEN )
  end

  desc "TrainLocation infos of Romance Car on Chiyoda Line"
  task :train_location_infos_of_romance_car do
    require 'httpclient'
    require 'json'

    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV[ 'ACCESS_TOKEN' ]
    romance_car( ACCESS_TOKEN )
  end

  desc "TrainLocation infos on Chiyoda Line"
  task :train_location_infos_on_chiyoda_line_20150701 do
    require 'httpclient'
    require 'json'

    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV[ 'ACCESS_TOKEN' ]
    train_operation_and_location_infos( "Chiyoda" , ACCESS_TOKEN )
  end
end
