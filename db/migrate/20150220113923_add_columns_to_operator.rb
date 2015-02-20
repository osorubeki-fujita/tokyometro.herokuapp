class AddColumnsToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :twitter_widget_id, :integer
    add_column :operators, :twitter_account, :string
  end
end
