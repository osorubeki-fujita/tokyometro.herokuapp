# coding: utf-8

def station_facility( station_name )
  response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:StationFacility" , "owl:sameAs" => "odpt.StationFacility:TokyoMetro.#{ station_name }" , "acl:consumerKey"=> ACCESS_TOKEN } )
  JSON.parse(response.body).first
end

def search_barrier_free_facility( station_name , *b_names )
  s_facility = station_facility( station_name )
  raise unless s_facility.present?
  b_infos = s_facility[ "odpt:barrierfreeFacility" ]
  b_infos.select { | b_info | b_names.include?( b_info[ "owl:sameAs" ] ) }
end

def inspect_service_detail( station_name , *b_names )
  facilities = search_barrier_free_facility( station_name , *b_names )
  facilities.each do | facility |
    puts facility[ "owl:sameAs" ]
    puts facility[ "odpt:serviceDetail" ]
    puts ""
  end
end

namespace :temp do
  task :bug_check_of_barrier_free_facility_20150622 => :environment do
    require 'httpclient'
    require 'json'
    require 'active_support'
    require 'active_support/core_ext'
    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV['ACCESS_TOKEN']

    puts "● 霞ケ関"
    inspect_service_detail( "Kasumigaseki" , "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.4" , "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.5" )

    puts "● 赤坂見附"
    inspect_service_detail( "AkasakaMitsuke" , "odpt.StationFacility:TokyoMetro.Ginza.AkasakaMitsuke.Outside.Escalator.1" )

    # ARGV.slice( 1 , ARGV.size ).each{ |v|
      # task v.to_sym do
      # end
    # }
  end
end
