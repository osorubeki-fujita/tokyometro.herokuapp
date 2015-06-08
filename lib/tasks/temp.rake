namespace :temp do

  task :update_station_facility_in_kasumigaseki_20150609 => :environment do
    c_escalator_4 = "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.4"
    c_escalator_5 = "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.5"

    invalid_service_detail_pattern_id = nil
    barrier_free_facility_info_ids = []

    [ c_escalator_4 , c_escalator_5 ].each do | escalator_name |
      escalator = ::BarrierFreeFacility::Info.find_by( same_as: escalator_name )
      barrier_free_facility_info_ids << escalator.id
      raise unless escalator.present?
      escalator.service_details.each do | detail_info |
        pattern = detail_info.barrier_free_facility_service_detail_pattern

        if pattern.operation_day.blank?
          if invalid_service_detail_pattern_id.blank?
            invalid_service_detail_pattern_id = pattern.id
          else
            unless invalid_service_detail_pattern_id == pattern.id
              raise
            end

          end
        end

      end
    end

    barrier_free_facility_info_ids.sort!
    puts "barrier_free_facility_info_ids: #{ barrier_free_facility_info_ids.to_s }"
    puts "invalid_service_detail_pattern_id: #{ invalid_service_detail_pattern_id }"

    barrier_free_facility_info_ids_of_invalid_pattern = ::BarrierFreeFacilityServiceDetailPattern.find( invalid_service_detail_pattern_id ).barrier_free_facility_infos.pluck( :id ).sort
    puts "barrier_free_facility_info_ids_of_invalid_pattern: #{ barrier_free_facility_info_ids_of_invalid_pattern }"

    operation_day_new = ::OperationDay.find_by( name_ja: "平日" )
    invalid_pattern = ::BarrierFreeFacilityServiceDetailPattern.find( invalid_service_detail_pattern_id )

    if barrier_free_facility_info_ids_of_invalid_pattern == barrier_free_facility_info_ids
      puts "Update - Begin"
      raise unless operation_day_new.present?
      invalid_pattern.update( operation_day_id: operation_day_new.id )
      puts "Update - Complete"
    else

      puts "Create new instance - Begin"
      h_for_new_pattern_instance = {
        operation_day_id: operation_day_new.id ,
        service_start_before_first_train: invalid_pattern.service_start_before_first_train ,
        service_start_time_hour: invalid_pattern.service_start_time_hour ,
        service_start_time_min: invalid_pattern.service_start_time_min ,
        service_end_time_hour: invalid_pattern.service_end_time_hour ,
        service_end_time_min: invalid_pattern.service_end_time_min ,
        service_end_after_last_train: invalid_pattern.service_end_after_last_train
      }

      new_pattern_instance = ::BarrierFreeFacilityServiceDetailPattern.find_by( h_for_new_pattern_instance )
      unless new_pattern_instance.present?
        new_pattern_instance = ::BarrierFreeFacilityServiceDetailPattern.create( h_for_new_pattern_instance )
      end

      ::BarrierFreeFacilityServiceDetail.where(
        barrier_free_facility_info_id: barrier_free_facility_info_ids ,
        barrier_free_facility_service_detail_pattern_id: invalid_service_detail_pattern_id
      ).to_a.each do | service_detail |
        service_detail.update( barrier_free_facility_service_detail_pattern_id: new_pattern_instance.id )
      end

      puts "Create new instance - Complete"
    end
  end

end

__END__

namespace :temp do

  task :debug_kasumigaseki_and_ginza_20150608 => :environment do
    puts "debug_kasumigaseki_and_ginza_20150608"

    h = ::Hash.new
    sleep(10)
    http_client = ::HTTPClient.new
    [ :connect_timeout , :send_timeout , :receive_timeout ].each do | timeout_type |
      http_client.send( "#{ timeout_type }=" , 300 )
    end

    sleep(10)
    [ :kasumigaseki , :ginza ].each do | sta |
      unless h[ sta ].present?
        h[ sta ] = ::Hash.new
      end
      h[ sta ][ :json ] = ::TokyoMetro::Api::StationFacility.get( http_client , same_as: "odpt.stationFacility:TokyoMetro.#{ sta.capitalize }" , perse_json: true ).first
      sleep(1)
      h[ sta ][ :instance ] = ::TokyoMetro::Api::StationFacility.get( http_client , same_as: "odpt.stationFacility:TokyoMetro.#{ sta.capitalize }" , perse_json: true , generate_instance: true ).first
      sleep(1)
    end

    c_escalator_4 = "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.4"
    c_escalator_5 = "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.5"

    [ c_escalator_4 , c_escalator_5 ].each do | escalator |
      puts "-" * 4
      puts ""
      puts h[ :kasumigaseki ][ :json ][ "odpt:barrierfreeFacility" ].find { | item | item[ "owl:sameAs" ] == escalator }.inspect
      puts ""
      puts h[ :kasumigaseki ][ :instance ].barrier_free_facilities.find { | item | item.same_as == escalator }.inspect
      puts ""
    end

    k_h_escalator_2 = "odpt.StationFacility:TokyoMetro.Hibiya.Ginza.Inside.Escalator.2"

    puts "-" * 4
    puts ""
    puts h[ :ginza ][ :json ][ "odpt:barrierfreeFacility" ].find { | item | item[ "owl:sameAs" ] == k_h_escalator_2 }.inspect
    puts ""
    puts h[ :ginza ][ :instance ].barrier_free_facilities.find { | item | item.same_as == k_h_escalator_2 }.inspect
    puts ""
  end

end



namespace :temp do

  task :connecting_railway_line_note_20150605 => :environment do
    info = ::ConnectingRailwayLine::Note.find_by( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から副都心線に乗り換えると移動距離が少なく便利です。" )
    raise "Error" unless info.present?
    info.update( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から東急東横線に乗り換えると移動距離が少なく便利です。" )
  end

  task :reset_train_operation_text_id => :environment do
    ::TrainOperation::Text.all.to_a.each.with_index(1) do | item , i |
      unless item.id == i
        item.update( id: i )
      end
    end
  end

  task :surrounding_area_20150603_bugfix_on_development => :environment do
    [
      {
        station_facility_same_as: "odpt.StationFacility:TokyoMetro.OmoteSando" ,
        invalid_surrounding_area_name: "東武東上線下赤塚駅" ,
        valid_surrounding_area: "青山劇場"
      } ,
      {
        station_facility_same_as: "odpt.StationFacility:TokyoMetro.Toranomon" ,
        invalid_surrounding_area_name: "虎ノ門病院" ,
        valid_surrounding_area: "虎の門病院"
      } ,
      {
        station_facility_same_as: "odpt.StationFacility:TokyoMetro.ChikatetsuAkatsuka" ,
        invalid_surrounding_area_name: "東武東上線赤塚駅" ,
        valid_surrounding_area: "東武東上線下赤塚駅"
      } ,
      {
        station_facility_same_as: "odpt.StationFacility:TokyoMetro.HigashiIkebukuro" ,
        invalid_surrounding_area_name: "虎の門病院" ,
        valid_surrounding_area: "都電荒川線東池袋四丁目停留場"
      }
    ].each do | set |

      platform_info_surrounding_areas = ::StationFacility::Info.find_by( same_as: set[ :station_facility_same_as ] ).station_facility_platform_info_surrounding_areas

      platform_info_surrounding_areas.each do | item |
        if item.surrounding_area.present? and item.surrounding_area.name == set[ :invalid_surrounding_area_name ]
          valid_surrounding_area = ::SurroundingArea.find_by( name: set[ :valid_surrounding_area ] )
          item.update( surrounding_area_id: valid_surrounding_area.id )
        elsif item.surrounding_area.blank?
          valid_surrounding_area = ::SurroundingArea.find_by( name: set[ :valid_surrounding_area ] )
          item.update( surrounding_area_id: valid_surrounding_area.id )
        end
      end

    end
  end

  task :surrounding_area_20150603_1 => :environment do

    dictionary = ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::SurroundingArea::Generate::Info::Platform::Info::SurroundingArea::DICTIONARY
    dictionary.values.each do | name_ja |
      unless ::SurroundingArea.find_by( name_ja: name_ja ).present?
        id_new = ::SurroundingArea.all.pluck( :id ).max + 1
        ::SurroundingArea.create( name_ja: name_ja , id: id_new )
      end
    end

  end

  desc "Replace invalid surrounding area info"
  task :surrounding_area_20150603_2 => :environment do

    dictionary = ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::SurroundingArea::Generate::Info::Platform::Info::SurroundingArea::DICTIONARY
    ::SurroundingArea.all.each do | item |
      if dictionary.keys.include?( item.name )

        valid_name = dictionary[ item.name ]
        valid_in_db = ::SurroundingArea.find_by( name_ja: valid_name )
        unless valid_in_db.present?
          id_of_valid_in_db = ::SurroundingArea.all.pluck( :id ).max + 1
          valid_in_db = ::SurroundingArea.create( name_ja: valid_name , id: id_of_valid_in_db )
        end

        # puts "-" * 4
        # puts item.name
        # puts valid_name
        # puts valid_in_db

        item.station_facility_platform_info_surrounding_areas.each do | joint_item |
          joint_item.update( surrounding_area_id: valid_in_db.id )
        end

      end
    end

    ::SurroundingArea.where( name_ja: dictionary.keys ).each do | item |
      item.destroy
    end

  end

end

namespace :temp do

  desc "Replace invalid surrounding area info"
  task :surrounding_area_20150601 => :environment do
    toranomon_hospital_invalid = ::SurroundingArea.find_by( name: "虎ノ門病院" )
    toranomon_hospital_valid = ::SurroundingArea.find_by( name: "虎の門病院" )
    toranomon_hospital_invalid.station_facility_platform_info_surrounding_areas.each do | item |
      item.update( surrounding_area_id: toranomon_hospital_valid.id )
    end
    toranomon_hospital_invalid.destroy
  end

#--------

  desc "Add train operation info"
  task :train_operation_info_20150603_1 => :environment do
    text_1 = "17時38分頃、綾瀬駅で車両点検のため、運転を見合わせていましたが、17時46分頃、運転を再開し、ダイヤが乱れています。 只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。 詳しくは駅係員にお尋ねください。"
    text_2 = "17時38分頃、綾瀬駅で車両点検のため、ダイヤが乱れています。\n只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。\n詳しくは駅係員にお尋ねください。"

    text_2_in_db = ::TrainOperation::Text.find_by( in_api: text_2 )

    raise "Error" unless text_2_in_db.present?
    text_2_old_id = text_2_in_db.id

    if text_2_old_id == ::TrainOperation::Text.pluck(:id).max
      text_2_new_id = text_2_old_id + 1
    else
      text_2_new_id = ::TrainOperation::Text.pluck(:id).max + 1
    end

    text_2_in_db.update( id: text_2_new_id )
    text_1_in_db = ::TrainOperation::Text.create( in_api: text_1 , id: text_2_old_id )
  end

#--------

  desc "Update train operation info"
  task :train_operation_info_20150603_2 => :environment do
    text_1_old = "17時38分頃、綾瀬駅で車両点検のため、運転を見合わせていましたが、17時46分頃、運転を再開し、ダイヤが乱れています。 只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。 詳しくは駅係員にお尋ねください。"
    text_1_new = "17時38分頃、綾瀬駅で車両点検のため、運転を見合わせていましたが、17時46分頃、運転を再開し、ダイヤが乱れています。\n只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。\n詳しくは駅係員にお尋ねください。"
    text_1_in_db = ::TrainOperation::Text.find_by( in_api: [ text_1_old , text_1_new ] )
    raise "Error" unless text_1_in_db.present?
    text_1_in_db.update( in_api: text_1_new )
  end

  task :train_operation_info_20150603_3 => :environment do
    text = "17時38分頃、綾瀬駅で車両点検のため、一部の列車に遅れが出ています。\n只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。\n詳しくは駅係員にお尋ねください。"
    unless ::TrainOperation::Text.find_by( in_api: text ).present?
      text_id = ::TrainOperation::Text.pluck(:id).max + 1
      ::TrainOperation::Text.create( in_api: text , id: text_id )
    end
  end

end
