namespace :temp do
  task :connecting_railway_line_note_20150605 => :environment do
    info = ::ConnectingRailwayLine::Note.find_by( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から副都心線に乗り換えると移動距離が少なく便利です。" )
    info.update( ja: "銀座線から東急東横線へ乗り換える場合は、表参道駅で半蔵門線に乗り換えの上、渋谷駅で半蔵門線から東急東横線に乗り換えると移動距離が少なく便利です。" )
  end
end

__END__


namespace :temp do

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
