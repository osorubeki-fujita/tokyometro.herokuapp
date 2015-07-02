# puts "train_operation_info"

describe TokyoMetro::Api::TrainOperation::Info do
  ginza_line = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Ginza" )
  hanzomon_line = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Hanzomon" )

  it "delays when the delay time is longer than 300 seconds." do
    train_operation_info_on_ginza_line_on_schedule = ::TokyoMetro::Factory::Generate::Api::TrainOperation::Info.process({
      "@context"=>"http://vocab.tokyometroapp.jp/context_odpt_TrainInformation.json",
      "@id"=>"urn:ucode:_00001C000000000000010000030C3BE4",
      "dc:date"=>"2015-06-28T17:30:02+09:00",
      "dct:valid"=>"2015-06-28T17:35:02+09:00",
      "odpt:operator"=>"odpt.Operator:TokyoMetro",
      "odpt:railway"=>"odpt.Railway:TokyoMetro.Ginza",
      "odpt:timeOfOrigin"=>"2015-06-07T17:22:00+09:00",
      "odpt:trainInformationText"=>"現在、平常どおり運転しています。",
      "@type"=>"odpt:TrainInformation"
    })

    delay_time = 300
    train_operation_info_ginza_decorated = train_operation_info_on_ginza_line_on_schedule.decorate( nil , ginza_line , delay_time , :train_operation , false )

    # puts train_operation_info_ginza_decorated.inspect
    # puts train_operation_info_ginza_decorated.object.train_operation_status.inspect
    # puts train_operation_info_ginza_decorated.object.train_operation_text.inspect
    # puts train_operation_info_ginza_decorated.render

    expect( train_operation_info_ginza_decorated.object ).to be_on_schedule
    expect( train_operation_info_ginza_decorated.object ).not_to be_delayed
    expect( train_operation_info_ginza_decorated.instance_variable_get( :@status_type ) ).to eq( :delayed )
    expect( train_operation_info_ginza_decorated.instance_variable_get( :@status_type ) ).not_to eq( :other_status )

    expect( train_operation_info_ginza_decorated.send( :on_schedule? ) ).to be false
    expect( train_operation_info_ginza_decorated.send( :nearly_on_schedule? ) ).to be false
    expect( train_operation_info_ginza_decorated.send( :delayed? ) ).to be true
    expect( train_operation_info_ginza_decorated.send( :actually_delayed? ) ).to be true

    expect( train_operation_info_ginza_decorated.additional_info_abstruct_ja ).to be_nil
    expect( train_operation_info_ginza_decorated.additional_info_abstruct_en ).to be_nil
  end

  it "has resumed but behind schedule." do
    train_operation_info_on_hanzomon_line_behind_schedule = ::TokyoMetro::Factory::Generate::Api::TrainOperation::Info.process({
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
    })
    delay_time = nil
    train_operation_info_hanzomon_decorated = train_operation_info_on_hanzomon_line_behind_schedule.decorate( nil , hanzomon_line , delay_time , :train_operation , true )

    # puts train_operation_info_hanzomon_decorated.inspect
    # puts train_operation_info_hanzomon_decorated.object.train_operation_status.inspect
    # puts train_operation_info_hanzomon_decorated.object.train_operation_text.inspect
    # puts train_operation_info_hanzomon_decorated.render_status_additional_infos

    expect( train_operation_info_hanzomon_decorated.object ).not_to be_on_schedule
    expect( train_operation_info_hanzomon_decorated.object ).to be_delayed
    expect( train_operation_info_hanzomon_decorated.instance_variable_get( :@status_type ) ).to eq( :delayed )
    expect( train_operation_info_hanzomon_decorated.instance_variable_get( :@status_type ) ).not_to eq( :other_status )

    expect( train_operation_info_hanzomon_decorated.send( :on_schedule? ) ).to be false
    expect( train_operation_info_hanzomon_decorated.send( :nearly_on_schedule? ) ).to be false
    expect( train_operation_info_hanzomon_decorated.send( :delayed? ) ).to be true
    expect( train_operation_info_hanzomon_decorated.send( :actually_delayed? ) ).to be false

    expect( train_operation_info_hanzomon_decorated.additional_info_abstruct_ja ).to be_present
    expect( train_operation_info_hanzomon_decorated.additional_info_abstruct_en ).to be_present
  end

end
