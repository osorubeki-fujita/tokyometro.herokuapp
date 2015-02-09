class AddRailwayDirectionCodeToRailwayDirection < ActiveRecord::Migration
  def change
    add_column :railway_directions, :railway_direction_code, :string
  end
end
