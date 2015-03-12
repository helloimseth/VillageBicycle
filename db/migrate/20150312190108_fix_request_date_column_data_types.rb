class FixRequestDateColumnDataTypes < ActiveRecord::Migration
  def change
    remove_column :requests, :start
    remove_column :requests, :end

    add_column :requests, :start, :datetime
    add_column :requests, :end, :datetime
  end
end
