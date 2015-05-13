class AddNameEnToPointCategory < ActiveRecord::Migration
  def change
    add_column :point_categories, :name_en, :string
  end
end
