# coding: utf-8

namespace :temp do
  task :destroy_romance_car_standard_info_20150624 => :environment do
    info_to_destroy_same_as = "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Standard"
    t = ::TrainType.find_by( same_as: info_to_destroy_same_as )
    raise unless t.present?
    t.destroy
  end
end
