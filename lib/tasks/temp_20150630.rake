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
  
  task :update_train_type_20150630 => :environment do
    [
      { name_ja: "各停" , name_ja_normal: "各停" , name_en: "Local" , name_en_normal: "Local" , same_as: "odpt.TrainType:Toei.Local" } ,
      { name_ja: "急行" , name_ja_normal: "急行" , name_en: "Express" , name_en_normal: "Express" , same_as: "odpt.TrainType:Toei.Express" }
    ].each do |h|
      id_new = ::TrainTypeInApi.all.pluck( :id ).max + 1
      ::TrainTypeInApi.create( h.merge( id: id_new ) )
    end
    ::TrainType.find_by( same_as: "custom.TrainType:Toei.Mita.Local.Normal" ).update( train_type_in_api_id: ::TrainTypeInApi.find_by( same_as: "odpt.TrainType:Toei.Local" ).id )
    ::TrainType.find_by( same_as: "custom.TrainType:Toei.Mita.Local.ToTokyu" ).update( train_type_in_api_id: ::TrainTypeInApi.find_by( same_as: "odpt.TrainType:Toei.Local" ).id )
    ::TrainType.find_by( same_as: "custom.TrainType:Toei.Mita.Express.ToTokyu" ).update( train_type_in_api_id: ::TrainTypeInApi.find_by( same_as: "odpt.TrainType:Toei.Express" ).id )
  end
  
end

__END__

rake temp:bug_check_of_operation_day_20150630_1

{
  "@id"=>"urn:ucode:_00001C000000000000010000030D4E01",
  "@type"=>"ug:Elevator",
  "owl:sameAs"=>"odpt.StationFacility:TokyoMetro.Hibiya.Ginza.Outside.Elevator.2",
  "ugsrv:categoryName"=>"エレベーター",
  "odpt:serviceDetail"=>[
    {"odpt:operationDays"=>"月曜", "ugsrv:serviceStartTime"=>"7:00", "ugsrv:serviceEndTime"=>"23:00"},
    {"odpt:operationDays"=>"火曜,水曜,木曜,金曜", "ugsrv:serviceStartTime"=>"6:00", "ugsrv:serviceEndTime"=>"23:00"},
    {"odpt:operationDays"=>"土曜", "ugsrv:serviceStartTime"=>"6:00", "ugsrv:serviceEndTime"=>"22:00"},
    {"odpt:operationDays"=>"日曜", "ugsrv:serviceStartTime"=>"8:00", "ugsrv:serviceEndTime"=>"21:00"}
  ],
  "odpt:placeName"=>"中央改札～B８番出入口",
  "odpt:locatedAreaName"=>"改札外"
}



#--------

rake temp:bug_check_of_operation_day_20150630_2

{"土休日"=>20, "土日祝"=>2, "土曜"=>2, "平日"=>55, "日曜"=>1, "月曜"=>1, "火曜,水曜,木曜,金曜"=>1}
[
  {
    "@id"=>"urn:ucode:_00001C000000000000010000030D4DC6",
    "@type"=>"ug:Escalator",
    "owl:sameAs"=>"odpt.StationFacility:TokyoMetro.Marunouchi.AkasakaMitsuke.Outside.Escalator.1",
    "ugsrv:categoryName"=>"エスカレーター",
    "odpt:serviceDetail"=>[
      {"odpt:operationDays"=>"土日祝", "ug:direction"=>"上り・下り"},
      {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"始発", "ugsrv:serviceEndTime"=>"7:30", "ug:direction"=>"上り・下り"},
      {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"7:30", "ugsrv:serviceEndTime"=>"10:00", "ug:direction"=>"上り"},
      {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"10:00", "ugsrv:serviceEndTime"=>"終車時", "ug:direction"=>"上り・下り"}
    ],
    "odpt:placeName"=>"赤坂見附方面改札～１０番出入口",
    "odpt:locatedAreaName"=>"改札外"
  }, {
    "@id"=>"urn:ucode:_00001C000000000000010000030D4EB6",
    "@type"=>"ug:Escalator",
    "owl:sameAs"=>"odpt.StationFacility:TokyoMetro.Marunouchi.KokkaiGijidomae.Outside.Escalator.1",
    "ugsrv:categoryName"=>"エスカレーター",
    "odpt:serviceDetail"=>[
      {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"始発", "ugsrv:serviceEndTime"=>"17:00", "ug:direction"=>"上り"},
      {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"17:00", "ugsrv:serviceEndTime"=>"終車時", "ug:direction"=>"下り"},
      {"odpt:operationDays"=>"土日祝", "ug:direction"=>"上り"}
    ],
    "odpt:placeName"=>"国会議事堂方面改札～１番出入口",
    "odpt:locatedAreaName"=>"改札外"
  }
]



#--------

rake temp:bug_check_of_operation_day_20150630_3

{
  "@id"=>"urn:ucode:_00001C000000000000010000030D4DB9",
  "@type"=>"ug:Escalator", "owl:sameAs"=>"odpt.StationFacility:TokyoMetro.Ginza.AkasakaMitsuke.Outside.Escalator.1",
  "ugsrv:categoryName"=>"エスカレーター",
  "odpt:serviceDetail"=>[
    {"ug:direction"=>"上り・下り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"始発", "ugsrv:serviceEndTime"=>"7:30", "ug:direction"=>"上り・下り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"7:30", "ugsrv:serviceEndTime"=>"10:00", "ug:direction"=>"上り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"10:00", "ugsrv:serviceEndTime"=>"終車時", "ug:direction"=>"上り・下り"}
  ],
  "odpt:placeName"=>"赤坂見附方面改札～地上（１０番出入口）",
  "odpt:locatedAreaName"=>"改札外"
}
{
  "@id"=>"urn:ucode:_00001C000000000000010000030D4DC6",
  "@type"=>"ug:Escalator",
  "owl:sameAs"=>"odpt.StationFacility:TokyoMetro.Marunouchi.AkasakaMitsuke.Outside.Escalator."1,
  "ugsrv:categoryName"=>"エスカレーター",
  "odpt:serviceDetail"=>[
    {"odpt:operationDays"=>"土日祝", "ug:direction"=>"上り・下り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"始発", "ugsrv:serviceEndTime"=>"7:30", "ug:direction"=>"上り・下り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"7:30", "ugsrv:serviceEndTime"=>"10:00", "ug:direction"=>"上り"},
    {"odpt:operationDays"=>"平日", "ugsrv:serviceStartTime"=>"10:00", "ugsrv:serviceEndTime"=>"終車時", "ug:direction"=>"上り・下り"}
  ],
  "odpt:placeName"=>"赤坂見附方面改札～１０番出入口",
  "odpt:locatedAreaName"=>"改札外"
}

#--------

ACCESS_TOKEN = "9790afccf7295b37c2e20ab98092579a9dc7057389d54a2865305e7096b1b0cf"
response = HTTPClient.new.get( "https://api.tokyometroapp.jp/api/v2/datapoints" , { "rdf:type" => "odpt:Train" , "odpt:railway" => "odpt.Railway:TokyoMetro.Namboku" , "acl:consumerKey"=> ACCESS_TOKEN } )
train_locations_of_namboku_line = JSON.parse( response.body )

TokyoMetro::Api::TrainLocation.get( HTTPClient.new , "odpt.Railway:TokyoMetro.Namboku" , generate_instance: true , parse_json: true )

#--------

=> [{"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030DAF0B",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.A2334S",
  "odpt:trainNumber"=>"A2334S",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:Tokyu.Meguro.Hiyoshi",
  "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Namboku.AkabaneIwabuchi",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.RoppongiItchome",
  "odpt:toStation"=>nil,
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.AkabaneIwabuchi",
  "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"},
 {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030CC4FA",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.A2382M",
  "odpt:trainNumber"=>"A2382M",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:Tokyu.Meguro.Hiyoshi",
  "odpt:terminalStation"=>"odpt.Station:SaitamaRailway.SaitamaRailway.Hatogaya",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.Iidabashi",
  "odpt:toStation"=>nil,
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.AkabaneIwabuchi",
  "odpt:trainOwner"=>"odpt.TrainOwner:SaitamaRailway"},
 {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030CC501",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.A2396M",
  "odpt:trainNumber"=>"A2396M",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:TokyoMetro.Namboku.ShirokaneTakanawa",
  "odpt:terminalStation"=>"odpt.Station:SaitamaRailway.SaitamaRailway.UrawaMisono",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.Nishigahara",
  "odpt:toStation"=>"odpt.Station:TokyoMetro.Namboku.Oji",
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.AkabaneIwabuchi",
  "odpt:trainOwner"=>"odpt.TrainOwner:SaitamaRailway"},
 {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030DAEB3",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.B2312K",
  "odpt:trainNumber"=>"B2312K",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:SaitamaRailway.SaitamaRailway.UrawaMisono",
  "odpt:terminalStation"=>"odpt.Station:Tokyu.Meguro.Okusawa",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.Nishigahara",
  "odpt:toStation"=>"odpt.Station:TokyoMetro.Namboku.Komagome",
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Meguro",
  "odpt:trainOwner"=>"odpt.TrainOwner:Tokyu"},
 {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030DAF6C",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.B2314K",
  "odpt:trainNumber"=>"B2314K",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:SaitamaRailway.SaitamaRailway.UrawaMisono",
  "odpt:terminalStation"=>"odpt.Station:Tokyu.Meguro.Hiyoshi",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.Yotsuya",
  "odpt:toStation"=>nil,
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Meguro",
  "odpt:trainOwner"=>"odpt.TrainOwner:Tokyu"},
 {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
  "@type"=>"odpt:Train",
  "@id"=>"urn:ucode:_00001C000000000000010000030CC651",
  "dc:date"=>"2015-06-30T00:12:02+09:00",
  "dct:valid"=>"2015-06-30T00:13:32+09:00",
  "odpt:frequency"=>90,
  "odpt:railway"=>"odpt.Railway:TokyoMetro.Namboku",
  "owl:sameAs"=>"odpt.Train:TokyoMetro.Namboku.B2307K",
  "odpt:trainNumber"=>"B2307K",
  "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local",
  "odpt:delay"=>0,
  "odpt:startingStation"=>"odpt.Station:Toei.Mita.NishiTakashimadaira",
  "odpt:terminalStation"=>"odpt.Station:Tokyu.Meguro.Hiyoshi",
  "odpt:fromStation"=>"odpt.Station:TokyoMetro.Namboku.Shirokanedai",
  "odpt:toStation"=>nil,
  "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Meguro",
  "odpt:trainOwner"=>"odpt.TrainOwner:Tokyu"}]
  