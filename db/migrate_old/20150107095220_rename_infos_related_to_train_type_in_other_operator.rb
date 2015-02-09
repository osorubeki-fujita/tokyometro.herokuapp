class RenameInfosRelatedToTrainTypeInOtherOperator < ActiveRecord::Migration
  def change
    rename_table :timetable_train_type_in_other_operators , :train_timetable_train_type_in_other_operators
    rename_column :train_timetables , :timetable_train_type_in_other_operator_id , :train_timetable_train_type_in_other_operator_id
  end
end