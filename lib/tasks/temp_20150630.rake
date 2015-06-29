# coding: utf-8

namespace :temp do
  task :bug_check_of_station_timetable_context_20150630 => :environment do
    require 'httpclient'
    require 'json'
    require 'active_support'
    require 'active_support/core_ext'
    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV['ACCESS_TOKEN']
    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:StationTimetable" , "acl:consumerKey"=> ACCESS_TOKEN } )

    items_with_invalid_context = JSON.parse( response.body ).select { | item |
      item[ "@context" ] != "http://vocab.tokyometroapp.jp/context_odpt_StationTimetable.jsonld"
    }.sort_by { | item |
      item[ "owl:sameAs" ]
    }.group_by { | item |
      item[ "@context" ]
    }

    output_str_ary = ::Array.new
    items_with_invalid_context.each do | context , items |
      output_str_ary << "* #{ context }" + "\n"
      items.each do | item |
        output_str_ary << item[ "owl:sameAs" ]
      end
      output_str_ary << "\n"
    end

    ::File.open( "#{ ::Rails.root }/invalid_station_timetable_context.txt" , "w:utf-8" ) do |f|
      f.print output_str_ary.join( "\n" )
    end

  end

  task :bug_check_of_operation_day_20150630_1 => :environment do
    require 'httpclient'
    require 'json'
    require 'active_support'
    require 'active_support/core_ext'
    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV['ACCESS_TOKEN']
    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:StationFacility" , "owl:sameAs" => "odpt.StationFacility:TokyoMetro.Ginza" , "acl:consumerKey"=> ACCESS_TOKEN } )
    station_facility_at_ginza = JSON.parse( response.body ).first
    puts station_facility_at_ginza[ "odpt:barrierfreeFacility" ].find { | item | item[ "owl:sameAs" ] == "odpt.StationFacility:TokyoMetro.Hibiya.Ginza.Outside.Elevator.2" }.to_s
  end

  task :bug_check_of_operation_day_20150630_2 => :environment do
    require 'httpclient'
    require 'json'
    require 'active_support'
    require 'active_support/core_ext'
    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV['ACCESS_TOKEN']
    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:StationFacility" , "acl:consumerKey"=> ACCESS_TOKEN } )
    station_facilities = JSON.parse( response.body )

    station_facility_names_and_barrier_free_facilities = ::Hash.new
    station_facilities.each do | item |
      station_facility_names_and_barrier_free_facilities[ item[ "owl:sameAs" ] ] = item[ "odpt:barrierfreeFacility" ]
    end

    # puts station_facility_names_and_barrier_free_facilities.to_s

    barrier_free_facilities = station_facility_names_and_barrier_free_facilities.values.flatten
    service_details = barrier_free_facilities.map { | item | item[ "odpt:serviceDetail" ] }.select( &:present? ).flatten
    operation_days = service_details.map { | item | item[ "odpt:operationDays" ] }.select( &:present? ).flatten.sort

    # puts barrier_free_facilities.to_s
    # puts service_details.to_s
    # puts operation_days.to_s

    count_of_operation_days = ::Hash.new
    operation_days.uniq.each do | operation_day |
      count_of_operation_days[ operation_day ] = operation_days.count { | item | item == operation_day }
    end
    puts count_of_operation_days.to_s

    barrier_free_facilities_on_saturday_sunday_holiday = barrier_free_facilities.select { | item |
      item[ "odpt:serviceDetail" ].present? and item[ "odpt:serviceDetail" ].any? { | service_detail | service_detail[ "odpt:operationDays" ].present? and service_detail[ "odpt:operationDays" ] == "土日祝" }
    }
    puts barrier_free_facilities_on_saturday_sunday_holiday.to_s
  end

  task :bug_check_of_operation_day_20150630_3 => :environment do
    require 'httpclient'
    require 'json'
    require 'active_support'
    require 'active_support/core_ext'
    Encoding.default_external = "utf-8"

    ACCESS_TOKEN = ENV['ACCESS_TOKEN']
    response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:StationFacility" , "owl:sameAs" => "odpt.StationFacility:TokyoMetro.AkasakaMitsuke" , "acl:consumerKey"=> ACCESS_TOKEN } )
    station_facility_at_akasaka_mitsuke = JSON.parse( response.body ).first
    puts station_facility_at_akasaka_mitsuke[ "odpt:barrierfreeFacility" ].find { | item | item[ "owl:sameAs" ] == "odpt.StationFacility:TokyoMetro.Ginza.AkasakaMitsuke.Outside.Escalator.1" }.to_s
    puts station_facility_at_akasaka_mitsuke[ "odpt:barrierfreeFacility" ].find { | item | item[ "owl:sameAs" ] == "odpt.StationFacility:TokyoMetro.Marunouchi.AkasakaMitsuke.Outside.Escalator.1" }.to_s
  end
end
