class DropSizesTable < ActiveRecord::Migration
  def change
    drop_table :sizes
  end
end
