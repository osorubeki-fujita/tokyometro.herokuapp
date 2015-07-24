class AddNumberingToRailwayLineCode < ActiveRecord::Migration
  def change
    add_column :railway_line_codes, :numbering, :boolean
  end
end
