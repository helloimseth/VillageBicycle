class ChangeColumnsInSizes < ActiveRecord::Migration
  def change
    change_column :sizes, :frame_size, :integer
    add_column :sizes, :ownable_id, :integer
    add_column :sizes, :ownable_type, :string

    add_index :sizes, :ownable_id
  end
end
