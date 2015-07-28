class AddCodeToRailwayLineCodeInfo < ActiveRecord::Migration
  def change
    add_column :railway_line_code_infos , :code , :string
  end
end
