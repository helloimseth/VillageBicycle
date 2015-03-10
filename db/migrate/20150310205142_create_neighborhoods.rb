class CreateNeighborhoods < ActiveRecord::Migration
  def change
    create_table :neighborhoods do |t|
      t.integer :frame_size, null: false
      t.string :suggested_height, null: false
      
      t.timestamps
    end
  end
end
