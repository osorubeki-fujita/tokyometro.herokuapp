class RenameColumnOfPassengerSurvey < ActiveRecord::Migration
  def change
  rename_column :passenger_surveys , :operator_id , :operator_info_id
  end
end
