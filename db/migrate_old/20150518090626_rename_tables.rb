class RenameTables < ActiveRecord::Migration
  def change
    rename_table "train_informations" , "train_operation_infos"
    rename_table "train_information_olds" , "train_operation_old_infos"
    rename_table "train_information_statuses" , "train_operation_statuses"
    rename_table "train_information_texts" , "train_operation_texts"
  end
end
