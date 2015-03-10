class AddUserIdToNeighborhoods < ActiveRecord::Migration
  def change
    add_column :neighborhoods, :user_id, :integer
  end
end
