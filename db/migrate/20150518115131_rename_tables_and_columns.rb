class RenameTablesAndColumns < ActiveRecord::Migration
  def change
    rename_column "air_conditioner_infos" , "air_conditioner_answer_id" , "answer_id"
    rename_column "rsses" , "rss_category_id" , "category_id"

    add_column "air_conditioner_infos" , "train_location_data_id" , "integer"
    add_column "air_conditioner_infos" , "train_location_data_type" , "string"
    remove_column "air_conditioner_infos" , "train_id"

    rename_table "train_locations" , "train_location_infos"
    rename_table "train_location_olds" , "train_location_old_infos"
    rename_table "rsses" , "rss_infos"
  end
end
