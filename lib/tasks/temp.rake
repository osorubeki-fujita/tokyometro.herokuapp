namespace :temp do

  desc "Replace invalid surrounding area info"
  task :surrounding_area_20150603 => :environment do

    dictionary = ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::SurroundingArea::Generate::Info::Platform::Info::SurroundingArea::DICTIONARY
    ::SurroundingArea.all.each do | item |
      if dictionary.keys.include?( item.name )

        valid_name = dictionary[ item.name ]
        valid_in_db = ::SurroundingArea.find_by( name: valid_name )
        unless valid_in_db.present?
          id_of_valid_in_db = ::SurroundingArea.all.pluck( :id ).max + 1
          valid_in_db = ::SurroundingArea.create( name: valid_name , id: id_of_valid_in_db )
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

    ::SurroundingArea.where( name: dictionary.values ).each do | item |
      item.destroy
    end

  end

end

__END__

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

end
