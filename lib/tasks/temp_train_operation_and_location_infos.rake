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

__END__

# train_location_infos_on_hanzomon_line_20150625

2015-06-25 08:17:56 +0900
[
  {
    "@context"=>"http://vocab.tokyometroapp.jp/context_odpt_TrainInformation.json",
    "@id"=>"urn:ucode:_00001C000000000000010000030C3BE5",
    "dc:date"=>"2015-06-25T08:15:02+09:00",
    "dct:valid"=>"2015-06-25T08:20:02+09:00",
    "odpt:operator"=>"odpt.Operator:TokyoMetro",
    "odpt:railway"=>"odpt.Railway:TokyoMetro.Hanzomon",
    "odpt:timeOfOrigin"=>"2015-06-25T07:14:00+09:00",
    "odpt:trainInformationStatus"=>"ダイヤ乱れ",
    "odpt:trainInformationText"=>"6時35分頃、東急田園都市線 たまプラーザ駅で人身事故のため、ダイヤが乱れています。この影響で女性専用車両を中止しています。只今、東京メトロ線、都営地下鉄線、ＪＲ線、東武線に振替輸送を実施しています。詳しくは、駅係員にお尋ねください。",
    "@type"=>"odpt:TrainInformation"
  }
]
[]

# train_location_infos_on_hibiya_line_20150630

2015-06-30 18:25:28 +0900
[{"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_TrainInformation.json", "@id"=>"urn:ucode:_00001C000000000000010000030C3BE6", "dc:date"=>"2015-06-30T18:25:02+09:00", "dct:valid"=>"2015-06-30T18:30:02+09:00", "odpt:operator"=>"odpt.Operator:TokyoMetro", "odpt:railway"=>"odpt.Railway:TokyoMetro.Hibiya", "odpt:timeOfOrigin"=>"2015-06-30T17:47:00+09:00", "odpt:trainInformationStatus"=>"折返し運転", "odpt:trainInformationText"=>"17時26分頃、築地駅で人身事故のため、折返し運転を行っています。全線での運転再開は、18時30分頃を見込んでいます。折返し運転区間　北千住〜八丁堀駅間　霞ケ関〜中目黒駅間只今、東京メトロ線、都営地下鉄線、ＪＲ線、東急線、東武線、京成線、つくばエクスプレス線に振替輸送を実施しています。詳しくは、駅係員にお尋ねください。", "@type"=>"odpt:TrainInformation"}]
[]

# train_location_infos_of_romance_car

2015-06-30 19:06:05 +0900
[
  {
    "@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld",
    "@type"=>"odpt:Train",
    "@id"=>"urn:ucode:_00001C000000000000010000030CB124",
    "dc:date"=>"2015-06-30T19:06:08+09:00",
    "dct:valid"=>"2015-06-30T19:07:38+09:00",
    "odpt:frequency"=>90,
    "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda",
    "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1832E",
    "odpt:trainNumber"=>"A1832E",
    "odpt:trainType"=>"odpt.TrainType:TokyoMetro.RomanceCar",
    "odpt:delay"=>0,
    "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaSenju",
    "odpt:terminalStation"=>"odpt.Station:Odakyu.Tama.Karakida",
    "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.OmoteSando",
    "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.MeijiJingumae",
    "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara",
    "odpt:trainOwner"=>"odpt.TrainOwner:Odakyu"
  }
]

# train_location_infos_on_chiyoda_line_20150701



#<TokyoMetro::Api::TrainLocation::Info:0xae40428 @id_urn="urn:ucode:_00001C000000000000010000030DB032", @same_as="odpt.Train:TokyoMetro.Chiyoda.B0959S", @frequency=90, @valid=Wed, 01 Jul 2015 10:54:03 +0900, @dc_date=Wed, 01 Jul 2015 10:52:33 +0900, @train_type="odpt.TrainType:TokyoMetro.Local", @train_number="B0959S", @railway_direction="odpt.RailDirection:TokyoMetro.KitaAyase", @train_owner="odpt.TrainOwner:TokyoMetro", @railway_line="odpt.Railway:TokyoMetro.Chiyoda", @delay=780, @terminal_station="odpt.Station:TokyoMetro.Chiyoda.KitaAyase", @starting_station="odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", @from_station="odpt.Station:TokyoMetro.Chiyoda.KitaSenju", @to_station="odpt.Station:TokyoMetro.Chiyoda.Ayase">

2015-07-01 10:58:29 +0900
[
  {
    "@context"=>"http://vocab.tokyometroapp.jp/context_odpt_TrainInformation.json",
    "@id"=>"urn:ucode:_00001C000000000000010000030C3BE2",
    "dc:date"=>"2015-07-01T10:55:02+09:00",
    "dct:valid"=>"2015-07-01T11:00:02+09:00",
    "odpt:operator"=>"odpt.Operator:TokyoMetro",
    "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda",
    "odpt:timeOfOrigin"=>"2015-07-01T10:24:00+09:00",
    "odpt:trainInformationStatus"=>"一部列車遅延",
    "odpt:trainInformationText"=>"8時26分頃、大手町駅でホーム上の安全確認のため、一部の列車に遅れが出ています。",
    "@type"=>"odpt:TrainInformation"
  }
]
[{"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB067", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1098S3", "odpt:trainNumber"=>"A1098S3", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaAyase", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaAyase", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030DAFFC", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1053S", "odpt:trainNumber"=>"A1053S", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaSenju", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1C6", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1093E", "odpt:trainNumber"=>"A1093E", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaSenju", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.Machiya", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:Odakyu"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1C5", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1089S", "odpt:trainNumber"=>"A1089S", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.TamaExpress", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:terminalStation"=>"odpt.Station:Odakyu.Tama.Karakida", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.NishiNippori", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.Sendagi", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1C4", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1007K", "odpt:trainNumber"=>"A1007K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Yushima", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.ShinOchanomizu", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030DAFFB", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1029K", "odpt:trainNumber"=>"A1029K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Nijubashimae", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1C2", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1091E", "odpt:trainNumber"=>"A1091E", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase","odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.KokkaiGijidomae", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:Odakyu"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030DAFFA", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A0933K", "odpt:trainNumber"=>"A0933K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Nogizaka", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.OmoteSando", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1C0", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A1097E", "odpt:trainNumber"=>"A1097E", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.MeijiJingumae", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiKoen", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:Odakyu"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB1BF", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.A0941S", "odpt:trainNumber"=>"A0941S", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.TamaExpress", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:terminalStation"=>"odpt.Station:Odakyu.Tama.Karakida", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.YoyogiUehara", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB360", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1005K", "odpt:trainNumber"=>"B1005K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaAyase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.KitaAyase", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB35F", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1013K", "odpt:trainNumber"=>"B1013K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.MeijiJingumae", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB35E", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1090E", "odpt:trainNumber"=>"B1090E", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Akasaka", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:Odakyu"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CAFCF", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1065S", "odpt:trainNumber"=>"B1065S", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Kasumigaseki", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB35C", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1027K", "odpt:trainNumber"=>"B1027K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Otemachi", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB35B", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B0985S", "odpt:trainNumber"=>"B0985S", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:Odakyu.Tama.Karakida", "odpt:terminalStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Yushima", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB35A", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1031K", "odpt:trainNumber"=>"B1031K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Sendagi", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.NishiNippori", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030CB359", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1015K", "odpt:trainNumber"=>"B1015K", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara", "odpt:terminalStation"=>"odpt.Station:JR-East.Joban.Abiko", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Machiya", "odpt:toStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaSenju", "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.Ayase", "odpt:trainOwner"=>"odpt.TrainOwner:JR-East"}, {"@context"=>"http://vocab.tokyometroapp.jp/context_odpt_Train.jsonld", "@type"=>"odpt:Train", "@id"=>"urn:ucode:_00001C000000000000010000030DB001", "dc:date"=>"2015-07-01T10:57:34+09:00", "dct:valid"=>"2015-07-01T10:59:04+09:00", "odpt:frequency"=>90, "odpt:railway"=>"odpt.Railway:TokyoMetro.Chiyoda", "owl:sameAs"=>"odpt.Train:TokyoMetro.Chiyoda.B1096S4", "odpt:trainNumber"=>"B1096S4", "odpt:trainType"=>"odpt.TrainType:TokyoMetro.Local", "odpt:delay"=>0, "odpt:startingStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:terminalStation"=>"odpt.Station:TokyoMetro.Chiyoda.KitaAyase", "odpt:fromStation"=>"odpt.Station:TokyoMetro.Chiyoda.Ayase", "odpt:toStation"=>nil, "odpt:railDirection"=>"odpt.RailDirection:TokyoMetro.KitaAyase", "odpt:trainOwner"=>"odpt.TrainOwner:TokyoMetro"}]