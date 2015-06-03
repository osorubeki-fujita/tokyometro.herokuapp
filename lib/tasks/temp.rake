namespace :temp do
  desc "Add train operation info"
  task :train_operation_info_20150603 => :environment do
    text_1 = "17時38分頃、綾瀬駅で車両点検のため、運転を見合わせていましたが、17時46分頃、運転を再開し、ダイヤが乱れています。 只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。 詳しくは駅係員にお尋ねください。"
    text_2 = "17時38分頃、綾瀬駅で車両点検のため、ダイヤが乱れています。 只今、東京メトロ線、都営地下鉄線、JR線、東急線、東武線、京成線、小田急線、京王線、つくばエクスプレスで振替輸送を実施しています。 詳しくは駅係員にお尋ねください。"

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
end
