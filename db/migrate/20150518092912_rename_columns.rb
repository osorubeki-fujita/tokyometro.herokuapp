class RenameColumns < ActiveRecord::Migration
  def change
    rename_column "train_operation_infos" , "train_information_status_id" , "status_id"
    rename_column "train_operation_infos" , "train_information_text_id" , "text_id"
    rename_column "train_operation_old_infos" , "train_information_status_id" , "status_id"
    rename_column "train_operation_old_infos" , "train_information_text_id" , "text_id"
  end
end
