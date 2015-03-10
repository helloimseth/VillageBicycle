class AddSizeAndNeighborhoodIdsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :size_id, :integer
    add_column :users, :neighborhood_id, :integer
  end
end
