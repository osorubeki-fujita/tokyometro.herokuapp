class AddEndOnToConnectingRailwayLine < ActiveRecord::Migration
  def change
    add_column :connecting_railway_lines, :end_on, :datetime
  end
end
