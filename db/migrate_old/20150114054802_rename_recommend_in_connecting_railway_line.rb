class RenameRecommendInConnectingRailwayLine < ActiveRecord::Migration
  def change
    rename_column :connecting_railway_lines , :not_recommend , :not_recommended
  end
end
