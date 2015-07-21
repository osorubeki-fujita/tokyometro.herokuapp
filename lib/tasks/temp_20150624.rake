namespace :temp do
  task :create_romance_car_info_20150624 => :environment do
    id_new = ::Train::Type::Info.all.pluck(:id).max + 1
    same_as_new = "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Standard"

    railway_line_info = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
    train_type_in_api = ::Train::Type::InApi.find_by( same_as: "odpt.TrainType:TokyoMetro.RomanceCar" )

    romance_car_normal = ::Train::Type::Info.find_by( same_as: "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" )
    raise unless railway_line_info.present?
    raise unless train_type_in_api.present?
    raise unless romance_car_normal.present?
    raise if ::Train::Type::Info.find_by( same_as: same_as_new ).present?
    ::Train::Type::Info.create( id: id_new , railway_line_info: railway_line_info.id , in_api_id: train_type_in_api.id , same_as: same_as_new , note: romance_car_normal.note , bgcolor: "\#ff0000" , color: "\#ffffff" )
  end
end
