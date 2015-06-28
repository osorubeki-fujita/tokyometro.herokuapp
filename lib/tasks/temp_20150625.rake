namespace :temp do
  task :train_location_infos_on_hanzomon_line_20150625 do
    require 'httpclient'
    require 'json'

    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = open( "#{ ::File.dirname( __FILE__ ) }/../../AccessToken" , "r:utf-8" ).read.chomp

    puts Time.now.to_s

    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:TrainInformation" , "odpt:railway" => "odpt.Railway:TokyoMetro.Hanzomon" , "acl:consumerKey"=> ACCESS_TOKEN } )
    puts JSON.parse(response.body).to_s

    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:Train" , "odpt:railway" => "odpt.Railway:TokyoMetro.Hanzomon" , "acl:consumerKey"=> ACCESS_TOKEN } )
    puts JSON.parse(response.body).to_s
  end
end
