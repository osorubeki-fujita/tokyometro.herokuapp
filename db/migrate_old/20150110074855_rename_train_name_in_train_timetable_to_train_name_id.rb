class RenameTrainNameInTrainTimetableToTrainNameId < ActiveRecord::Migration
  def change
    remove_column :train_timetables , :train_name
    add_column :train_timetables , :train_name_id , :integer
  end
end