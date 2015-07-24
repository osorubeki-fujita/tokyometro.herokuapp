class AddInfoIdToOperatorCode < ActiveRecord::Migration
  def change
    add_column :operator_codes, :info_id, :integer
  end
end
