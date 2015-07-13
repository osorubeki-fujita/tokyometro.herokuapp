class RenameColumnsOfTrainRelation < ActiveRecord::Migration
  def change
    rename_column :train_relations , :previous_train_timetable_id , :previous_train_timetable_info_id
    rename_column :train_relations , :following_train_timetable_id , :following_train_timetable_info_id
  end
end
