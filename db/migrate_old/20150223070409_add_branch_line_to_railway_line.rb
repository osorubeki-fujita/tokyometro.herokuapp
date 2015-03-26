class AddBranchLineToRailwayLine < ActiveRecord::Migration
  def change
    add_column :railway_lines, :is_branch_railway_line, :boolean
    add_column :railway_lines, :main_railway_line_id, :integer
    add_column :railway_lines, :has_branch_railway_line, :boolean
    add_column :railway_lines, :branch_railway_line_id, :integer
  end
end
