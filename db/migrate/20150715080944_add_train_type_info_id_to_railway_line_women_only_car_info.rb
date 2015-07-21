class AddTrainTypeInfoIdToRailwayLineWomenOnlyCarInfo < ActiveRecord::Migration
  def change
    add_column :railway_line_women_only_car_infos, :train_type_info_id, :integer
  end
end
