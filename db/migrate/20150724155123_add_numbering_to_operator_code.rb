class AddNumberingToOperatorCode < ActiveRecord::Migration
  def change
    add_column :operator_codes, :numbering, :boolean
  end
end
