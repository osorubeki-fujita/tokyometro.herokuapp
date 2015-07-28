class RenameNoteInfoIdInTrainTypeNoteAdditionalInfo < ActiveRecord::Migration
  def change
    rename_column :train_type_note_additional_infos , :note_info_id , :info_id
  end
end
