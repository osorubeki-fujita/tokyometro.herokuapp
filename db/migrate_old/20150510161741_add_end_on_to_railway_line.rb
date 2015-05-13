class AddEndOnToRailwayLine < ActiveRecord::Migration
  def change
    add_column :railway_lines, :end_on, :datetime
  end
end
