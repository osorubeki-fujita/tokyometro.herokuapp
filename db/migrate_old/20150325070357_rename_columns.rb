class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :connecting_railway_lines , :station_id , :station_info_id
    rename_column :connecting_railway_lines , :connecting_station_id , :connecting_station_info_id
    
    rename_column :fares , :from_station_id , :from_station_info_id
    rename_column :fares , :to_station_id , :to_station_info_id
    
    rename_column :passenger_surveys , :station_id , :station_info_id
    
    rename_column :railway_directions , :station_id , :station_info_id
    
    rename_column :station_name_aliases , :station_id , :station_info_id
    
    rename_column :station_passenger_surveys , :station_id , :station_info_id
    
    rename_column :station_points , :station_id , :station_info_id
    
    rename_column :station_stopping_patterns , :station_id , :station_info_id
    
    rename_column :station_timetable_connection_infos , :station_id , :station_info_id
    
    rename_column :station_timetable_fundamental_infos , :station_id , :station_info_id
    
    rename_column :station_timetable_starting_station_infos , :station_id , :station_info_id
    
    rename_column :station_train_times , :departure_station_id , :departure_station_info_id
    rename_column :station_train_times , :arrival_station_id , :arrival_station_info_id
    
    rename_column :train_location_olds , :from_station_id , :from_station_info_id
    rename_column :train_location_olds , :to_station_id , :to_station_info_id
    
    rename_column :train_locations , :from_station_id , :from_station_info_id
    rename_column :train_locations , :to_station_id , :to_station_info_id
    
    rename_column :train_timetable_arrival_infos , :station_id , :station_info_id
    rename_column :train_timetable_train_type_in_other_operators , :from_station_id , :from_station_info_id
    
    rename_column :train_timetables , :starting_station_id , :starting_station_info_id
    rename_column :train_timetables , :terminal_station_id , :terminal_station_info_id
    
    rename_column :travel_time_infos , :from_station_id , :from_station_info_id
    rename_column :travel_time_infos , :to_station_id , :to_station_info_id
    
    rename_column :women_only_car_infos , :from_station_id , :from_station_info_id
    rename_column :women_only_car_infos , :to_station_id , :to_station_info_id
  end
end
