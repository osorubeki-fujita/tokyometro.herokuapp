class AddTwitterAccountToRailwayLine < ActiveRecord::Migration
  def change
    add_column :railway_lines, :twitter_account, :string
  end
end
