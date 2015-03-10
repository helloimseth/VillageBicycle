class AddColumnsToSizes < ActiveRecord::Migration
  def change
    add_column :sizes, :frame_size, :integer, null: false
    add_column :sizes, :suggested_height, :string, null: false
  end
end
