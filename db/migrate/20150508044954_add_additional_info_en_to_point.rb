class AddAdditionalInfoEnToPoint < ActiveRecord::Migration
  def change
    add_column :points, :additional_info_en, :string
    rename_column :points , :additional_info , :additional_info_ja
  end
end
